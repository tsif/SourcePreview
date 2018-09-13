[![Build Status](https://travis-ci.com/tsif/SourcePreview.svg?token=8ZyhMMGarwUGfCibCHGk&branch=master)](https://travis-ci.com/tsif/SourcePreview) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  ![version: 1.0.1](https://img.shields.io/badge/version-1.0.1-green.svg)

# SourcePreview

Quick look plugin for macOS for source code files in swift. Inspired by [QLMarkDown](https://github.com/toland/qlmarkdown) and [QLSwift](https://github.com/lexrus/QLSwift). Source code is rendered by using [prism.js](https://prismjs.com/).

by Dimitri James Tsiflitzis dimitrijam.es

design by Dimitris Niavis 

![Alt Text](https://github.com/tsif/SourcePreview/blob/develop/SourcePreview/screenshots/preview.png)

![Alt Text](https://github.com/tsif/SourcePreview/blob/develop/SourcePreview/screenshots/thumbnail.png)

## Installation

Pick any of the methods below:

- Once you clone this repo, you can run the `SourcePreview` scheme in xcode. A post build step copies `SourcePreview.qlgenerator` into `~/Library/QuickLook` and you can start previewing swift files.

- You can build an installer package yourself. Run the project at least once in xcode. Then, in a terminal, go to the `installer` folder located in the `SourcePreview` folder. Run the `build.sh` file. Running this command will create a `.pkg` file in the `compiled` folder. Double click on the `.pkg` and follow the prompts to install the plugin.

- Download the latest [release](https://github.com/tsif/SourcePreview/releases/tag/1.0.1) from https://github.com/tsif/SourcePreview/releases. You can copy `SourcePreview.qlgenerator` into `~/Library/QuickLook` manually (run `qlmanage -r` once you do this) or you can run the installer package located here.

## Removal

Drag `SourcePreview.qlgenerator` located in `~/Library/QuickLook` into the trash.

## License

```
MIT License

Copyright (c) 2018 tsif

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Version History

Version 1.0.1 - September 18, 2018

- Initial release.

