local instructionals = {}
local common = exports['instructional-buttons']
function SetInstructionalButton(text, control, toggle)
    if toggle then
        if not instructionals[text] then
            instructionals[text] = true
            common:SetInstructionalButton(text, control, toggle)
        end
    else
        if instructionals[text] then
            instructionals[text] = false
            common:SetInstructionalButton(text, control, toggle)
        end
    end
end
