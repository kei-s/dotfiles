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
    -- Eisu/Kana by right/left cmd key
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

    -- Swap ; and :
    if keyCode == semicolon then
      e:setFlags({['shift'] = not(e:getFlags()['shift'])})
    end

    prevKeyCode = keyCode
end

-- use global variant for GC
keyTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, handleEvent)
keyTap:start()

local function playpause(e)
  local systemKeyEvent = e:systemKey()
  if systemKeyEvent
    and systemKeyEvent.down
    and systemKeyEvent.key == "PLAY" then
    hs.itunes.playpause()
  end
end

-- use global variant for GC
playTap = hs.eventtap.new({hs.eventtap.event.types.NSSystemDefined}, playpause)
playTap:start()

-- Quit by long tap Cmd+Q
local holdSecond = 0.2
local holdingEpoch
local cmdq
local function cmdqPressed()
  holdingEpoch = hs.timer.secondsSinceEpoch()
end
local function cmdqReleasedOrRepeated()
  holding = hs.timer.secondsSinceEpoch() - holdingEpoch
  if holding > holdSecond then
    cmdq:disable()
    keyStroke({'cmd'}, 'q')
    hs.timer.doAfter(0.1, function () cmdq:enable() end)
  end
end
-- use global variant for GC
cmdq = hs.hotkey.bind({'cmd'}, 'q', cmdqPressed, cmdqReleasedOrRepeated, cmdqReleasedOrRepeated)

-- Dash keyboard shortcuts
-- See https://github.com/STRML/init/blob/5f69183151b7d3fc013cf621ba96b626bd7824f0/hammerspoon/init.lua#L305-L340
local dashKeybinds = {
    hs.hotkey.new({"ctrl"}, "j", function()
        keyStroke({"cmd", "alt"}, "left")
    end),
    hs.hotkey.new({"ctrl"}, "k", function()
        keyStroke({"cmd", "alt"}, "right")
    end)
}
local dashWatcher = hs.application.watcher.new(function(name, eventType, app)
    if eventType ~= hs.application.watcher.activated then return end
    local fnName = name == "Dash" and "enable" or "disable"
    for i, keybind in ipairs(dashKeybinds) do
        keybind[fnName](keybind)
    end
end)
dashWatcher:start()
