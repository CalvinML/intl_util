// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Timeout(const Duration(seconds: 180))

/// Test for parsing the examples argument from an Intl.message call. Very
/// minimal so far.
import 'package:test/test.dart';
import 'package:intl_util/extract_messages.dart';
import '../data_directory.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

main() {
  test("Message examples are correctly extracted", () {
    var file = path.join(packageDirectory, 'test', 'message_extraction',
        'sample_with_messages.dart');
    var extraction = new MessageExtraction();
    var messages = extraction.parseFile(new File(file));
    expect(messages['message2'].examples, {"x": 3});
  });
}
