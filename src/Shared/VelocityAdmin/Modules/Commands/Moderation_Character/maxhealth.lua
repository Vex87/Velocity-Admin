local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Changes a player's max health."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to change the health of.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "amount",
        ["Description"] = "The amount you want to change the player's max health to.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Player, Amount)
        
    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not Amount then
        return false, "Amount Argument Missing"
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                Hum.MaxHealth = Amount
                return true, Player .. " 's max health was changed to " .. Amount
            else
                return false, Player .. "'s character does not exist."
            end 
        end              
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd