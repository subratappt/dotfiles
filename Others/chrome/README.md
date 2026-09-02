# FoxOne Glass

A customised build of **FoxOne 3.5.1**: glass URL bar, translucent panels, a
blue accent palette, and the fix for black-on-dark chrome text in macOS Light
mode.

Firefox 153 (Nova), macOS, profile `9b06x80r.default-release`.

---

## Files

| File | Role |
|------|------|
| `userChrome.css` | Loader only — a single `@import`. Firefox reads this filename and no other. |
| `foxone-glass.css` | The actual theme. ~3300 lines. |
| `userContent.css` | Untouched FoxOne web-content styles. |
| `README.md` | This file. |

**The `@import` must stay at the top of `userChrome.css`.** CSS ignores any
`@import` that appears after a style rule, so adding rules *above* it silently
disables the entire theme. Put personal tweaks *below* the import — they'll
override `foxone-glass.css`, since later rules win at equal specificity.

To revert to the old single-file setup, restore your backup over
`userChrome.css`.

---

## Where things live in `foxone-glass.css`

```
CONFIG              lines  30–165    palette, corners, URL-bar widths
COLOR THEME         lines 260–580    @media all — the ungated Gruvbox palette
  POPUP SURFACES    lines 400–535    panel/menu tokens and hover
LAYOUT / NAV BAR    lines 640–1200   one-line layout, URL bar, result rows
USER OVERRIDES      line  2872–end   glass surfaces, panels, tab preview
  1. Scheme pin           2882
  2. Panel surface        2902
  3. Glass URL bar        2947
  4. Field text           3143
  5. Result rows          3182
  6. Panels               3210
  7. Tab hover preview    3262
```

> **Line numbers were accurate when written and drift as soon as you edit.**
> The variable names are the reliable key — search for those.

Unlike the previous version, **variables are declared exactly once.** The old
file re-declared seven of them in a trailing overrides block, which meant
editing the config at the top silently did nothing. That's fixed — the config
block is now the single source of truth for the palette.

---

## Colours — CONFIG block

| Line | Variable | Value | Controls |
|------|----------|-------|----------|
| 36 | `--uc-color-base` | `#282828` | Toolbar, frame, popup base |
| 38 | `--uc-color-accent` | `#4f93d9` | Active tab, focus ring, selected rows, bookmark badges |
| 41 | `--uc-color-text` | `#FFFFFF` | Primary text |
| 42 | `--uc-color-hover` | `#3a3f47` | Hover **chip fill** — menus, sidebar, result rows |
| 45 | `--uc-color-hover-line` | `#4f8fd6` | Focus glow on the URL bar |
| 86 | `--uc-tab-hover-text` | `#7cb7ff` | Hover **text / icons** — tab titles, toolbar buttons, result rows |

Three channels, deliberately distinct: **accent** = where you are, **hover
text** = what you're pointing at, **hover fill** = the chip underneath. The
fill stays near-neutral grey so it sits *under* the text rather than competing.

**Contrast floor.** Both blues sit on `#282828`. `--uc-color-accent` at
`#4f93d9` is roughly 4.4:1 — about as dark as it goes before 12px tab labels
get hard to read. Going darker is the most common way to make this theme look
worse; check the tab strip afterwards.

### Colours that must be edited by hand

`::-moz-tree-*` pseudo-elements **cannot read CSS variables**, so the Library
and bookmarks-sidebar trees carry literals. Retheming means touching these too:

| Lines | Literal | Meaning |
|-------|---------|---------|
| ~1603, 1627, 1633 | `#4f93d9` | Bookmarks-sidebar selected row |
| ~2622, 2629 | `#4f93d9` | Library selected row |
| ~2645 | `#7cb7ff` | Library hover frame |

Occurrences of `#fabd2f` that remain are `var(--tab-selected-textcolor, #fabd2f)`
fallbacks. Line 553 sets that variable from `--uc-color-accent`, so the amber
never renders — they're dead defaults kept from upstream.

---

## Opacity and glass — overrides block

### Panels and URL dropdown — lines 2927–2929

```css
--uc-glass-panel-bg:   color-mix(in srgb, #1e2126 88%, transparent);
--uc-glass-panel-edge: color-mix(in srgb, #ffffff 12%, transparent);
--uc-glass-panel-blur: blur(30px) saturate(170%);
```

The **`88%` is the transparency dial.** Below roughly 80% the page behind
starts competing with row text, which is what made the first attempt
unreadable. Raise toward 94% if menus feel too see-through.

