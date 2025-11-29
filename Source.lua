local cloneref = cloneref or function(...) return ... end

local CoreGui = cloneref(game:GetService("CoreGui"))

local WindGui = CoreGui.RobloxGui:FindFirstChild("WindUI") or gethui():FindFirstChild("WindUI")
if not WindGui then
    return warn('Cannot find UI')
end

local KeySystem = WindGui:FindFirstChild("KeySystem")
if not KeySystem then
    return warn('Key system already completed.')
end

local Function = nil 
for Index, Value in pairs(getgc()) do
    if typeof(Value) == "function" and isexecutorclosure(Value) and islclosure(Value) then
        local Info = debug.getinfo(Value)
        if Info.name == "loadKeysystem" then
            local Upvalues = getupvalues(Value)
            if #Upvalues == 4 and Upvalues[4] == false then
                Function = Value
                break
            end
        end
    end
end

if not Function then 
    return warn("Function not found.")
end

setupvalue(Function, 4, true)
KeySystem:Destroy()
