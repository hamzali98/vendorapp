import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_app/repository/signup_repository/signup_repository.dart';
import 'package:vendor_app/view/addLaundry/addLaundry.dart';
import 'package:vendor_app/view_models/controller/add_laundry/addLaundry_view_model.dart';
import 'package:vendor_app/view_models/controller/login/login_view_model.dart';
import '../../../models/login/user_model.dart';
import '../../../repository/login_repository/login_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_preference_view_model.dart';
import 'package:vendor_app/view/addLaundry/addLaundry.dart';

class SignupViewModel extends GetxController {
  final _api = SignupRepository();
  // final _api1 = LoginRepository();
  // UserPreference userPreference = UserPreference();
  final AddlaundryViewModel addlaundryviewmodel =
      Get.put(AddlaundryViewModel());

  RxBool loading = false.obs;
  void signupApi(Map<String, Object> signupData) async {
    loading.value = true;
    // Send the request to the API

    _api.signupApi(signupData).then((value) async {
      try {
        loading.value = false;
        if (value['Result'].toString().toLowerCase() == 'true' &&
            value['ResponseCode'].toString().toLowerCase() == '200') {
          final id = value['LaundryUserID'].toString();
          final userdata = signupData;
          addlaundryviewmodel.fetchzonesApi();
          Get.to(() => AddLaundryPage(signupdata: userdata, laundryUserId: id));
          // _api1
          //     .loginApi(
          //   signupData['mobile'].toString(),
          //   signupData['password'].toString(),
          //   signupData['ccode'].toString(),
          // )
          //     .then((value) async {
          //   // Send the request to the API
          //   try {
          //     loading.value = false;
          //     if (value['Result'].toString().toLowerCase() == 'true') {
          //       UserModel userModel = UserModel.fromJson(value);
          //       userPreference.saveUser(userModel).then((_) {
          //         Get.to(() => AddLaundryPage());
          //       });
          //       Utils.snackBar('signup', 'User created now add laundry',
          //           Colors.green, SnackPosition.BOTTOM);
          //       print("DEBUG: $value");
          //     } else {
          //       Utils.snackBar(
          //           'Error',
          //           value['ResponseMsg'] ?? "signup failed!",
          //           Colors.red,
          //           SnackPosition.BOTTOM);
          //     }
          //   } catch (e) {
          //     print("ERROR: An error occurred while fetching data: $e");
          //   }
          // }).onError((error, stackTrace) {
          //   loading.value = false;
          //   Utils.snackBar(
          //       'Error', error.toString(), Colors.red, SnackPosition.BOTTOM);
          // });
          // Get.delete<SignupViewModel>();
          // Get.toNamed(RouteName.loginView);

          Utils.snackBar('signup', 'signup Successful!', Colors.green,
              SnackPosition.BOTTOM);
          print("DEBUG: $value");
        } else {
          Utils.snackBar('Error', value['ResponseMsg'] ?? "signup failed!",
              Colors.red, SnackPosition.BOTTOM);
        }
      } catch (e) {
        print("ERROR: An error occurred while fetching data: $e");
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar(
          'Error', error.toString(), Colors.red, SnackPosition.BOTTOM);
    });
  }
}
