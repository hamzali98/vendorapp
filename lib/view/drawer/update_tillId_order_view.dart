import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/res/colors/app_color.dart';
import '../../../models/scan_confirm/scan_till_id_confirm_order_model.dart';
import '../../view_models/controller/scan_confirm/update_tillId_order_view_model.dart';
import '../home/home_view.dart';

class UpdateOrderScreen extends StatefulWidget {
  final OrderDetails orderDetails;

  UpdateOrderScreen({required this.orderDetails});

  @override
  _UpdateOrderScreenState createState() => _UpdateOrderScreenState();
}

class _UpdateOrderScreenState extends State<UpdateOrderScreen> {
  final UpdateTillIDOrderController updateController = Get.put(UpdateTillIDOrderController());

  late String orderId;
  late String customerId;
  late String customerName;
  late String customerPhone;
  late String customerAddress;
  late TextEditingController bagsController;
  late TextEditingController weightController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    orderId = widget.orderDetails.orderId.toString();
    customerId = widget.orderDetails.customer?.userId.toString() ?? 'N/A';
    customerName = widget.orderDetails.customer?.name ?? 'Unknown';
    customerPhone = widget.orderDetails.customer?.mobile ?? 'No Phone';
    customerAddress = widget.orderDetails.customerAddress?.address ?? 'No Address';

    bagsController = TextEditingController(text: widget.orderDetails.totalBags?.toString() ?? '');
    weightController = TextEditingController(text: widget.orderDetails.weight?.toString() ?? '');
    priceController = TextEditingController(text: widget.orderDetails.orderPrice?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Detail", style: TextStyle(color: AppColor.bgcolor)),
        backgroundColor: AppColor.primeryBlueColor, // Primary Blue Background
        iconTheme: IconThemeData(color: AppColor.bgcolor), // White Back Button
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // /// 🔹 Customer Details (Non-Editable)
              // buildSectionTitle("Customer Details"),
              // buildCard([
              //   buildRow("Customer Name", customerName),
              //   buildRow("Phone Number", customerPhone),
              //   buildRow("Address", customerAddress),
              // ]),
              // SizedBox(height: 15),

              /// 🔹 Order Details (Non-Editable)
              buildSectionTitle("Order Details"),
              buildCard([
                buildRow("Order ID", orderId),
               // buildRow("Customer ID", customerId),
                buildRow("Order Type", widget.orderDetails.orderType ?? 'N/A'),
                buildRow("Order Status", widget.orderDetails.orderStatus ?? 'N/A'),
              ]),
              SizedBox(height: 15),

              /// 🔹 Editable Fields
              buildSectionTitle("Update Order"),
              buildCard([
                buildTextField("No. of Bags", bagsController),
                buildTextField("Weight (lb)", weightController),
                buildTextField("Total Price", priceController),
              ]),
              SizedBox(height: 20),

              /// 🔹 Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primeryBlueColor, // Primary Blue
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    updateController.updateOrderByTillID(
                      orderId,
                      customerId,
                      bagsController.text.trim(),
                      weightController.text.trim(),
                      priceController.text.trim(),
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      Get.offAll(HomeView()); // Replace '/home' with your actual home route
                    });
                  },
                  child: Text("Submit Update", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
    );
  }

  Widget buildCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
