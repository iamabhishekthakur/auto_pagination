import 'package:flutter_test/flutter_test.dart';

import 'package:auto_pagination/auto_pagination.dart';

void main() {
  testWidgets('AutoPagination comman test', (tester) async {
    await tester.pumpWidget(const AutoPagination(
      items: [],
    ));
  });
}
