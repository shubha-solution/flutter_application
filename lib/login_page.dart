import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/FontSize.dart';
import 'package:flutter_application/color.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/dash_board.dart';
import 'package:flutter_application/font_family.dart';
import 'package:flutter_application/forgetpassword_screen.dart';
import 'package:flutter_application/getxController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mobilelogin extends StatefulWidget {
  const Mobilelogin({super.key});

  @override
  State<Mobilelogin> createState() => _MobileloginState();
}

class _MobileloginState extends State<Mobilelogin> {
  TextEditingController signupfirstname = TextEditingController();
  TextEditingController signuplastname = TextEditingController();
  TextEditingController signupemail = TextEditingController();
  TextEditingController signupphno = TextEditingController();
  TextEditingController signupwaphno = TextEditingController();

  TextEditingController phoneNumberCountryId = TextEditingController();
  TextEditingController whatsAppNumberCountryId = TextEditingController();

  TextEditingController signuppassword = TextEditingController();
  String signupcourse = "JEE";
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController loginotp = TextEditingController();
  TextEditingController activationkey = TextEditingController();

  int selectedCountryCodePhone = 1;
  int selectedCountryCodeWA = 1;

  int controllerIndex = 0;

  RxList<Map<String, dynamic>> countryCode = <Map<String, dynamic>>[
    {"value": 1, "label": "91 - India"},
    {"value": 2, "label": "93 - Afghanistan"},
  ].obs;

  // ignore: non_constant_identifier_names 
  // final GlobalKey<FormState> desktop_key = GlobalKey();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();

  List<String> courseList = ["JEE", "NEET", "CA"];

