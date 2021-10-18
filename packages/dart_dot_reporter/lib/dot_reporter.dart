import 'dart:io';

import 'model.dart';
import 'parser.dart';

class DotReporter {
  final Parser parser;

  int failedCount = 0;
  int skippedCount = 0;
  int successCount = 0;
  // StringBuffer buffer = StringBuffer();

  final bool showId;
  final bool showSuccess;
  final bool hideSkipped;
  final bool failSkipped;
  final bool showMessage;
  final bool noColor;
  final Stdout out;

  DotReporter({
    required this.parser,
    required this.out,
    this.showId = false,
    this.showSuccess = false,
    this.hideSkipped = false,
    this.failSkipped = false,
    this.showMessage = false,
    this.noColor = false,
  });

  void printReport() {
    // Mutates results, used to remove invalid parsed data
    parser.tests.removeWhere((k, v) => v.state == null);

    _countTestResults();
    final resultIconsLine = _renderSingleLineOfIcons();
    final result = _renderShortResultLines();

    _render(resultIconsLine, result);

    // var file = File('failed_unit_tests.txt');
    // var sink = file.openWrite();
    // sink.write(buffer.toString());
    // sink.close();

    if (skippedCount > 0 && failSkipped) {
      exitCode = 1;
    }
    if (failedCount > 0) {
      exitCode = 2;
    }
  }

  void _render(String resultIconsLine, String result) {
    out.write(resultIconsLine);

    out.writeln();
    out.writeln();

    out.write(result);

    out.writeln();
    out.writeln();

    out.writeAll(
      [
        'Total: ${parser.tests.length}',
        _green('Success: $successCount'),
        _yellow('Skipped: $skippedCount'),
        _red('Failure: $failedCount'),
      ],
      '\n',
    );
    out.writeln();
  }

  String _renderShortResultLines() {
    return parser.tests.values
        .where((i) {
          final hideSuccess = !showSuccess && i.state == State.success;
          final _hideSkipped = hideSkipped && i.state == State.skipped;
          if (_hideSkipped) {
            return false;
          }
          if (hideSuccess) {
            return false;
          }

          return true;
        })
        .map(_testToString)
        .join('\n');
  }

  String _renderSingleLineOfIcons() =>
      parser.tests.values.map(_getIcon).join('');

  void _countTestResults() {
    for (final item in parser.tests.values) {
      switch (item.state) {
        case State.failure:
          failedCount += 1;
          break;
        case State.skipped:
          skippedCount += 1;
          break;
        case State.success:
          successCount += 1;
          break;
        default:
      }
    }
  }

  String _getIcon(TestModel model) {
    switch (model.state) {
      case State.failure:
        return _red('X');
      case State.skipped:
        return _yellow('!');
      case State.success:
        return _green('.');
      default:
        return '?';
    }
  }

  String _testToString(TestModel model) {
    var base = '${_getIcon(model)} ';
    var fileNameIndex = model.filename.indexOf('packages/');
    if (fileNameIndex == -1) {
      fileNameIndex = model.filename.indexOf('test/');
    }
    final fileNameShow = fileNameIndex == -1
        ? model.filename
        : model.filename.substring(fileNameIndex);
    switch (model.state) {
      case State.failure:
        base += _red('[${model.name}] in $fileNameShow');
        // buffer.writeln(fileNameShow);
        break;
      case State.skipped:
        base += _yellow(model.name);
        break;
      case State.success:
        base += _green(model.name);
        break;
      default:
        base += model.name;
        break;
    }

    if (model.message != null && showMessage) {
      base += '\n${model.message}';
    }
    if (showId) {
      return '${model.id} $base';
    }
    return base;
  }

  String _red(String text) {
    if (noColor) {
      return text;
    }
    return '\x1B[31m$text\x1B[0m';
  }

  String _green(String text) {
    if (noColor) {
      return text;
    }
    return '\x1B[32m$text\x1B[0m';
  }

  String _yellow(String text) {
    if (noColor) {
      return text;
    }
    return '\x1B[33m$text\x1B[0m';
  }
}
