# Relatório final do Projeto Integrador (ABNT + Quarto + Python)

Modelo oficial do relatório final do PI. Ele já sai no padrão ABNT: capa, folha de rosto, resumo, listas, sumário, títulos numerados, paginação, legendas, citações e referências. Você só escreve o conteúdo e troca os códigos de exemplo pelos seus.

> **Como começar e como entregar:** veja [ENTREGA.md](ENTREGA.md).

## O que tem aqui

| Arquivo / pasta | Para que serve | Você edita? |
|---|---|---|
| `relatorio_pi.qmd` | O relatório | **Sim** |
| `refs.bib` | Suas referências bibliográficas | **Sim** |
| `requirements.txt` | Pacotes Python do seu projeto | **Sim** |
| `dados/` | Seus dados | **Sim** |
| `imagens/` | Prints e diagramas | **Sim** |
| `_extensions/Professor-Weslley/pi-abnt/` | Padrão ABNT do curso (extensão do Quarto) | **Não** |
| `.github/workflows/render.yml` | Gera o PDF automaticamente no GitHub | **Não** |

## Escrevendo o relatório

1. **Topo do `relatorio_pi.qmd` (PARTE 1)**: título, autores, orientador etc. A capa e a folha de rosto são geradas sozinhas a partir daí.
2. **Texto**: escreva normalmente. **Não numere os títulos**: `# Introdução` vira "1 INTRODUÇÃO".
3. **Chunks marcados com `✏️ SUBSTITUA`**: troque o código de exemplo pelo seu, mas mantenha:
   - `#| label: fig-...` e `#| fig-cap: "..."` em gráficos;
   - `#| label: tbl-...` e `#| tbl-cap: "..."` em tabelas;
   - `#| results: hide` em chunks Python que geram gráficos ou treinam modelos;
   - o bloco `::: fonte` logo abaixo de cada figura ou tabela.
4. **Referências**: cadastre no `refs.bib` e cite com `[@chave]` ou `@chave`. A lista final é montada sozinha, no padrão ABNT.

### Atalhos

| No `.qmd` | Resultado |
|---|---|
| `# Resumo {.pre}` | Título centralizado, sem número, fora do sumário |
| `# Referências {.pos}` | Título centralizado, sem número, no sumário |
| `::: fonte` | Linha "Fonte: ..." abaixo de figura ou tabela |
| `` `r py$variavel` `` | Valor calculado em Python dentro do texto |
| `py$objeto` (em chunk R) | Usa no R um objeto criado em Python |
| `@fig-x`, `@tbl-x`, `@sec-x` | "Figura 1", "Tabela 2", "Seção 3", com link |

Funções do padrão visual, já carregadas no relatório: `numero_br()`, `moeda_br()`, `percentual_br()`, `eixo_br()`, `PALETA`, `COR_PRINCIPAL`, `COR_DESTAQUE`.

## Preparar o computador (uma única vez)

Os comandos com `install.packages`, `reticulate::` ou `tinytex::` são digitados no **Console do RStudio**.

### Windows

