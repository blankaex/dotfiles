-- configuration
local KEYBIND = string.lower("y") -- must be lowercase, uppercase will be used for mode cycle, ctrl+lowercase will be used for menu
-- comparison is done in lowercase, so all paterns must be lowercase
local PATTERNS_EXACT = {
    -- "intro" -- unfortunately ambiguous, some use it as a prologue, some as opening
    "op", "opening", " - op",
    "ed", "ending", " - ed",
    "ending credits", "credits",
    "pv", "preview", "next episode preview", "next ep. preview", "nextp ep. preview", "next", "next time",
    "endcard", " - ed card",
    "ed+cast", "cast",
}
local PATTERNS_START = {
    "op by ",
    "ed song - ",
}
local PATTERNS_END = {
    " (opening)", " - opening", " - op",
    " (ending)", "- ending", " - ed",
    " preview",
}
-- internal configuration
local MODE_CHAPTER_NAME   = "chapter name"
local MODE_CHAPTER_LENGTH = "chapter length"
-- state
local PREV_CHAPTER = nil
local MENU = false
local ENABLED = true
local CURRENT_MODE = MODE_CHAPTER_NAME
local SELECTED_MENU_ROW = 2 -- 1-4
local SELECTED_MENU_COL = 1 -- 1-3, used by thresholds
local OP_ED_THRESHOLD = {
    from = { selected = false, value = 88 },
    to = { selected = false, value = 92 },
}
local PV_THRESHOLD = {
    from = { selected = false, value = 14 },
    to = { selected = false, value = 26 },
}

-- region: menu
local function increment_from(t)
    if t.from.value == t.to.value - 1 then
        return
    end

    t.from.value = t.from.value + 1
end

local function decrement_from(t)
    if t.from.value == 0 then
        return
    end

    t.from.value = t.from.value - 1
end

local function increment_to(t)
    t.to.value = t.to.value + 1
end

local function decrement_to(t)
    if t.to.value == 0
    or t.from.value == t.to.value - 1 then
        return
    end

    t.to.value = t.to.value - 1
end

function OP_ED_THRESHOLD.from:increment() increment_from(OP_ED_THRESHOLD) end
function OP_ED_THRESHOLD.from:decrement() decrement_from(OP_ED_THRESHOLD) end
function OP_ED_THRESHOLD.to:increment() increment_to(OP_ED_THRESHOLD) end
function OP_ED_THRESHOLD.to:decrement() decrement_to(OP_ED_THRESHOLD) end
function PV_THRESHOLD.from:increment() increment_from(PV_THRESHOLD) end
function PV_THRESHOLD.from:decrement() decrement_from(PV_THRESHOLD) end
function PV_THRESHOLD.to:increment() increment_to(PV_THRESHOLD) end
function PV_THRESHOLD.to:decrement() decrement_to(PV_THRESHOLD) end

local function draw_menu()
    local menu = {
        { name = "Skip OP/ED/PV", items = {} }
    }

    if ENABLED then
        table.insert(menu[1].items, "- Enabled: {\\b1}yes{\\b0} | {\\b0}no{\\b0}")
    else
        table.insert(menu[1].items, "- Enabled: {\\b0}yes{\\b0} | {\\b1}no{\\b0}")
    end

    if CURRENT_MODE == MODE_CHAPTER_NAME then
        table.insert(menu[1].items, "- Mode: {\\b1}name{\\b0} | {\\b0}length{\\b0}")
    elseif CURRENT_MODE == MODE_CHAPTER_LENGTH then
        table.insert(menu[1].items, "- Mode: {\\b0}name{\\b0} | {\\b1}length{\\b0}")

        local function bool_to_integer(boolean)
            if boolean then
                return 1
            else
                return 0
            end
        end

        table.insert(menu, { name = "Length thresholds", items = {
            string.format(
                "- OP/ED: {\\b%i}%i{\\b0}-{\\b%i}%i{\\b0} seconds",
                bool_to_integer(OP_ED_THRESHOLD.from.selected), OP_ED_THRESHOLD.from.value,
                bool_to_integer(OP_ED_THRESHOLD.to.selected), OP_ED_THRESHOLD.to.value
            ),
            string.format(
                "- PV: {\\b%i}%i{\\b0}-{\\b%i}%i{\\b0} seconds",
                bool_to_integer(PV_THRESHOLD.from.selected), PV_THRESHOLD.from.value,
                bool_to_integer(PV_THRESHOLD.to.selected), PV_THRESHOLD.to.value
            )
        }})
    end

    local function array_length(t)
        local length = 0;

        for _ in ipairs(t) do
            length = length + 1
        end

        return length
    end

    local ass = ""
    local row_offset = 0;
    for _, section in ipairs(menu) do
        ass = ass .. section.name .. "\\N"

        for i, item in ipairs(section.items) do
            if row_offset + i == SELECTED_MENU_ROW then
                ass = ass .. "{\\c&H46CFFF&}" .. item .. "{\\c&HFFFFFF&}" .. "\\N"
            else
                ass = ass .. item .. "\\N"
            end
        end

        row_offset = row_offset + array_length(section.items)
    end

    mp.set_osd_ass(0, 0, ass)
