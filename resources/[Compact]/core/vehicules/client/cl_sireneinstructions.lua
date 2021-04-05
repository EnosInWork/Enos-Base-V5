local function ButtonMessage(text)
    BeginTextCommandScaleformString(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function setupScaleform(scaleform, data)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    for n, btn in next, data do
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(n-1)
        Button(GetControlInstructionalButton(2, btn.control, true))
        ButtonMessage(btn.name)
        PopScaleformMovieFunctionVoid()
    end

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

local form = nil
local data = {}

local entries = {}

function SetInstructions()
    form = setupScaleform("instructional_buttons", entries)
end

function SetInstructionalButton(name, control, enabled)
    local found = false
    for k, entry in next, entries do
        if entry.name == name and entry.control == control then
            found = true
            if not enabled then
                table.remove(entries, k)
                SetInstructions()
            end
            break
        end
    end
    if not found then
        if enabled then
            table.insert(entries, {name = name, control = control})
            SetInstructions()
        end
    end
end

Citizen.CreateThread(function()
    while true do
        if form then
            DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
        end
        Wait(0)
    end
end)