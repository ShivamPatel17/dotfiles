# Vim Motions

- to see all the motions available to you in neovim, use `'<backspace`

# Macros

- record with `q<register>` and stop recording by pressing `q` again
  - <register> can be any lower case letter
- replay the macros with `@<register`
  - `@@` replays the last recorded macro

## Selecting

- select within a pair of {}, [], ()
  - `<vi[>`,`<vi]>`,`<vi{>`,`<vi}>`,`<vi)>`,`<vi(>`

## Editing multiple lines

- go into visual-block mode with `<^V>` (and then move the cursor to see the mode change in your neovim)
- select all the lines you want to edit by hitting `j` for each line
- then hit `I` to go to insert mode and make the change you want on that top line, then hit `esc` to apply to all the lines you selected

## How to highlight the last highlight text again

- `gv`

## Marking

- `m<letter>` to mark under the curson
  - then use `'<letter>` to go to the mark
  - use lowercase letters to jump between marks in a file
  - use uppercaes letters for global marks

https://www.youtube.com/watch?v=RdyfT2dbt78&ab_channel=HenryMisc

<b>hello world</b>
<b>goodbye moon</b>
<b>cool cucumber</b>
<b>hello world</b>
<b>hello world</b>
<b>hello world</b>
<b>goodbye moon</b>
<b>cool cucumber</b>
<b>goodbye moon</b>
<b>cool cucumber</b>
<b>goodbye moon</b>
<b>cool cucumber</b>
