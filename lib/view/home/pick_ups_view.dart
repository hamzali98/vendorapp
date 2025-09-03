import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/view/drawer/oder_detail_screen.dart';
import 'package:vendor_app/view/home/pikup_deliver_view.dart';
// import 'package:vendor_app/view/orderDetailsScreen/ordersDetailsScrenn.dart';
import 'package:vendor_app/view_models/controller/user_preference/user_preference_view_model.dart';
import '../../data/response/status.dart';
import '../../res/colors/app_color.dart';
import '../../view_models/controller/home/Tabs/pick_up_controller.dart';
import '../../view_models/controller/pickup/pick_up_view_model.dart';

class PickUpTab extends StatefulWidget {
  @override
  State<PickUpTab> createState() => _PickUpTabState();
}

class _PickUpTabState extends State<PickUpTab> {
  final PickUpController controller =
      Get.put(PickUpController(), permanent: true);
  UserPreference userPreference = UserPreference();

  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    print("PickUpTab initialized. Calling API...");
    controller.pickupListApi(); // Call API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.bgcolor,
        padding: const EdgeInsets.symmetric(
            horizontal: 5.0), // General screen padding
        child: Obx(() {
          if (controller.rxRequestStatus.value == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle empty state properly
          if (controller.orders.isEmpty) {
            return const Center(child: Text("No Pickup Orders Available"));
          }

          //Filter only "Pickup" type orders
          final pickupOrders = controller.orders
              // .where((order) => order.orderType?.toLowerCase() == "pickup")
              .toList();

          if (pickupOrders.isEmpty) {
            return const Center(child: Text("No Pickup Orders Available"));
          }

          return ListView.builder(
            itemCount: pickupOrders.length,
            itemBuilder: (context, index) {
              final order = pickupOrders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0), // Add vertical padding
                child: InkWell(
                  onTap: () {
                    // Get.to(OrderDetailsScreen(orderCode: "5715"));
                    // Get.to(OrderDetailsScreen(orderData: order.toJson()));
                  },
                  child: OrderCard(
                    name: "${order.customer?.name}", // Show order ID as Name
                    address:
                        "${order.customer?.email}", // Show Customer ID as Address
                    time: order.orderTime ?? "N/A",
                    type: order.orderType ?? "Unknown",
                    driver: order.driverName,
                    statusColor: order.orderStatus == "Completed"
                        ? Colors.green
                        : order.orderStatus == "in progress"
                            ? Colors.yellow
                            : Colors.red,
                    statusText: order.orderStatus ?? "Pending",
                    bags: order.totalBags ?? "0",
                    weight: order.weight ?? "0 kg",
                    price: order.orderPrice ?? "0.0",
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

// class OrderCard extends StatelessWidget {
//   final String name;
//   final String address;
//   final String time;
//   final String type;
//   final String? driver;
//   final String statusText;
//   final Color statusColor;

//   const OrderCard({
//     required this.name,
//     required this.address,
//     required this.time,
//     required this.type,
//     this.driver,
//     required this.statusText,
//     required this.statusColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16), // More rounded corners
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1), // Stronger shadow
//             spreadRadius: 3,
//             blurRadius: 8,
//             offset: const Offset(0, 4), // More elevation effect
//           ),
//         ],
//       ),
//       // margin: const EdgeInsets.symmetric(
//       //     vertical: 14, horizontal: 6), // More vertical spacing
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Order Type and Time Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.local_shipping,
//                       color: AppColor.primeryBlueColor, size: 22),
//                   const SizedBox(width: 6),
//                   Text(
//                     type, // Order Type
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: AppColor.primeryBlueColor,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.access_time,
//                       color: Colors.grey.shade600, size: 20),
//                   const SizedBox(width: 4),
//                   Text(
//                     time,
//                     style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const Divider(
//               thickness: 1.2,
//               height: 18,
//               color: Colors.grey), // Thicker Divider

//           /// Customer Name
//           Text(
//             name,
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w700,
//               color: AppColor.BlackColor,
//             ),
//           ),
//           const SizedBox(height: 8),

//           /// Address
//           Row(
//             children: [
//               Icon(Icons.location_on, color: Colors.redAccent, size: 22),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Text(
//                   address,
//                   style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),

//           /// Status and Order Type
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               /// Status (Completed / Pending)
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//                 decoration: BoxDecoration(
//                   color: statusColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   statusText,
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: statusColor),
//                 ),
//               ),

//               /// Order Type Below Status (Right Side)
//               // Padding(
//               //   padding: const EdgeInsets.only(top: 4.0),
//               //   child: Text(
//               //     type, // Order Type (e.g., "Pickup")
//               //     style: TextStyle(
//               //       color: AppColor.primeryBlueColor,
//               //       fontWeight: FontWeight.bold,
//               //       fontSize: 14,
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),

//           /// Driver (if available)
//           if (driver != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.person, color: Colors.blueAccent, size: 22),
//                   const SizedBox(width: 6),
//                   Text(
//                     "Driver: $driver",
//                     style: TextStyle(fontSize: 15, color: Colors.blue.shade700),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vendor_app/view_models/controller/user_preference/user_preference_view_model.dart';
//
// import '../../res/colors/app_color.dart';
// import '../../view_models/controller/home/Tabs/pick_up_controller.dart';
// import '../../view_models/controller/pickup/pick_up_view_model.dart';
//
//
// class PickUpTab extends StatelessWidget {
//   final PickupController controller = Get.put(PickupController());
//   //final PickUpController controller = Get.put(PickUpController());
//
//   //UserPreference userPreference = UserPreference();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0), // General screen padding
//         child: Obx(() {
//           // Show a loader while orders are being fetched
//           if (controller.orders.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           // Filter only orders with type as "Pickup"
//           final pickupOrders = controller.orders
//               .where((order) => order['type'] == "Pickup") // Filter for Pickup orders
//               .toList();
//
//           if (pickupOrders.isEmpty) {
//             return const Center(child: Text("No Pickup Orders Available")); // Empty state
//           }
//
//           return ListView.builder(
//             itemCount: pickupOrders.length,
//             itemBuilder: (context, index) {
//               final order = pickupOrders[index];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
//                 child: OrderCard(
//                   name: order['name'],
//                   address: order['address'],
//                   time: order['time'],
//                   type: order['type'],
//                   driver: order['driver'],
//                   statusColor: order['statusColor'],
//                   statusText: order['statusText'],
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
// }
//
// class OrderCard extends StatelessWidget {
//   final String name;
//   final String address;
//   final String time;
//   final String type;
//   final String? driver;
//   final Color statusColor;
//   final String statusText;
//
//   const OrderCard({
//     required this.name,
//     required this.address,
//     required this.time,
//     required this.type,
//     this.driver,
//     required this.statusColor,
//     required this.statusText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//         borderRadius: BorderRadius.circular(8),
//         color: AppColor.WhiteColor,
//       ),
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Name
//           Text(
//             name,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: AppColor.BlackColor,
//             ),
//           ),
//
//           /// Address
//           Text(
//             address,
//             style: TextStyle(fontSize: 14, color: AppColor.BlackColor),
//           ),
//
//           const SizedBox(height: 8),
//
//           /// Time & Status Aligned Properly
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               /// Time on the left
//               Text(
//                 time,
//                 style: TextStyle(fontSize: 14, color: AppColor.BlackColor),
//               ),
//
//               /// Status Text Aligned to Right
//               Text(
//                 statusText,
//                 style: TextStyle(
//                   color: statusColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//
//           /// Order Type Below Status (Right Side)
//           Align(
//             alignment: Alignment.centerRight, // Align to the right side
//             child: Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text(
//                 type, // Order Type (e.g., "Pickup")
//                 style: TextStyle(
//                   color: AppColor.primeryBlueColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//
//           /// Driver (if available)
//           if (driver != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 "Driver: $driver",
//                 style: const TextStyle(fontSize: 14, color: Colors.blue),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
