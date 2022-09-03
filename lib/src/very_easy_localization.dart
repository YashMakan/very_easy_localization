import 'dart:io';
import 'package:translator/translator.dart';
import './helper/hardcode_string_finder.dart';

class VeryEasyLocalizarion {
  static List<String> extractAllStringsInFile(File element) {
    var finder = HardcodeStringFinder();
    var content = element.readAsStringSync();
    var stringsFounded = finder.findHardCodedStrings(content);
    return stringsFounded;
  }

  static Future<Map<String, String>> getAllStringsTranslation(
      List<String> strings, String language) async {
    Map<String, String> jsonTranslations = {};
    final translator = GoogleTranslator();
    for (var string in strings) {
      var translation = await translator.translate(string, to: language);
      jsonTranslations[string] = translation.text;
    }
    return jsonTranslations;
  }
}
