# Sakkz-UI

Example:

```lua
local DeveloperMode = false
Sakkz = {}

function Sakkz.require(path)
    if type(path) == "string" then
    	if DeveloperMode then
	  return loadfile(path)()
	else
    	  path = path:gsub("\\", "/")
          return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sakkzz/UII/master/"..path, true))()
	end
    elseif type(path) == "number" then
        return loadstring(game:GetObjects(path)[1].Source)()
    end
end

Sakkz.require("Sakkz\\Main.lua")
local Window = Sakkz:Window()
local Test = Window:Tile("T", "Test")
local Groupbox = Test:Groupbox(UDim2.new(0, 25, 0, 70), UDim2.new(0, 350, 0, 300), "Groupbox")
Groupbox:Checkbox("Checkbox", function(Value)
	print("Checkbox: Value changed to: " .. tostring(Value))
end)
Groupbox:Button("Button", function()
	print("Button: pressed")
end)
Groupbox:Slider("Slider", {min = 10, max = 20}, function(Value)
	print("Slider: Value changed to: " .. Value)
end)
Groupbox:Dropdown("Dropdown", {"Test1", "Test2"}, function(Value)
	print("Dropdown: Value changed to: " .. Value)
end)
Test:TabList(UDim2.new(0, 25, 0, 25), UDim2.new(0, 350, 0, 30), {"Test", "Test2"}, function(Value)
    print("TabList: Value changed to: " .. Value)
end)
```
