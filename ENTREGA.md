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

## 5. Garantir a reprodutibilidade

O professor vai **clonar o seu repositório e gerar o relatório do zero**. A entrega só vale se isso funcionar. Por isso:

- **Todos os dados vão para o repositório**, na pasta `dados/`.
  - Arquivo maior que 100 MB não sobe para o GitHub. Nesse caso, coloque os dados num link público (Google Drive, Kaggle, portal de dados abertos) e baixe-os **dentro do código**, num chunk do relatório. Explique a origem na Metodologia.
  - Dados que vêm de banco de dados ou de API: exporte para CSV ou Parquet e salve em `dados/`.
- **Use só caminhos relativos**: `pd.read_csv("dados/base.csv")`, nunca `C:/Users/...`.
- **Todos os pacotes Python usados estão no `requirements.txt`.**
- **Fixe as sementes aleatórias** (`random_state=42`, `np.random.seed(42)`), para os números do PDF serem sempre os mesmos.
- **Todo o código da análise está no repositório.** Notebooks e scripts auxiliares podem ir numa pasta `notebooks/` ou `src/`, mas o relatório precisa rodar sozinho.
- **Nenhuma senha, token ou chave de API** no repositório.

**Como saber se está reprodutível:** a aba **Actions** ✅ verde significa que o GitHub conseguiu gerar o seu PDF numa máquina limpa, só com o que está no repositório. Se no seu computador funciona e no GitHub fica ❌ vermelho, falta alguma coisa no repositório.

## 6. Entregar (até o prazo)

1. Faça o último **Commit** e **Push** e confira se a aba **Actions** está ✅ verde.
2. **Crie a versão de entrega (release)** no GitHub:
   1. Na página do repositório, na coluna da direita, clique em **Releases** → **Create a new release**.
   2. Em **Choose a tag**, digite `entrega-final` e clique em **Create new tag: entrega-final on publish**.
   3. Em **Release title**, escreva `Entrega final`.
   4. Clique em **Publish release**.
   5. Copie o endereço da página que abrir (ex.: `https://github.com/seu-usuario/pi-3a-silva-souza/releases/tag/entrega-final`).
3. Baixe o PDF gerado: **Actions** → execução mais recente → **relatorio-pdf**.
4. No Moodle, na tarefa de entrega, envie:
   - o **PDF** do relatório (arquivo);
   - o **link do repositório** e o **link da release** `entrega-final` (texto online).

> A release congela a versão entregue. O professor avalia **exatamente essa versão**, mesmo que o repositório receba commits depois. Se precisar corrigir algo **antes do prazo**, apague a release e a tag `entrega-final` e crie de novo.

## Checklist antes de entregar

- [ ] Capa e folha de rosto com o nome de todos os integrantes e do orientador.
- [ ] Nenhum chunk de exemplo esquecido (procure por `✏️ SUBSTITUA` e por `vendas_exemplo`).
- [ ] Toda figura e tabela tem legenda (`fig-cap`/`tbl-cap`), `::: fonte` e é citada no texto (`@fig-...`, `@tbl-...`).
- [ ] Resumo e Abstract escritos, com palavras-chave.
- [ ] Toda obra citada está no `refs.bib`, e toda referência listada é citada no texto.
- [ ] Dados no repositório (ou baixados pelo código), caminhos relativos e `requirements.txt` completo.
- [ ] Nenhuma senha, token ou chave de API no repositório.
- [ ] Aba **Actions** ✅ verde.
- [ ] Release `entrega-final` criada.
- [ ] `Professor-Weslley` adicionado como colaborador.
