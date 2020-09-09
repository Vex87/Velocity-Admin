local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Sets the player's health to infinite."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to god.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
}

Cmd.Run = function(CurrentPlayer, Player)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                if Velocity.TempData[CurrentPlayer.Name].God then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.MaxHealth, Hum.Health = Velocity.TempData[CurrentPlayer.Name].God.MaxHealth, Velocity.TempData[CurrentPlayer.Name].God.Health
                    Velocity.TempData[CurrentPlayer.Name].God = nil
                    return true, Player .. " was ungodded."
                else
                    return false, Player .. " is already ungodded."
                end
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