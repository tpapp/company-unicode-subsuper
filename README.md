# Company backend for typing Unicode super- and subscripts.

## Usage

Run
```emacs-lisp
(add-to-list 'company-backends 'company-unicode-subsuper)
(setq-local company-minimum-prefix-length 1)
```
and enable `company-mode`.

## Supported characters

See the list of numbers, operators, small, capital, and Greek letters that Unicode supports as super- and subscripts [on Wikipedia](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts). Note that phonetic characters are not supported.

## Bugs and contributions

If you notice a bug or would like to contribute, please open an issue on Github or submit a PR.

## Acknowledgments

I learned a lot about writing [company-mode](http://company-mode.github.io/) backends from [two blog](http://sixty-north.com/blog/writing-the-simplest-emacs-company-mode-backend) [posts](http://sixty-north.com/blog/a-more-full-featured-company-mode-backend) Austin Bingham. Many workarounds were inspired by [company-math](https://github.com/vspinu/company-math).
