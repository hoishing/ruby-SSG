# Ruby Static Site Generator

[![GitHub](https://img.shields.io/github/license/hoishing/ruby-SSG)](https://opensource.org/licenses/MIT)

- a simple static site generator using Ruby and `.plist` files.

## Motivation

I need a simple web version my mobile app [Understanding Buddhism (認識佛教)](https://apps.apple.com/hk/app/%E8%AA%8D%E8%AD%98%E4%BD%9B%E6%95%99-%E6%9C%89%E8%81%B2%E6%9B%B8/id389971161). I want to reuse the `.plist` files that defines the audio contents of the app. However, existing SSG on the market couldn't generate a site with `.plist` files without heavy customization. So I wrote a simple one using Ruby myself.

## Program Logic

- variable contents defined in `.plist` files
- parse the `.plist` file and fit them into the `template.htm`
- use bootstrap as the css framework

## Generated Contents

- [認識佛教 - 粵語版](https://hoishing.github.io/ruby-SSG/index_zh.htm)
- [認識佛教 - 華語版](https://hoishing.github.io/ruby-SSG/index_cn.htm)

## Questions?

Open a [github issue](https://github.com/hoishing/ruby-SSG/issues) or ping me on [Twitter](https://twitter.com/hoishing) ![](https://api.iconify.design/logos/twitter.svg?width=20)
