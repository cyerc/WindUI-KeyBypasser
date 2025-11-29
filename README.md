# WindUI-KeyBypasser

## How do I use this?
Open any script using Wind UI with the key system enabled, and then run this line of code
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/cyerc/WindUI-KeyBypasser/main/Source.lua"))()
```
Now you don't need to get a key to use any script that uses this UI, have fun :)

## How does this work?
The way this key bypasser works is really simple.

First you make a for loop trough the garbage collection. The goal is to find a function with the name "loadKeysystem".
Make sure to only look for functions that have an executor and lua closure, or u might just freeze.
```lua
for Index, Value in pairs(getgc()) do
    if typeof(Value) == "function" and isexecutorclosure(Value) and islclosure(Value) then
        local Info = debug.getinfo(Value)
        if Info.name == "loadKeysystem" then
            local Upvalues = getupvalues(Value)
            if #Upvalues == 4 and Upvalues[4] == false then
                print('Function found!')
                break
            end
        end
    end
end
```

Looking at the Wind UI source code, you'll find this. 
```lua
repeat task.wait() until CanLoadWindow
```
This will yield the thread until `CanLoadWindow` is true.

With the function from earlier, you will need to set the 4th upvalue inside it's closure to true.
```lua
setupvalue(Function, 4, true)
```

Now litterally just litterally destroy the key system interface like so
```lua
CoreGui.RobloxGui.WindUI.KeySystem:Destroy()
```
