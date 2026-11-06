-- Migrated from ~/.tmux.conf and Ghostty config; prefix is `
local shell = "com.superlogical.terminal.shell"

local previous = {} -- session_id -> the tab left by the last key switch

local function is_local_client(ctx)
  local list = rex.call("client.list")
  for _, c in ipairs(list and list.clients or {}) do
    if c.client_id == ctx.client_id then
      return c.principal and c.principal.transport == "unix"
    end
  end
end

local function active_index(view)
  for i, w in ipairs(view.windows or {}) do
    if w.window_id == view.active_window_id then
      return i
    end
  end
end

-- Remote apps fail session.select, so step there tab by tab, which stays inside the session.
local function show_window(ctx, view, window_id, index)
  if view.active_window_id ~= window_id then
    previous[ctx.session_id] = view.active_window_id
  end
  if is_local_client(ctx) then
    rex.client.queue("session.select", { session_id = ctx.session_id, window_id = window_id })
    return
  end
  local cur = active_index(view)
  if cur then
    local step = index > cur and "client.tab.next" or "client.tab.previous"
    for _ = 1, math.abs(index - cur) do
      rex.client.queue(step)
    end
  end
end

rex.action{
  name = "goto_tab",
  title = "Go to Tab in Session",
  description = "Show tab N of the current session; -1 is the last tab.",
  args = { index = "integer" },
  run = function(ctx, args)
    local view = assert(rex.session.view{})
    local windows = view.windows or {}
    local index = args.index == -1 and #windows or args.index
    local w = windows[index]
    if w then
      show_window(ctx, view, w.window_id, index)
    end
  end,
}

rex.action{
  name = "step_tab",
  title = "Next or Previous Tab in Session",
  description = "Move by offset through the tabs in the current session, wrapping around.",
  args = { offset = "integer" },
  run = function(ctx, args)
    local view = assert(rex.session.view{})
    local windows, i = view.windows or {}, active_index(view)
    if i then
      local index = (i - 1 + args.offset) % #windows + 1
      show_window(ctx, view, windows[index].window_id, index)
    end
  end,
}

rex.action{
  name = "last_tab",
  title = "Last Tab",
  description = "Go back to the tab you were on before the last key switch.",
  run = function(ctx)
    local view = assert(rex.session.view{})
    for index, w in ipairs(view.windows or {}) do
      if w.window_id == previous[ctx.session_id] then
        return show_window(ctx, view, w.window_id, index)
      end
    end
  end,
}

rex.action{
  name = "new_tab_here",
  title = "New Tab Here",
  description = "Open a tab right after the current one, in the directory of the focused pane.",
  run = function(ctx)
    local proc = rex.block.call("com.superlogical.terminal", "process", {})
    local fg = proc and (proc.foreground or proc.child)
    local view = assert(rex.session.view{})
    local i = active_index(view)
    local next_win = i and view.windows[i + 1]
    local win = assert(rex.session.new_window{
      layout = { block = { flavor = shell, options = { cwd = fg and fg.cwd or "" } } },
    })
    if next_win then
      rex.session.move_window{ window_id = win.window_id, before_window_id = next_win.window_id }
    end
    rex.exec{ "sleep", "0.2" } -- let the app see the new tab before switching to it
    show_window(ctx, view, win.window_id, next_win and i + 1 or #view.windows + 1)
  end,
}

rex.action{
  name = "new_tab_home",
  title = "New Tab in Home",
  description = "Open a tab at the end, in the home directory.",
  run = function(ctx)
    local view = assert(rex.session.view{})
    local win = assert(rex.session.new_window{ layout = { block = { flavor = shell } } })
    rex.session.move_window{ window_id = win.window_id }
    rex.exec{ "sleep", "0.2" } -- let the app see the new tab before switching to it
    show_window(ctx, view, win.window_id, #view.windows + 1)
  end,
}

rex.bind("`>e", "pane.send_key", { key = "`" })
rex.bind("`>shift+r", "client.config.reload")

rex.bind("`>w", "session.switch")
-- In sidebar view the app numbers every visible tab, across sessions and Macs.
for i = 1, 9 do
  rex.bind("alt+" .. i, "client.tab.goto", { index = i })
end
rex.bind("alt+0", "client.tab.goto", { index = -1 })
rex.bind("cmd+\\", "client.sidebar.toggle")
rex.bind("alt+[", "client.tab.previous")
rex.bind("alt+]", "client.tab.next")
rex.bind("alt+-", "client.tab.previous")
rex.bind("alt+=", "client.tab.next")
rex.bind("alt+shift+[", "session.previous")
rex.bind("alt+shift+]", "session.next")
rex.bind("`>[", "session.previous")
rex.bind("`>]", "session.next")
rex.bind("`>n", "session.new")
rex.bind("`>r", "session.rename")
rex.bind("`>x", "new_tab_here")
rex.bind("`>c", "new_tab_home")
rex.bind("`>`", "last_tab")
rex.bind("shift+left", "step_tab", { offset = -1 })
rex.bind("shift+right", "step_tab", { offset = 1 })

rex.bind("`>v", "pane.split", { direction = "right" })
rex.bind("`>s", "pane.split", { direction = "down" })
rex.bind("`>h", "pane.focus", { direction = "left" })
rex.bind("`>j", "pane.focus", { direction = "down" })
rex.bind("`>k", "pane.focus", { direction = "up" })
rex.bind("`>l", "pane.focus", { direction = "right" })
rex.bind("`>shift+j", "pane.resize", { amount = 5, direction = "down" })
rex.bind("`>shift+k", "pane.resize", { amount = 5, direction = "up" })
rex.bind("`>shift+h", "pane.resize", { amount = 5, direction = "left" })
rex.bind("`>shift+l", "pane.resize", { amount = 5, direction = "right" })
rex.bind("`>z", "pane.zoom")

for i = 1, 9 do
  rex.bind("`>" .. i, "goto_tab", { index = i })
  rex.bind("alt+shift+" .. i, "goto_tab", { index = i })
end
rex.bind("`>0", "goto_tab", { index = -1 })
rex.bind("alt+shift+0", "goto_tab", { index = -1 })

rex.bind("ctrl+k", "com.superlogical.terminal.clear")