  RxBool showPass = false.obs;

  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> mobile_key_login = GlobalKey();
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> mobile_key_signup = GlobalKey();
  late double fontsize = ClsFontsize.ExtraLarge + 2;
  Getx getxController = Get.put(Getx());
  InputBorder border = const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPage.colorgrey));
  var key = '0';
  Getx getx = Get.put(Getx());

  @override
  void initState() {
    getUserid();
    Future.microtask(() {
      if (getx.loginId.isEmpty) {
        getx.isSignup.value = true;
        getx.ButtonControllerIndex.value = 0; // Set the button index to 1
        getx.show.value = true;
      }

      // Ensure to set the controller index after state change
      setState(() {
        _animatedButtonController.setIndex(getx.ButtonControllerIndex.value);
      });
    });
    super.initState();
  }

  getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    loginemail.text = prefs.getString("LoginId") ?? '';
  }

  // Future getCountrycodeListFunction() async {
  //   countryCode.value = await getCountryId();
  // }

  final _animatedButtonController = AnimatedButtonController();

  @override
  void dispose() {
    getx.ButtonControllerIndex.value = 0;
    super.dispose();
  }

  double height = 4;
  @override
  Widget build(BuildContext context) { 
  late double formfieldsize = MediaQuery.of(context).size.width - 60;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg_android_login.png'),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
          
            padding: EdgeInsets.symmetric(vertical: 10),
          
            alignment: Alignment.center,
            child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         alignment: Alignment.topLeft,
                         child: Image(
                           image: AssetImage(
                             logopath,
                           ),
                           height: 80,
                           width: 120,
                         ),
                       ),
                     ],
                   ),
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: formfieldsize,
                              child: Text(
                                origin ==
                                        "com.dthlms.pro" //dont change it by sayak mishra
                                    ? 'User name'
                                    : 'Username/Email/Phone',
                                style: FontFamily.mobilefont,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: formfieldsize,
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Cannot be blank';
                                    }
                                    return null;
                                  },
                                  controller: loginemail,
                                  keyboardType:
                                      TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: origin ==
                                            "com.dthlms.pro" //dont change it by sayak mishra
                                        ? 'Enter Your User name'
                                        : 'Enter Your Username or Email or Phone',
                                    fillColor: Color.fromARGB(
                                        255, 247, 246, 246),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: Color.fromARGB(
                                            255, 196, 194, 194),
                                      ),
                                      gapPadding: 20,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: Color.fromARGB(
                                            255, 196, 194, 194),
                                      ),
                                      gapPadding: 20,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                  ),
                                  // controller: ,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: formfieldsize,
                              child: Text(
                                'Password',
                                style: FontFamily.mobilefont,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: formfieldsize,
                                child: Obx(
                                  () => TextFormField(
                                    obscureText:
                                        getx.loginpasswordshow.value,
                                    autovalidateMode: AutovalidateMode
                                        .onUserInteraction,
                                    textInputAction:
                                        TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Cannot be blank';
                                      }
                                      return null;
                                    },
                                    controller: loginpassword,
                                    keyboardType:
                                        TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        hintText: '************',
                                        fillColor: Color.fromARGB(
                                            255, 247, 246, 246),
                                        filled: true,
                                        focusedBorder:
                                            OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: Color.fromARGB(
                                                255, 196, 194, 194),
                                          ),
                                          gapPadding: 20,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                        ),
                                        enabledBorder:
                                            OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: Color.fromARGB(
                                                255, 196, 194, 194),
                                          ),
                                          gapPadding: 20,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                        ),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              getx.loginpasswordshow
                                                      .value =
                                                  !getx
                                                      .loginpasswordshow
                                                      .value;
                                            },
                                            icon: getx
                                                    .loginpasswordshow
                                                    .value
                                                ? const Icon(
                                                    Icons.visibility)
                                                : const Icon(Icons
                                                    .visibility_off))),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: height,
                        ),
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       alignment: Alignment.topRight,
                        //       width: formfieldsize,
                        //       child: TextButton(
                        //         onPressed: () {
                        //           Get.to(
                        //               () => ForgotScreenMobile());
                        //           // Get.to(() =>
                        //           //     const ForgetPasswordMobile());
                        //         },
                        //         child: Text(
                        //           'Forget password',
                        //           style: FontFamily.mobilefont,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       width: formfieldsize,
                        //       child: Text(
                        //         'OTP',
                        //         style:
                        //             FontFamily.mobilefont,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //         width: formfieldsize,
                        //         child: TextFormField(
                        //           autovalidateMode:
                        //               AutovalidateMode
                        //                   .onUserInteraction,
                        //           validator: (value) {
                        //             if (value!.isEmpty) {
                        //               return 'Cannot be blank';
                        //             }
                        //             return null;
                        //           },
                        //           controller: loginotp,
                        //           keyboardType:
                        //               const TextInputType
                        //                   .numberWithOptions(),
                        //           decoration: InputDecoration(
                        //               enabledBorder: border,
                        //               focusedBorder: border,
                        //               suffixIcon: IconButton(
                        //                   onPressed: () {},
                        //                   icon: const Icon(Icons
                        //                       .visibility)),
                        //               hintText:
                        //                   '*'),
                        //         ))
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: formfieldsize,
                                  child: MaterialButton(
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                    padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10),
                                    color: ColorPage.color1,
                                    onPressed: () async {
                                     // Navigator.push(context, MaterialPageRoute(builder: (context) => ,))
                                      // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGaXJzdE5hbWUiOiJTb3VyYXYiLCJMYXN0TmFtZSI6Ik5hdGgiLCJuYW1laWQiOiI2NTg0YWUzNC00NjMwLTRhNjMtYjI3MC1kNjUwNjdmNTNmZDIiLCJGcmFuY2hpc2VJZCI6IjEiLCJNb2JpbGUiOiI5ODMxODExOTIzIiwiZW1haWwiOiJpc3NzYnN0MjAxNkBnbWFpbC5jb20iLCJyb2xlIjoiVGVzdGVyIiwibmJmIjoxNzIxNzI2NjA3LCJleHAiOjE3MjE3MzAyMDcsImlhdCI6MTcyMTcyNjYwN30.Z3ALSqb6bZwjkOcx2uSFpPjS3Ktqhp8dkolsUrekH1o";
                                      //  await tableEncryptionHistory(context,token);
                                  
                                     //  if (mobile_key_login
                                     //      .currentState!
                                     //      .validate()) {
                                     //    mobile_key_login.currentState!
                                     //        .save();
                                  
                                        // await loginApi(
                                        //     context,
                                        //     loginemail.text,
                                        //     loginpassword.text,
                                        //     loginotp.text);
                                     //  }
                                      // await loginApi(
                                      //                   context,
                                      //                   'wotepog836@rowplant.com',
                                      //                   'Shubha@2003',
                                      //                   '1234'
                                      //                   );
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard(),));
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: fontsize,
                                          color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                                  
                        SizedBox(
                          height: height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                                  
                        // Forget Password Text
                        GestureDetector(
                          onTap: () {
                           //  Get.to(
                           //      transition: Transition.cupertino,
                           //      () => ForgotScreenMobile()); 
                           Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreenMobile(),));
                          },
                          child: const Text.rich(
                            TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                // style: TextStyle(color: Colors.blu),
                                text: 'Recover your password ? ',
                                children: [
                                  TextSpan(
                                      text: 'FORGET PASSWORD',
                                      style: TextStyle(
                                          decoration: TextDecoration
                                              .underline,
                                          color: Color.fromARGB(
                                              255, 44, 27, 197),
                                          fontWeight:
                                              FontWeight.w400))
                                ]),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                 ],
               ),
          ),
        ),
      ),
    );
  }
}
