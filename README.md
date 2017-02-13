# Company backend for typing Unicode super- and subscripts.

## Usage

Run
```emacs-lisp
(add-to-list 'company-backends 'company-unicode-subsuper)
(setq-local company-minimum-prefix-length 1)
```
and enable `company-mode`. Then complete `_1` to `₁`, `^+` to `⁺`, `^theta` to `ᶿ`, etc.

## Supported characters

The list of numbers, operators, small, capital, and Greek letters that Unicode supports as super- and subscripts was obtained [from Wikipedia](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts). 

Here is the complete list:

- numbers and operators `₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾`
- capital letters (only superscript) `ᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂ`
- small letters `ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ`
- Greek letters `ᵝᵞᵟᶿᶥᵠᵡᵦᵧᵨᵩᵪ`

Greek letters are entered as `_beta`, `_gamma`, `_delta`, `_theta`, `_iota`, `_varphi`, `_chi`, and similarly for subscripts. *Note that phonetic characters are not supported.*

## Bugs and contributions

If you notice a bug or would like to contribute, please open an issue on Github or submit a PR.

## Acknowledgments

I learned a lot about writing [company-mode](http://company-mode.github.io/) backends from [two blog](http://sixty-north.com/blog/writing-the-simplest-emacs-company-mode-backend) [posts](http://sixty-north.com/blog/a-more-full-featured-company-mode-backend) Austin Bingham. Many workarounds were inspired by [company-math](https://github.com/vspinu/company-math).
