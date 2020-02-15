local orgDisplayPing = WorldView.DisplayPing
WorldView.DisplayPing = function(self, pingData)
    if not pingData.Marker and not pingData.Renew then
        local pingOwnerIndex = pingData.Owner + 1
        local toFlash
        local scoreBoardControls = import('/mods/SupremeScoreBoard/modules/score_board.lua').controls
        local defaultColor = ''
        for _, line in scoreBoardControls.armyLines or {} do

            if line.armyID == pingOwnerIndex then
                toFlash = line.nameColumn
                break
            end
        end
        if toFlash then
            local flashesRemaining = 16
            local flashInterval = 0.2
            ForkThread(function()
                while flashesRemaining > 0 do
                    toFlash:Hide()
                    WaitSeconds(flashInterval)
                    toFlash:Show()
                    WaitSeconds(flashInterval)
                    flashesRemaining = flashesRemaining - 1
                end
            end)
        end
    end
    orgDisplayPing(self, pingData)
end