end

local function hide_menu()
    MENU = false
    mp.set_osd_ass(0, 0, "")
    mp.remove_key_binding("op-ed-pv-skip-menu-up")
    mp.remove_key_binding("op-ed-pv-skip-menu-down")
    mp.remove_key_binding("op-ed-pv-skip-menu-left")
    mp.remove_key_binding("op-ed-pv-skip-menu-right")
    mp.remove_key_binding("op-ed-pv-skip-menu-esc")
end

mp.add_key_binding("ctrl+" .. KEYBIND, 'op-ed-pv-skip-settings', function ()
    if not MENU then
        MENU = true
        draw_menu()

        mp.add_forced_key_binding("UP", "op-ed-pv-skip-menu-up", function ()
            if SELECTED_MENU_ROW <= 1 then
                return
            -- op/ed threshold
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 2 then
                OP_ED_THRESHOLD.from.increment()
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 3 then
                OP_ED_THRESHOLD.to.increment()
            -- pv threshold
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 2 then
                PV_THRESHOLD.from.increment()
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 3 then
                PV_THRESHOLD.to.increment()
            else
                SELECTED_MENU_ROW = SELECTED_MENU_ROW - 1
            end

            draw_menu()
        end, {repeatable=true})

        mp.add_forced_key_binding("DOWN", "op-ed-pv-skip-menu-down", function ()
            if CURRENT_MODE == MODE_CHAPTER_NAME and SELECTED_MENU_ROW >= 2 then
                return
            -- op/ed threshold
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 2 then
                OP_ED_THRESHOLD.from.decrement()
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 3 then
                OP_ED_THRESHOLD.to.decrement()
            -- pv threshold
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 2 then
                PV_THRESHOLD.from.decrement()
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 3 then
                PV_THRESHOLD.to.decrement()
            elseif SELECTED_MENU_ROW >= 4 then
                return
            else
                SELECTED_MENU_ROW = SELECTED_MENU_ROW + 1
            end

            draw_menu()
        end, {repeatable=true})

        mp.add_forced_key_binding("LEFT", "op-ed-pv-skip-menu-left", function ()
            -- enabled
            if SELECTED_MENU_ROW == 1 then
                ENABLED = true
            -- mode
            elseif SELECTED_MENU_ROW == 2 then
                CURRENT_MODE = MODE_CHAPTER_NAME
            -- op/ed threshold
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 2 then
                OP_ED_THRESHOLD.from.selected = false
                SELECTED_MENU_COL = 1
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 3 then
                OP_ED_THRESHOLD.from.selected = true
                OP_ED_THRESHOLD.to.selected = false
                SELECTED_MENU_COL = 2;
            -- pv threshold
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 2 then
                PV_THRESHOLD.from.selected = false
                SELECTED_MENU_COL = 1
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 3 then
                PV_THRESHOLD.from.selected = true
                PV_THRESHOLD.to.selected = false
                SELECTED_MENU_COL = 2;
            else
                return
            end

            draw_menu()
        end)

        mp.add_forced_key_binding("RIGHT", "op-ed-pv-skip-menu-right", function ()
            -- enabled
            if SELECTED_MENU_ROW == 1 then
                ENABLED = false
            -- mode
            elseif SELECTED_MENU_ROW == 2 then
                CURRENT_MODE = MODE_CHAPTER_LENGTH
            -- op/ed threshold
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 1 then
                OP_ED_THRESHOLD.from.selected = true
                SELECTED_MENU_COL = 2
            elseif SELECTED_MENU_ROW == 3 and SELECTED_MENU_COL == 2 then
                OP_ED_THRESHOLD.from.selected = false
                OP_ED_THRESHOLD.to.selected = true
                SELECTED_MENU_COL = 3;
            -- pv threshold
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 1 then
                PV_THRESHOLD.from.selected = true
                SELECTED_MENU_COL = 2
            elseif SELECTED_MENU_ROW == 4 and SELECTED_MENU_COL == 2 then
                PV_THRESHOLD.from.selected = false
                PV_THRESHOLD.to.selected = true
                SELECTED_MENU_COL = 3;
            else
                return
            end

            draw_menu()
        end)

        mp.add_forced_key_binding("ESC", "op-ed-pv-skip-menu-esc", function ()
            hide_menu()
        end)
    else
        hide_menu()
    end
end)
-- endregion: menu

