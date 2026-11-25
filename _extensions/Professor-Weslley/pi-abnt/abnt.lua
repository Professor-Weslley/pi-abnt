--[[
  abnt.lua — atalhos ABNT em Markdown, sem precisar escrever LaTeX.

  # Resumo {.pre}        -> título centralizado, sem número, fora do sumário
  # Referências {.pos}   -> título centralizado, sem número, NO sumário
  ::: fonte              -> linha "Fonte: ..." abaixo de figura/tabela
  ::: listas             -> lista de figuras, lista de tabelas e sumário

  O primeiro título numerado (ex.: # Introdução) liga a paginação ABNT.
--]]

local textual_iniciado = false

local function raw(s) return pandoc.RawBlock("latex", s) end

function Header(el)
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

function Div(el)
  if el.classes:includes("fonte") then
    local out = { raw("\\begin{abntfonte}") }
    for _, b in ipairs(el.content) do table.insert(out, b) end
    table.insert(out, raw("\\end{abntfonte}"))
    return out
  elseif el.classes:includes("listas") then
    return raw("\\abntlistas")
  end
end

-- Headers devem ser processados em ordem, junto com os Divs.
return { { Header = Header, Div = Div } }
