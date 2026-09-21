import 'package:flutter_test/flutter_test.dart';
import 'package:edu_01/content_expansion.dart';
import 'package:edu_01/deep_dive.dart';
import 'package:edu_01/games_v2.dart';
import 'package:edu_01/histology.dart';
import 'package:edu_01/smart_study.dart';

void main() {
  test('education content baselines are populated', () {
    expect(histologyEntries.length, greaterThanOrEqualTo(30));
    expect(histologyPaths.length, greaterThanOrEqualTo(7));
    expect(DeepDiveRegistry.roots.length, greaterThanOrEqualTo(9));
    expect(studyQuestionBank.length, greaterThanOrEqualTo(36));
    expect(gameItems.length, greaterThanOrEqualTo(30));
    expect(expandedContent.length, greaterThanOrEqualTo(90));
  });

  test('expanded catalog includes all major v0.24 families', () {
    final types = expandedContent.map((e) => e.type).toSet();
    expect(types.contains(ExpandedContentType.muscle), isTrue);
    expect(types.contains(ExpandedContentType.joint), isTrue);
    expect(types.contains(ExpandedContentType.ligament), isTrue);
    expect(types.contains(ExpandedContentType.lymphatic), isTrue);
    expect(types.contains(ExpandedContentType.reproductive), isTrue);
    expect(types.contains(ExpandedContentType.primaryTooth), isTrue);
  });
}