local function starts_with(str, start)
    return str:sub(1, #start) == start
end

local function is_op_ed_pv(chapter_index)
    local title = mp.get_property("chapter-list/" .. chapter_index .. "/title"):lower()

    for _, pattern in ipairs(PATTERNS_EXACT) do
        if pattern == title then
            return true
        end
    end

    for _, pattern in ipairs(PATTERNS_START) do
        if starts_with(title, pattern) then
            return true
        end
    end

    local function ends_with(str, ending)
        return ending == "" or str:sub(-#ending) == ending
    end

    for _, pattern in ipairs(PATTERNS_END) do
        if ends_with(title, pattern) then
            return true
        end
    end

    return false
end

local function seek_to_next_or_prev_chapter(chapter_index)
    -- figure out in which direction the chapter was changed
    local forward, to_chapter
    if PREV_CHAPTER == nil or chapter_index > PREV_CHAPTER then
        forward = true
        to_chapter = chapter_index + 1
    else
        forward = false
        to_chapter = chapter_index - 1

        -- check previous title, if it's an opening, skip over it
        -- but don't if we're already on first chapter,
        -- previous chapter will go out of bounds, and result in a crash trying to get a chapter title
        if to_chapter > 0 and is_op_ed_pv(to_chapter) then
            to_chapter = to_chapter - 1
        end
    end

    local chapters = mp.get_property_number("chapter-list/count")
    local is_seeking = mp.get_property_bool("seeking")

    if not forward and is_seeking then
        -- avoid getting stuck when seeking backwards into chapter thats then immediately skipped
        -- instead, step over the skipped chapter, and seek into previous chapter

        local chapter_end
        if chapter_index >= chapters - 1 then
            -- current chapter is last, use total file duration instead
            -- e.g. ../Part B/ED/Part C|, when seeking from part C over ED
            chapter_end = mp.get_property_number("duration")
        else
            -- start of the next chapter is also the end of current chapter
            chapter_end = mp.get_property_number("chapter-list/" .. chapter_index + 1 .. "/time")
        end

        local chapter_start = mp.get_property_number("chapter-list/" .. chapter_index .. "/time")
        local current_position = mp.get_property_number("playback-time")

        -- how many seconds we've seeked into the skipped chapter
        local seeked_skipped = chapter_end - current_position

        -- check if we skipped exactly an entire chapter
        -- floor the floats before comparing
        local chapter_length = chapter_end - chapter_start
        if math.floor(chapter_length) == math.floor(seeked_skipped) then
            -- entire chapter was skipped, seek to the start of the previous one
            mp.set_property_number("chapter", to_chapter)
        elseif chapter_index == 0 then
            -- if first chapter is an opening, seek into it instead
            -- don't have to do anything for that, this is the default behaviour
        else
            -- seek into the previous chapter
            local seeked_previous = chapter_start - seeked_skipped
            mp.set_property_number("playback-time", seeked_previous)
        end
    elseif chapter_index >= chapters - 1 then
        -- on last chapter, to next playlist item
        -- if we don't do this, we'll still go to the next item, but will get the following error
        -- The chapter option must be <= {last chapter}: {last chapter + 1}
        mp.command("playlist-next")
    else
        local next_chapter_start = mp.get_property_number("chapter-list/" .. to_chapter + 1 .. "/time")
        local chapter_start = mp.get_property_number("chapter-list/" .. to_chapter .. "/time")
        local file_duration = mp.get_property_number("duration")

        if next_chapter_start == nil and chapter_start > file_duration then
            -- if last chapter starts beyond the end of the file, playback will get stuck when switched to the next file
            mp.command("playlist-next")
        else
            -- to next or previous chapter
            mp.set_property_number("chapter", to_chapter)
        end
    end
end

local function mode_cycle()
    if CURRENT_MODE == MODE_CHAPTER_NAME then
        CURRENT_MODE = MODE_CHAPTER_LENGTH
    elseif CURRENT_MODE == MODE_CHAPTER_LENGTH then
        CURRENT_MODE = MODE_CHAPTER_NAME
    end
end

mp.add_key_binding(KEYBIND, "op-ed-pv-skip-toggle", function()
    local msg = "OP/ED/PV skip: "
    if ENABLED then
        ENABLED = false
        msg = msg .. "disabled"
    else
        ENABLED = true
        msg = msg .. "enabled"
    end

    if MENU then
        -- redraw to update `Enabled` value
        draw_menu()
    else
        mp.osd_message(msg)
    end
end)

mp.add_key_binding(string.upper(KEYBIND), "op-ed-pv-skip-mode-cycle", function ()
    if not ENABLED then
        return
    end

    mode_cycle()

    if MENU then
        -- redraw to update `Mode` value
        draw_menu()
    else
        mp.osd_message("OP/ED/PV skip: " .. CURRENT_MODE)
    end
end)

mp.observe_property("chapters", "number", function(_, chapter_count)
    if chapter_count == nil
    or chapter_count == 0 then
        return
    end

    -- must run before `chapter` handler
    -- otherwise, chapter skip might not happen when opening the file (and first chapter is an OP)

    local named_chapters = false
    for chapter_index = 0, chapter_count - 1 do -- range is inclusive, but chapters are 0-indexed
        local title = mp.get_property("chapter-list/" .. chapter_index .. "/title")
        if not starts_with(title, "Chapter ") then
            named_chapters = true
            break
        end
    end

    if (named_chapters and CURRENT_MODE ~= MODE_CHAPTER_NAME)
    or (not named_chapters and CURRENT_MODE ~= MODE_CHAPTER_LENGTH)
    then
        -- `mp.commandv("keypress", string.upper(KEYBIND))` could have been used here,
        -- but the mode cycle seem to happen after `chapter` handler, so skip doesn't happen when opening the file
        mode_cycle()
        mp.osd_message("OP/ED/PV skip: " .. CURRENT_MODE)
    end
end)

mp.observe_property("chapter", "number", function(_, chapter_index)
    if not ENABLED
    or chapter_index == nil -- nil on startup before opening the file
    or chapter_index < 0    -- -1 when seeking backwards on first chapter
    then
        -- 0 is emitted next, so ignore this event
        return
    end

    if CURRENT_MODE == MODE_CHAPTER_NAME then
        if is_op_ed_pv(chapter_index) then
            seek_to_next_or_prev_chapter(chapter_index)
        end
    elseif CURRENT_MODE == MODE_CHAPTER_LENGTH then
        -- figure out chapter length
        local current_chapter_start = mp.get_property_number("chapter-list/" .. chapter_index .. "/time")
        local chapter_count = mp.get_property_number("chapter-list/count")
        local last_chapter_index = chapter_count - 1
        local chapter_length
        if chapter_index == last_chapter_index then
            -- last chapter, since there's no next chapter, substract from total duration instead
            local file_duration = mp.get_property_number("duration")
            chapter_length = file_duration - current_chapter_start
        else
            local next_chapter_start = mp.get_property_number("chapter-list/" .. chapter_index + 1 .. "/time")
            chapter_length = next_chapter_start - current_chapter_start
        end

        -- chapter_length is a float, so use ranges when comparing
        if (chapter_index == 0                      -- |OP/..
        or chapter_index == 1                       -- |Intro/OP/..
        or chapter_index == 2                       -- |???/Intro/OP/..
        or chapter_index == last_chapter_index      -- ../ED|
        or chapter_index == last_chapter_index - 1  -- ../ED/PV|
        or chapter_index == last_chapter_index - 2) -- ../ED/PV/Endcard|
        and chapter_length >= OP_ED_THRESHOLD.from.value
        and chapter_length <= OP_ED_THRESHOLD.to.value
        then
            seek_to_next_or_prev_chapter(chapter_index)
        end

        if chapter_index == last_chapter_index -- ../Preview|
        and chapter_length >= PV_THRESHOLD.from.value
        and chapter_length <= PV_THRESHOLD.to.value
        then
            seek_to_next_or_prev_chapter(chapter_index)
        end
    end

    PREV_CHAPTER = chapter_index
end)

mp.observe_property("path", "none", function()
    -- reset previous chapter when changing files,
    -- `seek_to_next_or_prev_chapter` checks in which direction the chapter was changed
    -- by comparing current and previous chapter indices, if it was backwards,
    -- then it checks the previous title by substracting 1 and calling `is_op_ed_pv`,
    -- the problem is that if we change the file, and the first chapter is an opening,
    -- then current chapter index is 0, but previous was not reset and probably >0,
    -- so -1 gets passed into `is_op_ed_pv`, which then crashes when trying to fetch the title
    PREV_CHAPTER = nil
end)
