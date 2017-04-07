local prevKeyCode
local escape = 0x35
local leftCommand = 0x37
local rightCommand = 0x36
local eisuu = 0x66
local kana = 0x68
local semicolon = 0x29

local function keyStroke(modifiers, character)
    hs.eventtap.keyStroke(modifiers, character, 1000)
end

local function jp()
    keyStroke({}, kana)
end

local function eng()
    keyStroke({}, eisuu)
end

local function handleEvent(e)
    local keyCode = e:getKeyCode()
    local eventType = e:getType()
    if keyCode == escape then
        eng()
    end


    local isCmdKeyUp = not(e:getFlags()['cmd']) and eventType == hs.eventtap.event.types.flagsChanged
    if isCmdKeyUp and prevKeyCode == leftCommand then
        eng()
    elseif isCmdKeyUp and prevKeyCode == rightCommand then
        jp()
    end

    prevKeyCode = keyCode
end

eventtap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, handleEvent)
eventtap:start()
