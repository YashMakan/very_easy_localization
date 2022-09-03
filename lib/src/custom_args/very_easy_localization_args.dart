import 'package:args/args.dart';
import 'package:very_easy_localization/src/custom_args/custom_args.dart';

class CustomArgParser {
  ArgParser customArgParser = ArgParser();
  ArgParser? runCommand;

  CustomArgParser() {
    customArgParser
      ..addFlag(CustomArgs.help.name,
          abbr: CustomArgs.help.abbr,
          help: CustomArgs.help.description,
          negatable: CustomArgs.help.negatable)
      ..addFlag(CustomArgs.version.name,
          abbr: CustomArgs.version.abbr,
          help: CustomArgs.version.description,
          negatable: CustomArgs.version.negatable);
  }

  ArgParser addRunCommand() {
    runCommand = customArgParser.addCommand('run');
    runCommand!
      ..addOption(CustomArgs.languages.name,
          abbr: CustomArgs.languages.abbr,
          help: CustomArgs.languages.description,
          defaultsTo: CustomArgs.languages.defaultValue)
      ..addOption(CustomArgs.includeExternalFiles.name,
          abbr: CustomArgs.includeExternalFiles.abbr,
          help: CustomArgs.includeExternalFiles.description)
      ..addOption(CustomArgs.excludeLibFiles.name,
          abbr: CustomArgs.excludeLibFiles.abbr,
          help: CustomArgs.excludeLibFiles.description)
      ..addOption(CustomArgs.outputDirectory.name,
          abbr: CustomArgs.outputDirectory.abbr,
          help: CustomArgs.outputDirectory.description,
          defaultsTo: CustomArgs.outputDirectory.defaultValue)
      ..addFlag(CustomArgs.help.name,
          abbr: CustomArgs.help.abbr,
          help: CustomArgs.help.description,
          negatable: CustomArgs.help.negatable);
    return runCommand!;
  }

  ArgResults parse(List<String> arguments, {String? command}) {
    if (command == null) {
      return customArgParser.parse(arguments);
    } else {
      return runCommand!.parse(arguments);
    }
  }
}
