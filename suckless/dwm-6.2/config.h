/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Roboto Mono:style=Regular:pixelsize=16:antialias=true:autohint=true" };
static const char dmenufont[]       = "Roboto Mono:style=Regular:pixelsize=16:antialias=true:autohint=true";
/*static const char *fonts[]          = { "Terminus:style=Regular:pixelsize=20:antialias=true:autohint=true" };
static const char dmenufont[]       = "Terminus:style=Regular:pixelsize=20:antialias=true:autohint=true"; */
static const char col_gray1[]       = "#202125";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#d7d7d7";
/*static const char col_gray3[]       = "#dbdbdb";*/
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#ff0000";
static const char col_green[]       = "#0fff00";
static const char col_green2[]      = "#1EC325";
static const char col_yellow2[]     = "#FFEE20";
static const char col_yellow3[]     = "#F2F413";
static const char col_red2[]        = "#EC1317";
static const char col_purple[]      = "#4B367B";
static const char col_yellow[]      = "#ffff00";
static const char col_white[]       = "#ffffff";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_purple,  col_purple },
	[SchemeWarn] = { col_yellow2, col_gray1, col_gray2 },
	[SchemeUrgent] = { col_red2, col_gray1,  col_gray2 },
	[SchemeGreen] = { col_green2, col_gray1, col_gray2 },
	[SchemeSep] =  { col_white, col_gray1,  col_gray2 },

};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ NULL,       NULL,      "Volume Control", 1 << 8,     0,           -1 },
	{ NULL,	      NULL,      "Thunderbird", 1 << 7,     0,           -1 },
	{ NULL,	      NULL,      "Telegram",  1 << 6,       0,           -1 },
	{ NULL,	      NULL,      "Slack",  1 << 5,       0,           -1 },
/*	{ NULL,	      NULL,      "Microsoft Teams",   1 << 5,       0,           -1 }, */
	{ NULL,	      NULL,      "Discord",   1 << 5,       0,           -1 },
	{ NULL,	      NULL,      "Steam",     1 << 4,       0,           -1 },
	{ NULL,       NULL,      "Friends List", 1 << 4,     0,           -1 },
	{ NULL,	      NULL,      "mpv",       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define XF86MonBrightnessDown		0x1008ff03
#define XF86MonBrightnessUp		0x1008ff02
#define XF86AudioMute			0x1008ff12
#define XF86AudioLowerVolume		0x1008ff11
#define XF86AudioRaiseVolume		0x1008ff13
#define XF86AudioMicMute		0x1008ffb2
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
/*static const char *obscmd[]  = { "obs", NULL }; */
/*static const char *browsercmd[]  = { "chromium", "--force-device-scale-factor=1.5",  NULL }; */
/*static const char *steamcmd[]  = { "steam",  NULL }; */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *discordcmd[]  = { "discord", NULL };
static const char *termcmd[]  = { "st", "-e", "tmux", NULL };
static const char *pavucontrolcmd[]  = { "pavucontrol",  NULL };
/*static const char *browsercmd[]  = { "chromium", "--disable-gpu", NULL };*/
static const char *browsercmd[]  = { "chromium", NULL };
/*static const char *browsercmd[]  = { "firefox", NULL };*/
static const char *cmdbrightnessup[]  = { "xbacklight", "-inc", "4", NULL };
static const char *cmdbrightnessdown[]  = { "xbacklight", "-dec", "4", NULL };
static const char *cmdsoundup[]  = { "amixer", "-M", "set", "Master", "5%+", NULL };
static const char *cmdsounddown[]  = { "amixer", "-M", "set", "Master", "5%-", NULL };
static const char *cmdsoundtoggle[]  = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *cmdmicmutetoggle[] = { "amixer", "set", "Capture", "toggle", NULL };
static const char *cmdlock[]  = { "slock", NULL };
static const char *thunderbirdcmd[]  = { "thunderbird", NULL };
static const char scratchpadname[] = "notes";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", "-e", "tmux", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
/*	{ MODKEY|ShiftMask,             XK_o,      spawn,          {.v = obscmd} }, */
/*	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = steamcmd} }, */
/*	{ MODKEY,                       XK_space,  togglefloating, {0} }, */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ 0,                            XF86MonBrightnessDown,     spawn,         {.v = cmdbrightnessdown } },
	{ 0,                            XF86MonBrightnessUp,       spawn,         {.v = cmdbrightnessup } },
	{ 0,                            XF86AudioMute,             spawn,          {.v = cmdsoundtoggle } },
	{ 0,                            XF86AudioRaiseVolume,      spawn,          {.v = cmdsoundup } },
	{ 0,                            XF86AudioLowerVolume,      spawn,          {.v = cmdsounddown } },
	{ 0,                            XF86AudioMicMute,          spawn,          {.v = cmdmicmutetoggle } },
	{ 0,                            XK_Print,  spawn,          SHCMD("maim -s | xclip -sel clip -t image/png") },
	{ MODKEY,                       XK_n,      togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,                       XK_F12,    spawn,          {.v = cmdlock } },
	{ MODKEY,                       XK_c,      spawn,          SHCMD("show_clipboard") }, 
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = thunderbirdcmd} },
	{ MODKEY|ShiftMask,             XK_b,      spawn,          {.v = browsercmd} },
	{ MODKEY|ShiftMask,             XK_d,      spawn,          {.v = discordcmd} },
	{ MODKEY|ShiftMask,             XK_a,      spawn,          {.v = pavucontrolcmd} }, 
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_w,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

