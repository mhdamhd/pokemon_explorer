import 'package:flutter_test/flutter_test.dart';

class StringEquals extends CustomMatcher {
  StringEquals(expected)
      : super(
          "Objects string representations which are ",
          "String representation",
          predicate(
            (actual) => actual.toString() == expected.toString(),
            "equal",
          ),
        );
  @override
  featureValueOf(actual) => actual;
}
