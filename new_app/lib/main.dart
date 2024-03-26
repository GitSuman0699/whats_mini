// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _text = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Single Character Input'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: TextEditingController()..text = _text,
//               maxLength: 1, // Limit to one character
//               keyboardType: TextInputType.text, // Default keyboard
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(
//                     r'[0-9a-zA-Z]')), // Allow only alphanumeric characters
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _text = value;
//                   if (_text.isNotEmpty) {
//                     // Print the integer value if it's a number
//                     if (RegExp(r'[0-9]').hasMatch(_text)) {
//                       final int number = int.parse(_text);
//                     } else {
//                       // Print the string value if it's a letter
//                       final String letter = _text;
//                     }
//                   }
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
