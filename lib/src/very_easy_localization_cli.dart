import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:args/args.dart';
import 'package:very_easy_localization/src/custom_args/custom_args.dart';
import 'package:very_easy_localization/src/very_easy_localization.dart';
import 'package:very_easy_localization/src/custom_args/very_easy_localization_args.dart';

class VeryEasyLocalizationCli {
  VeryEasyLocalizationCli();

  static String get version => '0.0.1';

  static String get description =>
      'A command line tool to create Localization for your Flutter Apps';

  static String get usage => '''
 -------------------------------------------------------------------
|                                                                   |
| -h, --help       Shows the help                                   |
| -v, --version    Prints the Very Easy Localization CLI Version    |
| run              Run the localization process                     |
|                                                                   |
 -------------------------------------------------------------------
''';

  static String get runUsage => '''
 --------------------------------------------------------------------------------
|                                                                                |
| -h, --help                    Shows the help                                   |
| -v, --version                 Prints the Very Easy Localization CLI Version    |
| -l, --languages               Pass the languages eg: en,ja,... [defaut: en,hi] |
| -i, --include-external-files  External Lib Files eg: ./assets/file.txt         |
| -o, --output-directory        Output Directory [default: ./ve_localization]    |
|                                                                                |
 --------------------------------------------------------------------------------
''';

  static String get help => '''
  A command line tool to create Localization for your Flutter Apps.
  ''';

  static Future<void> parse(List<String> arguments) async {
    final parser = CustomArgParser();
    final command = parser.addRunCommand();
    ArgResults parserResults = parser.parse(arguments);

    if (parserResults.arguments.contains('--${CustomArgs.help.name}') ||
        parserResults.arguments.isEmpty) {
      print(logo);
      print(usage);
    } else if (parserResults.arguments
        .contains('--${CustomArgs.version.name}')) {
      print('Very Easy Localization CLI Version: $version');
    } else if (parserResults.command?.name == 'run') {
      getResultsForRunCommand(command, command.parse(arguments));
    } else {
      print(logo);
      print(usage);
      print('\n\nNo command specified ${parserResults.arguments}');
    }
  }

  static Future<void> getResultsForRunCommand(
      ArgParser parser, ArgResults results) async {
    List<String> languages = [];
    List<String> includedExternalFiles = [];
    String outputDirectoryPath = '';
    if (results.arguments.contains('--${CustomArgs.help.name}') ||
        results.arguments.isEmpty) {
      print(logo);
      print(runUsage);
      return;
    } else if (results.arguments
        .contains('--${CustomArgs.includeExternalFiles.name}')) {
      includedExternalFiles = List<String>.from(
          results[CustomArgs.includeExternalFiles.name]
              .split(',')
              .map((e) => e.trim())
              .toList());
    }
    languages = List<String>.from(results[CustomArgs.languages.name]
        .split(',')
        .map((e) => e.trim())
        .toList());
    outputDirectoryPath = results[CustomArgs.outputDirectory.name];
    if (languages.isNotEmpty && outputDirectoryPath.isNotEmpty) {
      List<File> files = [];
      List<String> unableToAddFiles = [];
      Directory outputDirectory = Directory(outputDirectoryPath);
      Directory libDirectory = Directory("./lib");
      bool doesOutputDirectoryExsits = await outputDirectory.exists();
      if (!doesOutputDirectoryExsits) {
        try {
          outputDirectory.create();
        } catch (_) {
          throw Exception("Unable To create the output directory :/");
        }
      }
      final List<FileSystemEntity> libFiles =
          await libDirectory.list(recursive: true).toList();
      files.addAll(libFiles.whereType<File>().toList());
      for (var externalFile in includedExternalFiles) {
        try {
          files.add(File(externalFile));
        } catch (_) {
          unableToAddFiles.add(externalFile);
        }
      }
      List<String> strings = [];
      print(">>> Finding Strings in passed Files");
      for (var file in files) {
        strings.addAll(VeryEasyLocalizarion.extractAllStringsInFile(file));
      }
      print("${strings.length} strings Found.");
      print("\n");
      String outputFilenameFormat = "{}.json";
      for (var language in languages) {
        String outputFilename =
            outputFilenameFormat.replaceAll('{}', language.toLowerCase());
        File outputFile = File(path.join(outputDirectory.path, outputFilename));
        print(
            ">>> Translating Found Strings to $language -> ${outputFile.path}");
        Map<String, String> jsonTranslations = {};
        jsonTranslations["@@locale"] = language;
        jsonTranslations["@@last_modified"] = DateTime.now().toIso8601String();
        jsonTranslations.addAll(
            await VeryEasyLocalizarion.getAllStringsTranslation(
                strings, language.toLowerCase()));
        JsonEncoder encoder = JsonEncoder.withIndent("  ");
        outputFile.writeAsStringSync(encoder.convert(jsonTranslations));
      }
    }
  }
}

const String logo = """
█░█ █▀▀ █▀█ █▄█   █▀▀ ▄▀█ █▀ █▄█   █░░ █▀█ █▀▀ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
▀▄▀ ██▄ █▀▄ ░█░   ██▄ █▀█ ▄█ ░█░   █▄▄ █▄█ █▄▄ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█
LOCALIZE YOUR FLUTTER APPS IN 100+ LANGUAGES WITH A SINGLE CLICK
""";
