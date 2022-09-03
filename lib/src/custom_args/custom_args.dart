import 'package:very_easy_localization/src/custom_args/arg.dart';

class CustomArgs {
  static Arg get help => Arg('help', 'h', 'Shows the help');

  static Arg get version =>
      Arg('version', 'v', 'Prints the Very Easy Localization CLI Version');

  static Arg get outputDirectory =>
      Arg('output-directory', 'o', 'pass the output directory',
          defaultValue: './ve_localization');

  static Arg get excludeLibFiles => Arg('exclude-lib-files', 'e',
      'exclude certain files that you don\'t want to be included in localization process from ./lib/*');

  static Arg get languages =>
      Arg('languages', 'l', 'Pass the languages', defaultValue: 'en,hi');

  static Arg get includeExternalFiles => Arg('include-external-files', 'i',
      'include files other than ./lib/* for searching');
}
