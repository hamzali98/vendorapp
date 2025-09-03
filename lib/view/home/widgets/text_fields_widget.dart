// import 'package:flutter/material.dart';
//
// import '../../../res/colors/app_color.dart';
//
// class TextFieldView extends StatelessWidget {
//   final String label;
//
//   const TextFieldView({required this.label, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       cursorColor: AppColor.primeryBlueColor, // Navy blue cursor
//       style: const TextStyle(color: AppColor.primeryBlueColor),
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColor.primeryBlueColor, width: 2.0), // Navy blue color
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../res/colors/app_color.dart';

class TextFieldView extends StatelessWidget {
  final String label;
  final TextEditingController? controller; // 👈 added controller here

  const TextFieldView({
    required this.label,
    this.controller, // 👈 controller is optional
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // 👈 connected here
      cursorColor: AppColor.primeryBlueColor, // Navy blue cursor
      style: const TextStyle(color: AppColor.primeryBlueColor),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primeryBlueColor, width: 2.0), // Navy blue color
        ),
      ),
    );
  }
}