1. **Instale o R** (<https://cran.r-project.org/bin/windows/base/>) e depois o **RStudio** (<https://posit.co/download/rstudio-desktop/>). O RStudio já vem com o Quarto e o Git integrado.
2. **Instale o Rtools** da mesma versão do seu R (<https://cran.r-project.org/bin/windows/Rtools/>).
3. **Instale o Git** (<https://git-scm.com/download/win>). Na instalação, pode aceitar as opções padrão.
4. **Desative o Python da Microsoft Store**: Configurações → Aplicativos → Configurações avançadas de aplicativos → *Aliases de execução de aplicativo* → desligue `python.exe` e `python3.exe`.
5. **Pacotes do R:**

   ```r
   install.packages(c("reticulate", "knitr", "rmarkdown", "tinytex"))
   ```

6. **Python e ambiente do projeto.** O reticulate baixa o Python sozinho. Rode com o projeto aberto no RStudio, para ele achar o `requirements.txt`:

   ```r
   reticulate::install_python(version = "3.11")
   reticulate::virtualenv_create("r-reticulate", version = "3.11",
                                 requirements = "requirements.txt")
   ```

7. **LaTeX:**

   ```r
   tinytex::install_tinytex()
   ```

8. **Feche e abra o RStudio**, depois confira:

   ```r
   reticulate::use_virtualenv("r-reticulate", required = TRUE)
   reticulate::py_config()     # deve mostrar ...\r-reticulate\Scripts\python.exe
   tinytex::is_tinytex()       # deve retornar TRUE
   ```

> **Clone o repositório num caminho simples**, sem acentos, sem espaços e fora do OneDrive. Por exemplo: `C:\projetos\pi`.
> Caminhos como `C:\Users\João\OneDrive\Área de Trabalho\...` são a causa de erro mais comum no Windows.

> **Usa Anaconda?** Troque o passo 6 por `reticulate::conda_create("pi", packages = c("python=3.11", "pandas", "numpy", "matplotlib"))` e descomente `reticulate::use_condaenv("pi", required = TRUE)` no chunk `setup-r` do relatório.

### macOS

1. Instale o R e o RStudio. No Terminal, rode `xcode-select --install` (instala o Git e as ferramentas de compilação).
2. Siga os passos 5 a 8 do Windows: os comandos são os mesmos. No passo 8, o `py_config()` deve mostrar `~/.virtualenvs/r-reticulate/bin/python`.

### Pacotes Python extras

Acrescente o pacote no `requirements.txt`, que é o que o GitHub usa para gerar o PDF, e instale também no seu computador:

```r
reticulate::py_install("scikit-learn", envname = "r-reticulate")
```

## Gerar o PDF

- **No computador:** abra o `relatorio_pi.qmd` no RStudio e clique em **Render**.
- **No GitHub:** a cada `push`, o GitHub gera o PDF sozinho. Para baixar, vá na aba **Actions**, abra a execução mais recente e baixe o arquivo **relatorio-pdf** em *Artifacts*.
  - Se a execução ficar vermelha (❌), o relatório tem erro: clique nela para ver a mensagem.
  - Se você usa pacotes Python além dos padrões, eles precisam estar no `requirements.txt`; senão o PDF não é gerado no GitHub.

## Atualizar o padrão ABNT

Quando o professor avisar que corrigiu o padrão, rode na aba **Terminal** do RStudio:

```bash
quarto update extension Professor-Weslley/pi-abnt
```

Só a pasta `_extensions/` muda; o seu texto não é alterado. Depois faça commit e push.

## Problemas comuns

| Sintoma | Solução |
|---|---|
| `ModuleNotFoundError: No module named 'pandas'` | O reticulate pegou outro Python. No chunk `setup-r`, descomente `reticulate::use_virtualenv("r-reticulate", required = TRUE)`. |
| `Python was not found`, ou abre a Microsoft Store (Windows) | Faça o passo 4 do Windows. |
| Erro em caminho com acento, espaço ou `OneDrive` | Clone o repositório em `C:\projetos\pi`. |
| `Unknown format pi-abnt-pdf` | A pasta `_extensions/` está faltando ou foi apagada. Rode `quarto add Professor-Weslley/pi-abnt`. |
| `LaTeX Error: File 'xxx.sty' not found` | No Console: `tinytex::tlmgr_install("nome-do-pacote")`. |
| Funciona no seu computador, mas fica ❌ no GitHub | Falta pacote no `requirements.txt`, ou o arquivo de dados não foi enviado (confira a pasta `dados/` no GitHub). |
| Aparecem no PDF linhas como `[<matplotlib.lines.Line2D ...>]`, `Text(...)` ou `Pipeline(...)` | Acrescente `#| results: hide` no início do chunk Python. O reticulate imprime o valor de retorno de comandos como `ax.plot()` e `.fit()`. |
| O PDF não atualiza (Windows) | Feche o PDF aberto no leitor e renderize de novo. |
