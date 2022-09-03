# Very Easy Localization
## Generate Custom Localization JSON with over 100 languages with single click 👆

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Very Easy Localization is a CLI Tool which helps in extracting strings from your Flutter App & create localization in 100+ languages using google translate.
## Installation

`dart pub global activate very_easy_localization`

## Basic Usage

`dart pub global run very_easy_localization --help`

## Basic Options

```
 -------------------------------------------------------------------
|                                                                   |
| -h, --help       Shows the help                                   |
| -v, --version    Prints the Very Easy Localization CLI Version    |
| run              Run the localization process                     |
|                                                                   |
 -------------------------------------------------------------------
```


## Generating

`dart pub global run very_easy_localization run`

## Run Options

```
 --------------------------------------------------------------------------------
|                                                                                |
| -h, --help                    Shows the help                                   |
| -v, --version                 Prints the Very Easy Localization CLI Version    |
| -l, --languages               Pass the languages eg: en,ja,... [defaut: en,hi] |
| -i, --include-external-files  External Lib Files eg: ./assets/file.txt         |
| -o, --output-directory        Output Directory [default: ./ve_localization]    |
|                                                                                |
 --------------------------------------------------------------------------------
```
## License

MIT
