local modPath = '/mods/SupremeScoreBoard/'
local showScore = false

local orgCreateScoreUI = CreateScoreUI
function CreateScoreUI(parent)
    orgCreateScoreUI(parent)
    if not showScore then HideScore() end
end

function _OnBeat() end

local orgToggleScoreControl = ToggleScoreControl
function ToggleScoreControl(state)
    if showScore then orgToggleScoreControl() else HideScore() end
end

local orgExpand = Expand
function Expand()
    if showScore then orgExpand() else HideScore() end
end

local orgInitialAnimation = InitialAnimation
function InitialAnimation(state)
    if showScore then orgInitialAnimation() else HideScore() end
end

function HideScore()
    if controls and controls.bg then
        controls.bg.OnFrame = function(self, delta)
            self.Right:Set(function() return savedParent.Right() - 20000 end)
            self:SetNeedsFrameUpdate(false)
        end
        controls.bg.Right:Set(-100)
        controls.bg:Hide()
        controls.collapseArrow:Hide()
    end
end
