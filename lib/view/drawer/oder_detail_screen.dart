import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/view/drawer/update_tillId_order_view.dart';
import '../../../res/colors/app_color.dart';
import '../../data/response/status.dart';
import '../../view_models/controller/scan_confirm/confirm_oder_by_tillId_view_model.dart';
// Import the new screen

class OrderDetailsScreen extends StatelessWidget {
  final String orderCode; // ✅ Receive order code

  OrderDetailsScreen({required this.orderCode});

  final ConfirmOrderByIdController orderController =
      Get.put(ConfirmOrderByIdController());

  @override
  Widget build(BuildContext context) {
    // ✅ Fetch order details from API
    orderController.confirmOrder(orderCode);

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primeryBlueColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (orderController.rxRequestStatus.value == Status.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (orderController.rxRequestStatus.value == Status.ERROR) {
          return Center(
              child: Text("Order Not Found!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
        } else {
          var order = orderController.orderDetails;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 **Order Details**
                      buildCard([
                        buildRow("Receipt No", "${order?.orderId ?? 'N/A'}"),
                        buildRow("Order Type", order?.orderType ?? 'N/A'),
                        buildRow("Order Status", order?.orderStatus ?? 'N/A'),
                        buildRow(
                            "Order Price", "${order?.orderPrice ?? 'N/A'}"),
                      ]),
                      SizedBox(height: 15),

                      /// 🔹 **Customer Details**
                      buildCard([
                        buildRow(
                            "Customer Name", order?.customer?.name ?? 'N/A'),
                        buildRow("Mobile", order?.customer?.mobile ?? 'N/A'),
                        buildRow("Address",
                            order?.customerAddress?.address ?? 'N/A'),
                        buildRow(
                            "Delivery Instructions",
                            order?.customerAddress?.deliveryInstruction ??
                                'N/A'),
                      ]),
                      SizedBox(height: 15),

                      /// 🔹 **Laundromat Details**
                      buildCard([
                        buildRow("Laundromat Name",
                            order?.laundromatDetails?.name ?? 'N/A'),
                        buildRow(
                            "City", order?.laundromatDetails?.city ?? 'N/A'),
                        buildRow(
                            "State", order?.laundromatDetails?.state ?? 'N/A'),
                      ]),
                      SizedBox(height: 15),

                      /// 🔹 **Order Summary**
                      buildCard([
                        buildRow("Total Bags", order?.totalBags ?? 'N/A'),
                        buildRow("Weight", "${order?.weight} lb" ?? 'N/A'),
                      ]),
                      SizedBox(height: 20),

                      /// 🔹 **Products**
                      Text("Products",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Column(
                        children: order?.products?.map((product) {
                              return buildCard([
                                buildRow(
                                    "Product", product.productName ?? 'N/A'),
                                buildRow("Variation",
                                    product.variationName ?? 'N/A'),
                                if (product.quantity != null &&
                                    product.quantity! > 0)
                                  buildRow("Quantity", "${product.quantity}"),
                                // if (product.weight != null && product.weight! > 0)
                                //   buildRow("Weight", "${product.weight} lb"),
                                buildRow("Price", "${product.price ?? 'N/A'}"),
                              ]);
                            }).toList() ??
                            [],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              /// 🔹 **Update Order Button**
              Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => UpdateOrderScreen(orderDetails: order!));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primeryBlueColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Update Order",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  /// **Reusable Card Widget**
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

  /// **Row for Displaying Order Details**
  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130, // Adjust width as needed for your titles
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              softWrap: true,
              maxLines: null,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
