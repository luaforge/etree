#!/usr/bin/env lua

-------------------------------------------------------------------------------
--             Generate the HTML documentation for etree                     --
-------------------------------------------------------------------------------

-- A markdown processor is required - for details refer to:
--
--     http://daringfireball.net/projects/markdown/
--
-- This script has been tested only with the Python implementation found at:
--
--     http://www.freewisdom.org/projects/python-markdown/

MARKDOWN = "markdown"
SOURCE   = "manual.txt"
OUTPUT   = "manual.html"

-------------------------------------------------------------------------------

function main()

  require "etree"

  os.execute(MARKDOWN .. " " .. SOURCE .. " > _manual.html 2>/dev/null")
  file = io.open("_manual.html")
  body = etree.fromstring("<body>"..file:read("*a").."</body>")
  file:close()

  head = etree.fromstring([[
  <head>
  <title>Lua Element Tree</title>
  <link rel="stylesheet" type="text/css" href="style.css" />
  </head>
  ]])

  html = {tag="html", head, body}
  html.attr = {
                xmlns="http://www.w3.org/1999/xhtml",
                ["xml:lang"]="en",
                lang="en"
              }

  doctype = [[
  <!DOCTYPE html 
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  ]]

  output = io.open(OUTPUT, "w")
  output:write(doctype)
  tree = etree.ElementTree(html, {decl=false})
  tree:write(output)

  os.execute("rm _manual.html 2>/dev/null")
end

-------------------------------------------------------------------------------

pcall(main)

