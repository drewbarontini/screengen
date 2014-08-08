Screengen
=========

Wrapper around [webkit2png](http://www.paulhammond.org/webkit2png/) for grabbing screenshots, grabbing screenshots from a text file containing URLs, and grabbing
incrementing screenshots.

Installation
------------

First, you need [webkit2png](http://www.paulhammond.org/webkit2png/). I recommend installing it via [Homebrew](http://brew.sh/)

```bash
brew install webkit2png
```

Next, you'll need to move the contents of `screengen.sh` into your `~/.bash_profile`.

Usage
-----

**Initialization**

```bash
sg-init
```

This command creates a `screengen` directory with a `urls.txt` file, and then moves into that diretory for you to generate the screenshots.

**Basic Single Screenshot**

```bash
sg google.com # Standard, 1440x900 screenshot
sg 800 600 google.com # 800x600 screenshot
```

**Screenshots From File**

```bash
sg-file urls.txt
```

`urls.txt`:

```text
google.com 800x600
dribbble.com 1024x768
github.com 1280x800
```

Which will generate:

- `screenshot-google-full.png`
- `screenshot-dribbble-full.png`
- `screenshot-github-full.png`

**Incrementing Screenshots**

```bash
run 10 sg-inc 1024 768 example.com/#
```

Which will output:

- `screenshot-1.png`
- `screenshot-2.png`
- `screenshot-3.png`
- `screenshot-4.png`
- `screenshot-5.png`
- `screenshot-6.png`
- `screenshot-7.png`
- `screenshot-8.png`
- `screenshot-9.png`
- `screenshot-10.png`

**Note**: This is based on the URL having an incrementing number. For example, an HTML slidedeck.

