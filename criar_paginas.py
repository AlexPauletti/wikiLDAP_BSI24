#!/usr/bin/env python3
"""Cria as paginas de teste na Wiki.js via API GraphQL.

Antes: Administracao > API Access > "Enable API" > New API Key (acesso total, 1 dia basta).
Uso:
  export WIKI_TOKEN="<chave>"
  python3 criar_paginas.py --dry-run        # so lista o que seria criado
  python3 criar_paginas.py                  # cria
  python3 criar_paginas.py --apagar-antigas # apaga so as paginas do esquema antigo (.../geral e .../home)
Opcoes: --url http://localhost/graphql  --locale pt-br
"""
import argparse, json, os, sys, urllib.request

# (caminho, titulo, texto)
PAGINAS = [
 ("pmbc", "Informações gerais da Prefeitura", "Normas e comunicados válidos para **todos os departamentos** da Prefeitura. Horário de expediente, calendário de feriados e canais oficiais de atendimento."),
 ("pmbc/searp", "SEARP – Informações gerais", "Documentos comuns a todos os setores da Secretaria de Articulação Política e Relações Institucionais."),
 ("pmbc/searp/decc", "DECC – Início", "Página inicial do Departamento da Casa dos Conselhos."),
 ("pmbc/searp/decc/agenda-conselhos", "DECC – Agenda dos conselhos", "Procedimento para **agendar reunião de conselho** na Casa dos Conselhos: solicitar a sala, confirmar a pauta e enviar a convocação."),
 ("pmbc/searp/decc/ata-modelo", "DECC – Modelo de ata", "Modelo padrão de **ata** de reunião de conselho, com cabeçalho, presentes, deliberações e assinaturas."),
 ("pmbc/seduc", "SEDUC – Informações gerais", "Documentos comuns a toda a Secretaria Municipal de Educação: calendário escolar e orientações pedagógicas gerais."),
 ("pmbc/seduc/cem", "CEM – Informações gerais", "Informações comuns às unidades vinculadas ao Centro Educacional Municipal."),
 ("pmbc/seduc/cem/pal", "PAL – Início", "Página inicial da unidade Professor Antonio Lucio."),
 ("pmbc/seduc/cem/pal/matricula", "PAL – Procedimento de matrícula", "Passo a passo da **matrícula** de novos alunos: documentos exigidos, prazo e lançamento no sistema."),
 ("pmbc/seduc/cem/pal/transporte-escolar", "PAL – Transporte escolar", "Como solicitar e renovar o **transporte escolar** dos alunos da unidade."),
 ("pmbc/seduc/nei", "NEI – Informações gerais", "Informações comuns às unidades do Núcleo de Educação da Infância."),
 ("pmbc/seduc/nei/pio", "PIO – Início", "Página inicial da unidade Pioneiros."),
 ("pmbc/seduc/nei/pio/cardapio", "PIO – Cardápio e alimentação", "Orientações sobre o **cardápio** semanal e restrições alimentares das crianças."),
 ("pmbc/seduc/nei/pio/adaptacao", "PIO – Período de adaptação", "Roteiro do **período de adaptação** de crianças novas na unidade."),
 ("pmbc/segov", "SEGOV – Informações gerais", "Documentos comuns à Secretaria Municipal de Governo, Inovação e Orçamento."),
 ("pmbc/segov/diti", "DITI – Início", "Página inicial da Divisão de Tecnologia da Informação."),
 ("pmbc/segov/diti/abrir-chamado", "DITI – Como abrir um chamado", "Passo a passo para **abrir um chamado** de suporte de informática: identificar o equipamento, descrever o problema e anotar o protocolo."),
 ("pmbc/segov/diti/backup", "DITI – Rotina de backup", "Descrição da rotina de **backup** dos servidores: frequência, retenção e procedimento de restauração."),
]

ANTIGAS = ["pmbc/geral","pmbc/searp/geral","pmbc/searp/decc/home","pmbc/seduc/geral","pmbc/seduc/cem/geral",
 "pmbc/seduc/cem/pal/home","pmbc/seduc/nei/geral","pmbc/seduc/nei/pio/home","pmbc/segov/geral","pmbc/segov/diti/home"]

def gql(url, token, query, variables):
    req = urllib.request.Request(url, json.dumps({"query": query, "variables": variables}).encode(),
          {"Content-Type": "application/json", "Authorization": f"Bearer {token}"})
    return json.load(urllib.request.urlopen(req))

def apagar_antigas(a, token):
    for path in ANTIGAS:
        if a.dry_run:
            print("apagaria:", path); continue
        try:
            r = gql(a.url, token, "query($p:String!,$l:String!){pages{singleByPath(path:$p,locale:$l){id}}}",
                    {"p": path, "l": a.locale})
            page = r["data"]["pages"]["singleByPath"]
            if not page:
                print("nao existe:", path); continue
            d = gql(a.url, token, "mutation($id:Int!){pages{delete(id:$id){responseResult{succeeded message}}}}",
                    {"id": page["id"]})["data"]["pages"]["delete"]["responseResult"]
            print("apagada" if d["succeeded"] else "FALHA", path, "" if d["succeeded"] else d["message"])
        except Exception as e:
            print("ERRO", path, e)

Q = """mutation ($content: String!, $description: String!, $editor: String!, $isPublished: Boolean!,
 $isPrivate: Boolean!, $locale: String!, $path: String!, $tags: [String]!, $title: String!) {
 pages { create(content: $content, description: $description, editor: $editor, isPublished: $isPublished,
  isPrivate: $isPrivate, locale: $locale, path: $path, tags: $tags, title: $title) {
   responseResult { succeeded errorCode slug message } page { id path } } } }"""

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--url", default="http://localhost/graphql")
    ap.add_argument("--locale", default="pt-br")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--apagar-antigas", action="store_true", help="apaga as paginas do esquema antigo e sai")
    a = ap.parse_args()
    token = os.environ.get("WIKI_TOKEN", "")
    if not a.dry_run and not token:
        sys.exit("Defina WIKI_TOKEN (chave de API da Wiki.js).")
    if a.apagar_antigas:
        apagar_antigas(a, token); return
    ok = fail = 0
    for path, title, text in PAGINAS:
        content = f"# {title}\n\n{text}\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n"
        if a.dry_run:
            print("criaria:", path); continue
        vars_ = dict(content=content, description=title, editor="markdown", isPublished=True,
                     isPrivate=False, locale=a.locale, path=path, tags=["teste"], title=title)
        req = urllib.request.Request(a.url, json.dumps({"query": Q, "variables": vars_}).encode(),
              {"Content-Type": "application/json", "Authorization": f"Bearer {token}"})
        try:
            r = json.load(urllib.request.urlopen(req))
            res = r["data"]["pages"]["create"]["responseResult"]
        except Exception as e:
            print("ERRO", path, e); fail += 1; continue
        if res["succeeded"]: ok += 1; print("ok  ", path)
        else: fail += 1; print("FALHA", path, "-", res["message"])
    print(f"\n{ok} criadas, {fail} com problema")

if __name__ == "__main__":
    main()
