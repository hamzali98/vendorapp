import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/components/custom_appbar.dart';
import 'package:vendor_app/res/colors/app_color.dart';
import 'package:vendor_app/view/home/home_view.dart';

import '../../models/create_new_drop_off/generate_receipt_model.dart';
import '../../view_models/controller/create_new_drop_off/generate_dropoff_receipt_model.dart';

class OrderReceiptScreen extends StatelessWidget {
  final String orderId, customerId, laundromatId;
  final GenerateReceiptViewModel controller =
      Get.put(GenerateReceiptViewModel());

  OrderReceiptScreen(
      {required this.orderId,
      required this.customerId,
      required this.laundromatId});

  @override
  Widget build(BuildContext context) {
    controller.fetchReceipt(orderId, customerId, laundromatId);

    return Scaffold(
      appBar: myCustomAppbar("Order Receipt"),
      // AppBar(
      //   title: Text("Order Receipt", style: TextStyle(color: Colors.white)),
      //   backgroundColor: AppColor.primeryBlueColor,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     // onPressed: () => Get.back(),
      //     onPressed: () => Get.offAll(HomeView()),
      //   ),
      // ),
      backgroundColor: Colors.grey[200],
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : controller.receiptData.value == null
              ? Center(child: Text("No receipt found"))
              : buildReceiptBody(controller.receiptData.value!)),
    );
  }

  Widget buildReceiptBody(GenerateReceiptModel receipt) {
    var order = receipt.orderDetails;
    var customer = receipt.customerDetails;
    var laundromat = receipt.laundromatDetails;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCard([
            buildRow("Order QID", order?.orderQId ?? 'N/A'),
            buildRow("Order Date", order?.orderDate ?? 'N/A'),
            buildRow("Order Time", order?.orderTime ?? 'N/A'),
            buildRow("Order Type", order?.orderType ?? 'N/A'),
            buildStatusRow("Order Status", order?.orderStatus ?? 'N/A'),
          ]),
          SizedBox(height: 15),
          buildCard([
            buildRow("Customer Name", customer?.name ?? 'N/A'),
            buildRow("Mobile", customer?.mobile ?? 'N/A'),
            buildRow("Address", order?.orderAddress ?? 'N/A'),
          ]),
          SizedBox(height: 15),
          buildCard([
            buildRow("Laundromat Name", laundromat?.name ?? 'N/A'),
            buildRow("Delivery Type", order?.deliveryType ?? 'N/A'),
            buildRow("Delivery Method", order?.deliveryMethod ?? 'N/A'),
          ]),
          SizedBox(height: 15),
          buildCard([
            buildRow("Payment Method", order?.payment ?? 'N/A'),
            buildRow("Order Price", "\$${order?.orderPrice ?? 'N/A'}"),
            buildStatusRow("Payment Status", order?.paymentStatus ?? 'N/A'),
          ]),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar("Download", "Receipt downloaded successfully!",
                      backgroundColor: Colors.green, colorText: Colors.white);
                },
                icon: Icon(Icons.download, color: Colors.white),
                label: Text("Download Receipt",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primeryBlueColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildStatusRow(String title, String status) {
    Color statusColor =
        status.toLowerCase() == "pending" ? Colors.orange : Colors.green;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: statusColor.withAlpha(60),
                borderRadius: BorderRadius.circular(8)),
            child: Text(status,
                style: TextStyle(
                    fontSize: 14,
                    color: statusColor,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