> **macOS limitation:** popups are separate native windows. Alpha works — what's
> behind genuinely shows through — but `backdrop-filter` cannot sample across a
> window boundary, so **menus get no real frosted blur**, only tint-transparency
> plus edge and shadow work. They lean entirely on that 88%.
>
> The URL-bar dropdown is the exception: it renders *inside* the browser
> window, so its blur is real.

### The URL bar — lines 2975–2980

```css
--uc-urlbar-glass-fill:       #2f3540;   /* resting */
--uc-urlbar-glass-fill-hover: #363d4a;
--uc-urlbar-glass-fill-focus: #3d4655;
--uc-urlbar-glass-blur: blur(16px) saturate(180%) brightness(1.5);
--uc-urlbar-glass-edge: color-mix(in srgb, #ffffff 14%, transparent);
```

These are **opaque on purpose** — see [the periwinkle bug](#why-the-fills-are-opaque).
Making them translucent again re-exposes you to whatever Nova paints beneath.

In that blur, `brightness(1.5)` does the visible work: it lifts the toolbar tone
showing through the fill. `blur()` contributes almost nothing, because the
toolbar behind the bar is a flat colour with no detail to blur.

### Sheen and specular — lines 2984 and 2992

`--uc-urlbar-glass-sheen` is the top-down white gradient.
`--uc-urlbar-glass-specular` is the bright-top / dark-bottom inset line pair —
this is what sells "pane of glass" rather than "tinted box".

**Setting the specular to `none` is the fastest way to dial the whole effect
down**; the bar goes flat-tinted but keeps its colours and corners.

---

## Corners and size

| Line | Variable | Value | Controls |
|------|----------|-------|----------|
| 56 | `--uc-rounded` | `1` | Master switch — `0` squares every popup again |
| 51 | `--uc-border-radius` | `10px` | Panels, menus, preview card, findbar |
| 2942 | `--uc-urlbar-panel-radius` | `16px` | Open dropdown only |
| 2980 | `--uc-urlbar-glass-radius` | `10px` | Closed URL bar |
| 66 | `--uc-urlbar-min-width` | `min(45vw, 780px)` | Resting bar width |
| 67 | `--uc-urlbar-max-width` | `min(58vw, 980px)` | Focused bar width |

`--uc-rounded` is FoxOne's own flag. It feeds `--panel-border-radius` for every
panel and menupopup, so flipping it to `1` is what rounded the tab preview card
and the hamburger menu — no per-popup rules needed. Row radius derives as half
of `--uc-border-radius` automatically.

**Keep the dropdown radius larger than the bar's.** Corner radius reads relative
to the box it's cut from: 10px on the 32px closed pill is a third of its height
and looks fully rounded, while the same 10px on a ~300px sheet is barely a
chamfer. Scaling the radius up with the box is what stops the bar appearing to
snap square when clicked.

**Width is zero-sum.** In FoxOne's one-line layout the URL bar and tab strip
split a single row. Every pixel the bar gains at rest is a pixel the tabs lose,
so a wider bar makes tabs hit their 76px floor (`--uc-tab-min-width`, line 82)
and overflow-scroll sooner. FoxOne's stock values were `35vw / 50vw`.

---

## Optional — safe to change back

Additions beyond the original brief. Each is now folded into the rule it used
to shadow, so there's one place to edit rather than two.

| Line | What | To revert |
|------|------|-----------|
| 1134 | Hover chip on result rows | `background: transparent` for FoxOne's text-only hover |
| 1142 | Keyboard-selected row chip | Delete the rule — it exists so arrow-key selection stays distinct from mouse hover |
| 449–456 | Hover chips in menus | Set the four `--button-background-color-*` back to `transparent` |
| 531 | Context-menu row hover | `background-color: transparent` |

If anything ever looks clipped at the bottom of the dropdown, remove
`overflow: hidden` at line 3115 (rule starts 3113). You lose the bottom corner
clip, nothing else.

---

## Structural — don't touch casually

Two changes are load-bearing rather than cosmetic.

**`color-scheme: dark !important`** (line 2897) — half the black-text fix.
Removing it brings back white leaks in native widgets, form controls, chrome
scrollbars and the Library trees.

**`@media all`** (line 278) — was `@media (prefers-color-scheme: dark)`.
The other half.

### Recommended: fix it at the source

Set **`ui.systemUsesDarkTheme` to `1`** (integer) in `about:config`.

Firefox then reports dark for chrome *and* content without setting a
lightweight theme — so it won't trip FoxOne's `[lwtheme]` branches the way
switching to the Dark theme in `about:addons` would. Both changes above stay
valid; they just stop being load-bearing.

---

## Background — why things are the way they are

### The black text

macOS was in **Light** mode. FoxOne's entire Gruvbox palette lived behind
`@media (prefers-color-scheme: dark)`, but its NAV BAR block paints
`#navigator-toolbox` with the dark `--uc-color-base` **unconditionally**.

Result: a `#282828` toolbar carrying Firefox's default light-mode **black**
text. Tab titles and toolbar text were hit too, not just the address bar.

### Why the fills are opaque

The first version used translucent `color-mix(…, transparent)` fills and let
the surface below show through. The dropdown came out pale lavender.

FoxOne aimed its field-tone rules at `.urlbar-background`, but its own note
records that Nova leaves that element **transparent** and moves the fill to
`.urlbar-input-container` — which FoxOne only handled under `[lwtheme]`. So the
panel fell through to Nova's native `light-dark()` token, which resolves
**white** on a light-resolved chrome. A 14% blue tint over white is periwinkle.
The tint was never wrong; the thing underneath it was.

Two consequences, both still true:

- Glass paints `.urlbar-input-container`, not `.urlbar-background`.
- Every fill is opaque, so the bar looks the same regardless of what Nova
  decides to paint under it.

**Never stack two translucent fills.** Two 88% layers composite to ~98.6% — a
translucent panel quietly turns opaque with no visible reason why. This is why
the result-list containers are forced transparent while the sheet carries the
only fill.

### Why closed-state rules are scoped `:not([open])`

`#urlbar` **contains** the result list, so `#urlbar:hover` is true whenever the
pointer is anywhere over the open dropdown — not just over the input row.

The hover rule had more pseudo-classes than the open-state rule, so it
out-ranked it and repainted the input container opaque, while `border-radius: 0`
from the open rule still won. An opaque square box landed on the sheet's
rounded top corners, and they appeared to square themselves the moment the
mouse entered the panel.

Scoping by state rather than escalating specificity is the fix: closed-state
and open-state rules now match **disjoint** element states, so neither can
out-rank the other and ordering stops mattering. Keep it that way when adding
rules — bumping specificity wins one race and leaves the same trap for the next.

### Why the open dropdown is one sheet

The field used to keep its own bordered glass box while the panel drew a second
bordered box under it — two edges where the eye expects one surface.

Now the field stops painting when the dropdown opens, and `.urlbar-background`
(which is `position: absolute; inset: 0`, so it already spans field row *and*
result list) becomes the single sheet. A hairline under the input row is all
that separates them.

Edges are **neutral white-alpha in every state**, never blue. A saturated
hairline is the one thing that stops a surface reading as glass — real glass
catches light along its edge, it doesn't get outlined. The blue lives in a
diffuse outer glow on focus instead.

---

## What was removed from stock FoxOne

Rules this build fully replaced were deleted rather than left to be shadowed.
Each site carries a comment saying where the behaviour now lives.

- URL-bar `border-radius` (square-everything rule) → per-state radius in the
  glass section.
- URL-bar field-tone rules for `.urlbar-background` in both open and closed
  states → they painted a transparent element on Nova; the glass section paints
  `.urlbar-input-container` instead.
- `:root[lwtheme] .urlbar-input-container` background paint → superseded.
- Duplicate declarations of seven config variables.
- Duplicate result-row hover, result-menu fill, bookmark-badge, panel-button and
  context-menu hover rules → values folded into FoxOne's originals.

**Not removed**, though inert here: the Windows Mica popup block
(`@media (-moz-windows-mica-popups)`) and the `@media all` wrapper. Both are
harmless, and the Mica block matters if this profile ever runs on Windows.

Because upstream rules were edited, a future FoxOne release **cannot** be
dropped in over this file — diff it instead.

---

## Applying changes

`userChrome.css` is read at startup — **restart Firefox** after editing.

Requires `toolkit.legacyUserProfileCustomizations.stylesheets = true`
(already set in this profile).

For faster iteration, enable `devtools.chrome.enabled` and
`devtools.debugger.remote-enabled`, then use the Browser Toolbox
(`Cmd+Opt+Shift+I`) to live-edit and inspect chrome elements.

---

## Upstream

FoxOne — https://github.com/Firsnschnee/FoxOne (MIT)
Based on Cascade by andreasgrafen; floating findbar / dynamic bookmarks from
LittleFox by biglavis.
