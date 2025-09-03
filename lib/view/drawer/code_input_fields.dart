import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors/app_color.dart';
import 'oder_detail_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// ✅ **Handle Code Submission**
  void _submitCode() {
    String enteredCode = controllers.map((c) => c.text).join();
    if (enteredCode.length < 4) {
      Get.snackbar("Error", "Please enter all 4 digits.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    print("Entered Code: $enteredCode");

    // ✅ Navigate to Order Details Screen
    Get.to(() => OrderDetailsScreen(orderCode: enteredCode));
  }


  /// ✅ **Handle Digit Entry & Move Focus**
  void _onDigitEntered(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        _submitCode();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgcolor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primeryBlueColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter 4-Digit Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            /// ✅ **4 Digit Code Fields**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: size.width * 0.12,
                  height: size.width * 0.12,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColor.primeryBlueColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColor.primeryBlueColor, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) => _onDigitEntered(index, value),
                  ),
                );
              }),
            ),

            SizedBox(height: 30),

            /// ✅ **Confirm Button**
            ElevatedButton(
              onPressed: _submitCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primeryBlueColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Confirm", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
