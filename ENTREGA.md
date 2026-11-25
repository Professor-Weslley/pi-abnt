# Como começar e como entregar o relatório final do PI

## 1. Criar o seu repositório (uma vez por grupo)

Só **um** integrante do grupo faz este passo.

1. Entre no GitHub com a sua conta (crie uma em <https://github.com> se ainda não tiver).
2. Abra <https://github.com/Professor-Weslley/pi-abnt>.
3. Clique no botão verde **Use this template** → **Create a new repository**.
4. Preencha:
   - **Repository name:** `pi-<turma>-<sobrenome-do-grupo>` (ex.: `pi-3a-silva-souza`);
   - Marque **Private**.
5. Clique em **Create repository**.

## 2. Dar acesso ao professor e ao grupo

No repositório que você acabou de criar:

1. **Settings** → **Collaborators** → **Add people**.
2. Adicione **`Professor-Weslley`**.
3. Adicione também os colegas do grupo.

> O convite expira em 7 dias. Se o professor não aceitar a tempo, envie de novo.

## 3. Trazer o repositório para o seu computador

No RStudio: **File → New Project → Version Control → Git**.

- **Repository URL:** o endereço do seu repositório (botão verde **Code** → HTTPS).
- **Create project as subdirectory of:** uma pasta **sem acentos e fora do OneDrive** (ex.: `C:\projetos`).

Depois, siga a seção **Preparar o computador** do [README](README.md).

## 4. Trabalhar no relatório

- Edite o `relatorio_pi.qmd` e clique em **Render** para ver o PDF.
- Salve o progresso no GitHub com frequência. Na aba **Git** do RStudio: marque os arquivos → **Commit** → escreva uma mensagem → **Push**.
- Antes de começar a trabalhar, clique em **Pull** para receber as alterações dos colegas.
- A cada push, o GitHub gera o PDF sozinho (aba **Actions**). ✅ verde significa que o relatório compilou sem erro.

## 5. Entregar no Moodle (até o prazo)

1. Faça o último **Commit** e **Push**.
2. Confira se a aba **Actions** está ✅ verde.
3. Baixe o PDF gerado: **Actions** → execução mais recente → **relatorio-pdf**.
4. No Moodle, envie:
   - o **PDF** do relatório;
   - o **link do repositório** (ex.: `https://github.com/seu-usuario/pi-3a-silva-souza`).

> O professor considera a versão do repositório correspondente ao **último commit feito até o prazo**. Commits depois do prazo ficam registrados com data e hora.

## Checklist antes de entregar

- [ ] Capa e folha de rosto com o nome de todos os integrantes e do orientador.
- [ ] Nenhum chunk de exemplo esquecido (procure por `✏️ SUBSTITUA` e por `vendas_exemplo`).
- [ ] Toda figura e tabela tem legenda (`fig-cap`/`tbl-cap`), `::: fonte` e é citada no texto (`@fig-...`, `@tbl-...`).
- [ ] Resumo e Abstract escritos, com palavras-chave.
- [ ] Toda obra citada está no `refs.bib`, e toda referência listada é citada no texto.
- [ ] Dados e imagens usados estão nas pastas `dados/` e `imagens/` do repositório.
- [ ] Aba **Actions** ✅ verde.
