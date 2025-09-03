import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vendor_app/res/colors/app_color.dart';
import 'package:vendor_app/utils/Colors.dart';
import 'package:vendor_app/utils/Fontfamily.dart';
import 'package:vendor_app/view/addLaundry/addLaundry.dart';
import 'package:vendor_app/view/login/login_view.dart';
import 'package:vendor_app/view/login/widgets/login_appbar_widget.dart';
import 'package:vendor_app/view/signUp/widgets/signupWidgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vendor_app/view_models/controller/add_laundry/addLaundry_view_model.dart';
import 'package:vendor_app/view_models/controller/signup/signup_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupViewModel signupViewModel = Get.put(SignupViewModel());
  final AddlaundryViewModel addlaundryviewmodel =
      Get.put(AddlaundryViewModel());

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ccodeController = TextEditingController(text: '+92');
  final _mobileController = TextEditingController();
  final _parentCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ccodeController.dispose();
    _mobileController.dispose();
    _parentCodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      // Here you can use the model data
      final signupData = {
        "name": _nameController.text,
        "email": _emailController.text,
        "ccode": _ccodeController.text,
        "mobile": _mobileController.text,
        "parentcode": _parentCodeController.text,
        "password": _passwordController.text,
        "status": 1,
      };
      // TODO: Handle signup logic
      print(signupData);
      signupViewModel.signupApi(signupData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg1Color,
      appBar: CustomAppBarScreen(
        titleKey: 'Welcome',
        subtitleKey: 'sign_start',
      ),
      body: Obx(
        () => Stack(children: [
          AbsorbPointer(
            absorbing: signupViewModel.loading.value,
            child: Opacity(
              opacity: signupViewModel.loading.value
                  ? 0.5
                  : 1.0, // Optional fade effect
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'Sign up'.tr,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Create your account to get started'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputNameWidget(controller: _nameController),
                              SizedBox(height: 20),
                              InputEmailWidget(controller: _emailController),
                              SizedBox(height: 20),
                              // IntlPhoneField(
                              //   initialCountryCode: "PK",
                              //   keyboardType: TextInputType.number,
                              //   cursorColor: BlackColor,
                              //   inputFormatters: [
                              //     FilteringTextInputFormatter.digitsOnly
                              //   ],
                              //   // controller: _mobileController,
                              //   autovalidateMode: AutovalidateMode.onUserInteraction,
                              //   disableLengthCheck: true,
                              //   dropdownIcon: Icon(
                              //     Icons.arrow_drop_down,
                              //     color: Colors.grey.shade600,
                              //   ),
                              //   dropdownTextStyle: TextStyle(
                              //     color: Colors.grey.shade600,
                              //   ),
                              //   style: TextStyle(
                              //     fontFamily: FontFamily.gilroyMedium,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w600,
                              //     color: BlackColor,
                              //   ),
                              //   onCountryChanged: (value) {
                              //     _mobileController.text = '';
                              //     _passwordController.text = '';
                              //   },
                              //   onChanged: (value) {
                              //     _ccodeController.text = value.countryCode;
                              //     _mobileController.text = value.number;
                              //   },

                              //   validator: (value) {
                              //     if (value == null || value.number.trim().isEmpty) {
                              //       return "Please enter your mobile number".tr;
                              //     }
                              //     if (value.number.length < 10 ||
                              //         value.number.length > 10) {
                              //       return "Mobile number is invalid".tr;
                              //     }
                              //     // Add more validation if needed
                              //     return null;
                              //   },
                              //   decoration: InputDecoration(
                              //     filled: true,
                              //     fillColor: Colors.white,
                              //     hintText: "Mobile Number".tr,
                              //     hintStyle: TextStyle(
                              //       color: Colors.grey.shade600,
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.grey.shade300,
                              //       ),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: Colors.grey.shade300,
                              //       ),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     border: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: Colors.grey.shade300,
                              //       ),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //   ),
                              //   invalidNumberMessage:
                              //       "Please enter your mobile number".tr,
                              // ),
                              InputPhoneWidget(
                                ccodeController: _ccodeController,
                                mobileController: _mobileController,
                              ),
                              SizedBox(height: 20),
                              InputParentCodeWidget(
                                  controller: _parentCodeController),
                              SizedBox(height: 20),
                              InputPasswordWidget(
                                  controller: _passwordController),
                            ],
                          ),
                        ),
                        // SizedBox(height: 20),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: _rememberMe,
                        //       onChanged: (bool? value) {
                        //         setState(() {
                        //           _rememberMe = value ?? false;
                        //         });
                        //       },
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           _rememberMe = !_rememberMe;
                        //         });
                        //       },
                        //       child: Text('remember_me'.tr),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 30),
                        SignupButtonWidget(
                          formKey: _formKey,
                          onPressed: _onSignup,
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => LoginView());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: AppColor.primeryBlueColor,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 30),
                        // TextButton(
                        //   onPressed: () {
                        //     addlaundryviewmodel.fetchzonesApi();
                        //     final signupData = {
                        //       "name": "John Doe",
                        //       "email": "johndoe@example.com",
                        //       "ccode": "+92",
                        //       "mobile": "1234567890",
                        //       "parentcode": "123",
                        //       "password": "1234",
                        //       "status": "1",
                        //     };
                        //     // signupViewModel.loading.value = true;
                        //     Get.to(() => AddLaundryPage(
                        //         signupdata: signupData, laundryUserId: '1'));
                        //   },
                        //   child: Text('Just Text Button'),
                        // ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Loading overlay
          if (signupViewModel.loading.value)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ]),
      ),
    );
  }
}
