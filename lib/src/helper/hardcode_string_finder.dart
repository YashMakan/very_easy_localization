class HardcodeStringFinder {
  var regex = RegExp("\".*?\"");
  var regexDart = RegExp("'.*?'");
  RegExp regExp = RegExp('\\\${.*?\\}');

  bool shouldInclude(String it) {
    return it.isNotEmpty &&
        !it.contains("assets") &&
        !it.contains(".png") &&
        !it.contains(".jpeg") &&
        !it.contains(".mp3") &&
        !it.contains(".mkv") &&
        !it.contains("_") &&
        !it.contains("/") &&
        !it.contains("#") &&
        it.trim().length > 1 &&
        !it.contains(".svg");
  }

  String extractHardCodedString(String it, String input) {
    return it.replaceAll("\"", "").replaceAll("'", "").trim();
  }

  List<String> findHardCodedStrings(String content) {
    Iterable<RegExpMatch> result = regex.allMatches(content);

    var strings = <String>[];

    for (var e in result) {
      var string = extractHardCodedString(e.group(0)!, e.input);
      var jsonParamAccessString =
          e.input.codeUnitAt(e.start - 1) == '['.codeUnits.first &&
              e.input.codeUnitAt(e.end) == ']'.codeUnits.first;
      var jsonParamSetString = e.input.codeUnitAt(e.end) == ':'.codeUnits.first;
      var uselessArguements = string.startsWith("\${") && string.endsWith("}");

      var include = shouldInclude(string) &&
          !jsonParamSetString &&
          !jsonParamAccessString &&
          !uselessArguements;
      if (include) {
        if (regExp.hasMatch(string)) {
          strings.add(string.replaceAll(regExp, '{}'));
        } else {
          strings.add(string);
        }
      }
    }

    Iterable<RegExpMatch> result1 = regexDart.allMatches(content);

    for (var e in result1) {
      var string = extractHardCodedString(e.group(0) ?? "", e.input);

      var jsonParamAccessString =
          e.input.codeUnitAt(e.start - 1) == '['.codeUnits.first &&
              e.input.codeUnitAt(e.end) == ']'.codeUnits.first;
      var jsonParamSetString = e.input.codeUnitAt(e.end) == ':'.codeUnits.first;
      var uselessArguements = string.startsWith("\${") && string.endsWith("}");

      var include = shouldInclude(string) &&
          !jsonParamSetString &&
          !jsonParamAccessString &&
          !uselessArguements;
      if (include) {
        if (regExp.hasMatch(string)) {
          strings.add(string.replaceAll(regExp, '{}'));
        } else {
          strings.add(string);
        }
      }
    }

    return strings;
  }
}
