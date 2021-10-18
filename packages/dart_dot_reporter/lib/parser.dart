import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'model.dart';

class Parser {
  Map<int, TestModel> tests = {};

  Future<dynamic> parseFile(String path) {
    return File(path)
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .forEach(_parseLine);
  }

  void _parseLine(String jsonString) {
    Map<String, dynamic> line;
    try {
      line = jsonDecode(jsonString);
    } catch (e) {
      return;
    }

    if (line.containsKey('type')) {
      _parseTestStart(line);
      _parseTestError(line);
      _parseTestDone(line);
    }
  }

  void _parseTestStart(Map<String, dynamic> line) {
    if (line['type'] == 'testStart') {
      final int id = line['test']['id'];
      final String name = line['test']['name'];
      final String? filename = line['test']['root_url'];
      final String? fileNameUrl = line['test']['url'];

      if (name.startsWith('loading /')) {
        return;
      }

      final model = tests.putIfAbsent(id, () => TestModel(name, filename ?? fileNameUrl ?? ''));
      model.id = id;

      if (line['test']['metadata']['skip']) {
        model.state = State.skipped;
      }
    }
  }

  void _parseTestError(Map<String, dynamic> line) {
    if (line['type'] == 'error') {
      final int id = line['testID'];
      final String error = line['error'];

      final model = tests[id];
      if (model != null) {
        if (error.startsWith('Test failed. See exception logs above.')) {
          model.message = '\tUnexpected exception.\n';
        } else {
          model.message = error.endsWith('\n') ? '\t$error' : '\t$error\n';
        }
      }
    }
  }

  void _parseTestDone(Map<String, dynamic> line) {
    if (line['type'] == 'testDone') {
      final int id = line['testID'];

      final model = tests[id];
      if (model != null && model.state == null) {
        model.state = line['result'] == 'success' ? State.success : State.failure;
      }
    }
  }
}
