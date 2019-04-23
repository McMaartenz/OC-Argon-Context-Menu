shell = require("shell")
local wget = function(url, loc)
  shell.execute("wget "..url.." "..loc)
end
wget("","/")
