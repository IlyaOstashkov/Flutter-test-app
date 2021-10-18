import 'dart:io';

import 'dot_reporter.dart';
import 'parser.dart';

Future<void> run({
  required String path,
  bool failSkipped = false,
  bool showSuccess = false,
  bool hideSkipped = false,
  bool showId = false,
  bool showMessage = false,
  bool noColor = false,
}) async {
  final parser = Parser();

  await parser.parseFile(path);

  DotReporter(
    parser: parser,
    showSuccess: showSuccess,
    hideSkipped: hideSkipped,
    failSkipped: failSkipped,
    showId: showId,
    showMessage: showMessage,
    noColor: noColor,
    out: stdout,
  ).printReport();
}
