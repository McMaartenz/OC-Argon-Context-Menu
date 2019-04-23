local event = require("event")
local gpu = require("component").gpu
local shell = require("shell")
local isOpen = false
local contextX = 0
local contextY = 0
local clearMenu = function()
  gpu.setBackground(0x000000)
  gpu.fill(contextX-1,contextY-1,20,10," ")
end
local ContextMenuOpen = function(x,y)
  isOpen = true
  contextX = x
  contextY = y
  gpu.fill(x-1,y-1,20,9," ")
  gpu.setBackground(0xFFFFFF)
  gpu.fill(x,y,18,8," ")
  gpu.setForeground(0x000000)
  gpu.set(x,y,"Argon Context Menu")
  gpu.set(x,y+1,"------------------")
  gpu.set(x,y+2," > Shutdown PC")
  gpu.set(x,y+3," > Reboot PC")
  gpu.set(x,y+4," > Interrupt")
  gpu.set(x,y+5,"------------------")
  gpu.set(x,y+6," > Edit .autorun")
  gpu.set(x,y+7," > Close this")
  gpu.setBackground(0x000000)
  gpu.setForeground(0xFFFFFF)
end
event.listen("touch",function(_,_,x,y,m)
  if isOpen ~= true then
    if m == 1 then
      ContextMenuOpen(x,y)
    end
  else
    if m == 0 then
      if x >= contextX and x <= contextX+18 and y >= contextY and y <= contextY then
        shell.execute("view /argon/about.txt")
        isOpen = false
      elseif x >= contextX and x <= contextX+18 and y >= contextY+2 and y <= contextY+2 then
        shell.execute("shutdown")
        isOpen = false
      elseif x >= contextX and x <= contextX+18 and y >= contextY+3 and y <= contextY+3 then
        shell.execute("reboot")
        isOpen = false
      elseif x >= contextX and x <= contextX+18 and y >= contextY+4 and y <= contextY+4 then
        event.push("interrupted")
        clearMenu()
        isOpen = false
      elseif x >= contextX and x <= contextX+18 and y >= contextY+6 and y <= contextY+6 then
        shell.execute("edit /argon/boot/.autorun")
        isOpen = false
      elseif x >= contextX and x <= contextX+18 and y >= contextY+7 and y <= contextY+7 then
        isOpen = false
        clearMenu()
      end
    else
      if m == 1 then
        clearMenu()
        ContextMenuOpen(x,y)
      end
    end
  end
end)
