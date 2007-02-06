#!/usr/bin/env lua

-- This script requires a markdown processor to generate
-- the html documentation for etree.

os.execute("markdown manual.txt > _manual.html")

local file = io.open("_manual.html")
local buffer = {}
local write = function(string)
  table.insert(buffer, string)
  table.insert(buffer, "\n")
end

head = [[
<head>
<title>Lua Element Tree</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
]]

write("<html>")
write(head)
write("<body>")
for line in file:lines() do
  write(line)
end
write("</body>")
write("</html>")

file = io.open("manual.html", "w")
file:write(table.concat(buffer))
file:close()

os.execute("rm _manual.html")
