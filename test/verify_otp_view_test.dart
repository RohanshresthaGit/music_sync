// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:music_sync/features/auth/view/verify_email_view.dart';

// void main() {
//   testWidgets('invokes verify callback with the email and otp', (
//     WidgetTester tester,
//   ) async {
//     String? capturedEmail;
//     String? capturedOtp;

//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           home: VerifyOtpView(
//             email: 'user@example.com',
//             onVerify: (email, otp) async {
//               capturedEmail = email;
//               capturedOtp = otp;
//             },
//           ),
//         ),
//       ),
//     );

//     for (var index = 0; index < 6; index++) {
//       await tester.enterText(
//         find.byType(TextFormField).at(index),
//         (index + 1).toString(),
//       );
//       await tester.pump();
//     }

//     await tester.tap(find.text('Verify'));
//     await tester.pump();

//     expect(capturedEmail, 'user@example.com');
//     expect(capturedOtp, '123456');
//   });
// }
