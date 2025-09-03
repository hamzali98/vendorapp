import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:vendor_app/view/orderDetailsScreen/ordersDetailsScrenn.dart';
import 'package:vendor_app/view_models/controller/pickup_delivery/pickup_delivery_view_model.dart';
import 'package:vendor_app/view_models/controller/user_preference/user_preference_view_model.dart';
import '../../data/response/status.dart';
import '../../res/colors/app_color.dart';
import '../../view_models/controller/pickup/pick_up_view_model.dart';

class PickUpDeliver extends StatefulWidget {
  @override
  State<PickUpDeliver> createState() => _PickUpDeliverState();
}

class _PickUpDeliverState extends State<PickUpDeliver> {
  //final PickUpController controller = Get.put(PickUpController());
  final PickpDeliveryController controller =
      Get.put(PickpDeliveryController(), permanent: true);
  UserPreference userPreference = UserPreference();

  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller
          .pickupListApi(); // ✅ Ensures API call happens after the build phase
    }); // Call API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        color: AppColor.bgcolor,
        child: Obx(() {
          if (controller.rxRequestStatus.value == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle empty state properly
          if (controller.orders.isEmpty) {
            return const Center(
                child: Text("No Pickup & Deliver Orders Available"));
          }

          //Filter only "Pickup" type orders
          final pickupOrders = controller.orders
              // .where((order) =>
              //     order.orderType?.toLowerCase() == "pickup & delivery")
              .toList();

          if (pickupOrders.isEmpty) {
            return const Center(
                child: Text("No Pickup & Deliver Orders Available"));
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
                    // Get.to(OrderDetailsScreen(orderData: order.toJson()));
                  },
                  child: OrderCard(
                    name: "${order.customer?.name}", // Show order ID as Name
                    address:
                        "${order.customer?.email}", // Show Customer ID as Address
                    time: order.orderTime ?? "N/A",
                    type: order.orderType ?? "Unknown",
                    driver: order.driverName,
                    statusColor: order.orderStatus == "completed"
                        ? Colors.green
                        : Colors.red,
                    statusText: order.orderStatus ?? "Pending",
                    price: order.orderPrice?.toString() ?? "0",
                    bags: order.totalBags?.toString() ?? "0",
                    weight: order.weight?.toString() ?? "0",
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

class OrderCard extends StatelessWidget {
  final String name;
  final String address;
  final String time;
  final String type;
  final String? driver;
  final String statusText;
  final Color statusColor;
  final String price;
  final String bags;
  final String weight;

  const OrderCard({
    required this.name,
    required this.address,
    required this.time,
    required this.type,
    this.driver,
    required this.statusText,
    required this.statusColor,
    required this.price,
    required this.bags,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // More rounded corners
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Stronger shadow
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 4), // More elevation effect
          ),
        ],
      ),
      // margin: const EdgeInsets.symmetric(
      //     vertical: 14, horizontal: 6), // More vertical spacing
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Order Type and Time Row
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 400;
              final mainContent = [
                Row(
                  children: [
                    Icon(Icons.local_shipping,
                        color: AppColor.primeryBlueColor, size: 22),
                    const SizedBox(width: 6),
                    Text(
                      type, // Order Type
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primeryBlueColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: Colors.grey.shade600, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ];
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainContent[0],
                    const SizedBox(height: 6),
                    mainContent[1],
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: mainContent,
                );
              }
            },
          ),
          const Divider(
            thickness: 1.2,
            height: 18,
            color: Colors.grey,
          ), // Thicker Divider

          // /// Customer Name
          // Text(
          //   name,
          //   style: TextStyle(
          //     fontSize: 17,
          //     fontWeight: FontWeight.w700,
          //     color: AppColor.BlackColor,
          //   ),
          // ),
          const SizedBox(height: 8),

          /// Status and Order Type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(Icons.person, color: Colors.blue, size: 22),
              /// Customer Name
              Text(
                name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColor.BlackColor,
                ),
              ),

              /// Status (Completed / Pending)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor),
                ),
              ),

              /// Order Type Below Status (Right Side)
              // Padding(
              //   padding: const EdgeInsets.only(top: 4.0),
              //   child: Text(
              //     type, // Order Type (e.g., "Pickup")
              //     style: TextStyle(
              //       color: AppColor.primeryBlueColor,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 8),

          /// Address
          Row(
            children: [
              Icon(Icons.email, color: Colors.green, size: 22),

              // Icon(Icons.location_on, color: Colors.redAccent, size: 22),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.shopping_bag,
                  color: AppColor.primeryBlueColor, size: 22),

              // Icon(Icons.location_on, color: Colors.redAccent, size: 22),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  bags,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.scale, color: AppColor.primeryBlueColor, size: 22),

              // Icon(Icons.location_on, color: Colors.redAccent, size: 22),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  weight,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.attach_money,
                  color: AppColor.primeryBlueColor, size: 22),

              // Icon(Icons.location_on, color: Colors.redAccent, size: 22),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  price,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Driver (if available)
          if (driver != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.blueAccent, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    "Driver: $driver",
                    style: TextStyle(fontSize: 15, color: Colors.blue.shade700),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vendor_app/view/home/receive_delivery_view.dart';
//
//
// import '../../res/colors/app_color.dart';
// import '../../view_models/controller/home/Tabs/dropoff_controller.dart';
//
//
// class PickUpDeliver extends StatelessWidget {
//   final DropOffController controller = Get.put(DropOffController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             Expanded(
//               child: Obx(() {
//                 if (controller.orders.isEmpty) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return Row(
//                   children: [
//                     Expanded(
//                       child: OrderColumn(
//                         orders: controller.orders
//                             .where((order) => order['isCompleted'] == true)
//                             .toList(),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: OrderColumn(
//                         orders: controller.orders
//                             .where((order) => order['isCompleted'] == false)
//                             .toList(),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OrderColumn extends StatelessWidget {
//   final List<Map<String, dynamic>> orders;
//
//   const OrderColumn({required this.orders});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: orders.length,
//       itemBuilder: (context, index) {
//         final order = orders[index];
//         return OrderCard(
//           name: order['name'],
//           address: order['address'],
//           time: order['time'],
//           type: order['type'],
//           driver: order['driver'],
//           receipt: order['receipt'],
//           statusColor: order['statusColor'],
//           statusText: order['statusText'],
//           isCompleted: order['isCompleted'],
//         );
//       },
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
//   final String? receipt;
//   final Color statusColor;
//   final String statusText;
//   final bool isCompleted;
//
//   const OrderCard({
//     required this.name,
//     required this.address,
//     required this.time,
//     required this.type,
//     this.driver,
//     this.receipt,
//     required this.statusColor,
//     required this.statusText,
//     this.isCompleted = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.white,
//       ),
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             name,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blue.shade900,
//             ),
//           ),
//           Text(
//             address,
//             style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
//           ),
//           const SizedBox(height: 4),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(time, style: TextStyle(fontSize: 14, color: Colors.blue.shade700)),
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
//           if (driver != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text("Driver: $driver", style: TextStyle(fontSize: 14, color: Colors.blue.shade700)),
//             ),
//           if (receipt != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text("Receipt No: $receipt", style: TextStyle(fontSize: 14, color: Colors.blue.shade700)),
//             ),
//           if (!isCompleted)
//             Align(
//               alignment: Alignment.bottomRight,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReceiveDelivery()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ),
//                 child: Text(
//                   "Add New",
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColor.WhiteColor),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//PickUpDeliver