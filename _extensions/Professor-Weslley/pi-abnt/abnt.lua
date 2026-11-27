--[[
  abnt.lua — atalhos ABNT em Markdown, sem precisar escrever LaTeX.

  # Resumo {.pre}        -> título centralizado, sem número, fora do sumário
                            (Resumo e Abstract saem em entrelinha simples)
  # Referências {.pos}   -> título centralizado, sem número, NO sumário
  ::: fonte              -> linha "Fonte: ..." abaixo de figura/tabela
  ::: citacao            -> citação direta com mais de 3 linhas (recuo de 4 cm)
  ::: listas             -> lista de figuras, lista de tabelas e sumário
  ::: {#refs}            -> lista de referências (alinhada à esquerda, simples)

  O primeiro título numerado (ex.: # Introdução) liga a paginação ABNT.
--]]

local textual_iniciado = false

local function raw(s) return pandoc.RawBlock("latex", s) end

local function envolver(ambiente, blocos)
  local out = { raw("\\begin{" .. ambiente .. "}") }
  for _, b in ipairs(blocos) do table.insert(out, b) end
  table.insert(out, raw("\\end{" .. ambiente .. "}"))
  return out
end

-- 1ª passada: o texto do Resumo/Abstract (até o próximo título de nível 1)
-- recebe a formatação de resumo (NBR 6028).
local RESUMOS = { resumo = true, abstract = true, resumen = true }

local function eh_resumo(b)
  return b.t == "Header" and b.level == 1 and b.classes:includes("pre")
    and RESUMOS[pandoc.text.lower(pandoc.utils.stringify(b.content))]
end

local function fim_de_secao(b)
  return (b.t == "Header" and b.level == 1)
    or (b.t == "Div" and b.classes:includes("listas"))
end

-- Logo da capa: o do CEUB (na pasta da extensão), salvo se o YAML trouxer
-- `logo: caminho/da/imagem.png` ou `logo: false` (capa só com texto).
local function definir_logo(doc)
  local m = doc.meta
  local caminho
  if m.logo ~= nil then
    if type(m.logo) == "boolean" then
      if not m.logo then return end
    else
      caminho = pandoc.utils.stringify(m.logo)
    end
  end
  if not caminho or caminho == "" then
    local abs = quarto.utils.resolve_path("logo-ceub.png")
    local pasta_doc = pandoc.path.directory(quarto.doc.input_file)
    caminho = pandoc.path.make_relative(abs, pasta_doc)
  end
  doc.meta["abnt-logo"] = pandoc.MetaInlines({ pandoc.RawInline("latex", caminho) })
end

local function resumos(doc)
  definir_logo(doc)
  local out, aberto = {}, false
  for _, b in ipairs(doc.blocks) do
    if aberto and fim_de_secao(b) then
      table.insert(out, raw("\\end{abntresumo}"))
      aberto = false
    end
    table.insert(out, b)
    if eh_resumo(b) then
      table.insert(out, raw("\\begin{abntresumo}"))
      aberto = true
    end
  end
  if aberto then table.insert(out, raw("\\end{abntresumo}")) end
  doc.blocks = out
  return doc
end

-- 2ª passada: títulos e blocos especiais.
local function Header(el)
  if el.level ~= 1 then return nil end
  local titulo = pandoc.utils.stringify(el.content)
  if el.classes:includes("pre") then
    return raw("\\abntsemnumero{" .. titulo .. "}{0}")
  elseif el.classes:includes("pos") then
    return raw("\\abntsemnumero{" .. titulo .. "}{1}")
  elseif not textual_iniciado and not el.classes:includes("unnumbered") then
    textual_iniciado = true
    return { raw("\\abnttextual"), el }
  end
end

local function Div(el)
  if el.classes:includes("fonte") then
    return envolver("abntfonte", el.content)
  elseif el.classes:includes("citacao") then
    return envolver("abntcitacao", el.content)
  elseif el.classes:includes("listas") then
    return raw("\\abntlistas")
  elseif el.identifier == "refs" then
    -- a lista é preenchida depois pelo citeproc; aqui só envolvemos o bloco
    return { raw("\\begin{abntreferencias}"), el, raw("\\end{abntreferencias}") }
  end
end

return { { Pandoc = resumos }, { Header = Header, Div = Div } }
