-- TC Sniffer : coupe tous les shows Timecode sauf celui choisi.
--
-- Utilisation depuis une macro :
--   Plugin "TC Sniffer" "3"        -> garde le Timecode 3, coupe les autres
--   Plugin "TC Sniffer" "MonShow"  -> garde le Timecode nommé "MonShow"
--   Plugin "TC Sniffer"            -> garde le Timecode sélectionné, coupe les autres
--
-- Réglages :
local START_SELECTED = true  -- lance aussi (Go) le show choisi
local CONFIRM        = false -- demande confirmation avant d'agir

local function findTimecode(timecodes, arg)
  local n = tonumber(arg)
  for _, tc in ipairs(timecodes) do
    if (n and tc.no == n) or (tc.name == arg) then
      return tc
    end
  end
end

local function selectedTimecode(timecodes)
  if not SelectedTimecode then
    ErrPrintf("TC Sniffer : SelectedTimecode() indisponible dans cette version.")
    return
  end
  local sel = SelectedTimecode()
  if not sel then return end
  for _, tc in ipairs(timecodes) do
    if tc.no == sel.no then return tc end
  end
end

local function Main(displayHandle, argument)
  local timecodes = DataPool().Timecodes:Children()
  if #timecodes == 0 then
    Printf("TC Sniffer : aucun Timecode dans le pool.")
    return
  end

  local keep
  if argument and argument ~= "" then
    keep = findTimecode(timecodes, argument)
    if not keep then
      ErrPrintf("TC Sniffer : Timecode '%s' introuvable.", argument)
      return
    end
  else
    keep = selectedTimecode(timecodes)
    if not keep then
      ErrPrintf("TC Sniffer : aucun Timecode sélectionné.")
      return
    end
  end

  if CONFIRM and not Confirm("TC Sniffer",
      string.format("Couper tous les Timecodes sauf %d '%s' ?", keep.no, keep.name)) then
    return
  end

  local count = 0
  for _, tc in ipairs(timecodes) do
    if tc.no ~= keep.no then
      Cmd(string.format("Off Timecode %d", tc.no))
      count = count + 1
    end
  end
  if START_SELECTED then
    Cmd(string.format("Go Timecode %d", keep.no))
  end

  Printf("TC Sniffer : %d show(s) coupé(s), actif : %d '%s'.", count, keep.no, keep.name)
end

return Main
