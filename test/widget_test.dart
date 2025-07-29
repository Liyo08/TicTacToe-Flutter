import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_game/main.dart'; // Adjust path based on your project

void main() {
  testWidgets('Tap on cell updates board with X', (WidgetTester tester) async {
    // Pump the widget into the test environment
    await tester.pumpWidget(TicTacToe());

    // Find all the cells in the grid
    final cells = find.byType(GestureDetector);

    // Verify initial state is empty
    expect(find.text('X'), findsNothing);
    expect(find.text('O'), findsNothing);

    // Tap the first cell
    await tester.tap(cells.at(0));
    await tester.pump();

    // After tapping, cell should show "X"
    expect(find.text('X'), findsOneWidget);
  });
}