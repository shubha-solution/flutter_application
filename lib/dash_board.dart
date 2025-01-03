import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/color.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/font_family.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        // flexibleSpace: ClipRect(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        //     child: Container(
        //       color: Colors.transparent,
        //     ),
        //   ),
        // ),
        iconTheme: IconThemeData(color: Colors.white),
        // backgroundColor: Colors.deepPurple.withAlpha(200),
        backgroundColor: ColorPage.appBarColor,

        title: Text(
          'Dash Board',
          style: GoogleFonts.josefinSans().copyWith(color: Colors.white),
        ),
        actions: [
          
            IconButton(
              icon: Image(
                image: AssetImage(
                  logopath,
                ),
                height: 60,
                width: 100,
              ),
              onPressed: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          
      
        ],
        leading: IconButton(onPressed: (){
                scaffoldKey.currentState!.openDrawer();
        }, icon: Icon(Icons.menu_rounded))
        
        
      ),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
    );
  }
} 





class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key,});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
   List<String> socialMediaIcons = [

    ];
  @override
  void initState() {
    appVersionGet();
    super.initState();
  }

  RxString version = "".obs;

  appVersionGet() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  logOut() async {
    ArtDialogResponse? response = await ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
        denyButtonText: "Cancel",
        title: "Are you sure?",
        text: "Are you sure you want to log out?",
        confirmButtonText: "Yes, log out",
        type: ArtSweetAlertType.question,
      ),
    );

    if (response == null) {
      return;
    }

    // onPressed: () async {

    //             },

    if (response.isTapConfirmButton) {
      // Navigator.pop(context);


      return;
    }
  }
final List<String> transactions = List.generate(10, (index) => "Transaction ${index + 1}");
final List<String> reports = List.generate(10, (index) => "Report ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPage.bgcolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: ColorPage.appBarColor,
                                    )),
                                    SizedBox(width: 20,)
                              ],
                            ),
         Expanded(
      child: ListView(
        controller: ScrollController(),
        padding: EdgeInsets.zero,
        children: [
          ExpansionTile(
      
            initiallyExpanded: true,
            shape: Border.all(color: Colors.transparent),
            title: Text(
              'Master',
              style: FontFamily.styleb.copyWith(fontSize: 24,color: Colors.blueGrey)
            ),
            children: [
              drawerItem(
                title: "Item",
                onTap: () {},
                leading: Icon(Icons.shopping_bag,color: Colors.indigo,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey),
              ),
              drawerItem(
                title: "Place",
                onTap: () {},
                leading: Icon(Icons.location_on,color: Colors.indigo,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey),
              ),
              drawerItem(
                title: "Person",
                onTap: () {},
                leading: Icon(Icons.person,color: Colors.indigo,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey),
              ),
            ],
          ),
          ExpansionTile(

            dense: true,
            shape: Border.all(color: Colors.transparent),

            title: Text(
              'Transactions',
                          style: FontFamily.styleb.copyWith(fontSize: 24,color: Colors.blueGrey)

            ),
            children: transactions.map((transaction) {
              return drawerItem(
                title: transaction,
                onTap: () {},
                leading: Icon(Icons.trending_neutral_sharp,color: Colors.green,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey),
              );
            }).toList(),
          ),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent),
 
            title: Text(
              'Report',
                          style: FontFamily.styleb.copyWith(fontSize: 24,color: Colors.blueGrey)

            ),
            children: reports.map((report) {
              return drawerItem(
                title: report,
                onTap: () {},
                leading: Icon(Icons.bar_chart,color: Colors.amber,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  
          
         
        ],
      ),
    );
  }

  // Future<void> _launchUrl(_url) async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  // _logoutConfirmetionBox(context) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: true,
  //     alertPadding: EdgeInsets.only(top: 200),
  //     descStyle: TextStyle(),
  //     animationDuration: Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //       side: BorderSide(color: Colors.grey),
  //     ),
  //     titleStyle: TextStyle(
  //         color: const Color.fromARGB(255, 243, 33, 33),
  //         fontWeight: FontWeight.bold),
  //     constraints: BoxConstraints.expand(width: 350),
  //     overlayColor: Color(0x55000000),
  //     alertElevation: 0,
  //     alertAlignment: Alignment.center,
  //   );
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     style: alertStyle,
  //     title: "Are you sure ?",
  //     desc:
  //         "Once you are logout your all data will be cleared and you should login again!",
  //     buttons: [
  //       DialogButton(
  //         width: 150,
  //         child: Text("Cancel",
  //             style: TextStyle(color: Colors.white, fontSize: 18)),
  //         highlightColor: Color.fromARGB(255, 203, 46, 46),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         color: Color.fromARGB(255, 139, 19, 19),
  //       ),
  //       DialogButton(
  //         width: 150,
  //         highlightColor: Color.fromARGB(255, 2, 2, 60),
  //         child:
  //             Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
  //         onPressed: () async {
  //           await logoutFunction(context, getx.loginuserdata[0].token);
  //           Navigator.pop(context);
  //           await logoutFunction(context, getx.loginuserdata[0].token);
  //           await clearSharedPreferencesExcept([
  //             'SelectedDownloadPathOfVieo',
  //             'SelectedDownloadPathOfFile',
  //             'DefaultDownloadpathOfFile',
  //             'DefaultDownloadpathOfVieo'
  //           ]);

  //           getx.loginuserdata.clear();

  //           Get.offAll(() => Mobilelogin());
  //         },
  //         color: const Color.fromARGB(255, 1, 12, 31),
  //       ),
  //     ],
  //   ).show();
  // }

  // Future<void> clearSharedPreferencesExcept(List<String> keysToKeep) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final allKeys = prefs.getKeys();

  //   for (String key in allKeys) {
  //     if (!keysToKeep.contains(key)) {
  //       await prefs.remove(key);
  //     }
  //   }
  // }
    Widget drawerHeader(
      {required String header,
      Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
Text(header,style: FontFamily.styleb.copyWith(color: Colors.blueGrey.shade300,
fontSize: 24
),)
      ],)
    );
  }

  Widget drawerItem(
      {required String title,
      required VoidCallback onTap,
      required Widget leading,
      Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(20),
        child: ListTile(
          dense: true,
          // minTileHeight: 20,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          onTap: onTap,
          leading: leading,
          trailing: trailing,
          title: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}



class RightDrawer extends StatefulWidget {
  const RightDrawer({super.key,});

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
   List<String> socialMediaIcons = [

    ];
  @override
  void initState() {
    appVersionGet();
socialMediaIcons = [
      'assets/Instagram_logo_2022.svg.png',
      'assets/facebook-logo-2019.png',
      'assets/3146788_youtube_logo_icon.png',


    ];
    super.initState();
  }

  RxString version = "".obs;

  appVersionGet() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  logOut() async {
    ArtDialogResponse? response = await ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
        denyButtonText: "Cancel",
        title: "Are you sure?",
        text: "Are you sure you want to log out?",
        confirmButtonText: "Yes, log out",
        type: ArtSweetAlertType.question,
      ),
    );

    if (response == null) {
      return;
    }

    // onPressed: () async {

    //             },

    if (response.isTapConfirmButton) {
      Navigator.pop(context);


      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPage.bgcolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(colors: ColorPage.gradientHeadingBox)
            //     ),
            decoration: BoxDecoration(color:  ColorPage.appBarColor,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                     Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                // getx.loginuserdata[0].firstName +
                                //     " " +
                                //     getx.loginuserdata[0].lastName,
                                'user Name',
                                style: FontFamily.style
                                    .copyWith(color: Colors.white)),
                            Expanded(
                              child: Text(
                                // getx.loginuserdata[0].email,
                                'abc@gmail.com',
                                  overflow: TextOverflow.ellipsis,
                                  style: FontFamily.style.copyWith(
                                      color: Colors.white54, fontSize: 20)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),

                      CircleAvatar(
                        radius: 33,
                        backgroundColor: ColorPage.white,
                        child: CircleAvatar(
                          radius: 30,
                          // backgroundImage: AssetImage('assets/sorojda.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: ScrollController(),
              padding: EdgeInsets.zero,
              children: [
                drawerItem(
                    title: "Profile",
                    onTap: () {
                      // Get.to(MyAccountScreen());
                    },
                    leading: Icon(
                      Icons.person_outline_rounded,
                      color: ColorPage.colorblack,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey,
                    )),
               
                
                
               
              ],
            ),
          ),
         
          Obx(
            () => Column(
              children: [
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(27),
                    child: ListTile(
                      onTap: logOut,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(27)),
                      tileColor: const Color.fromARGB(255, 255, 212, 199),
                      leading: Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: ColorPage.colorblack,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      dense: true,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Image(
                        image: AssetImage(logopath),
                        height: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "version ${version.value}",
                      style: FontFamily.styleb
                          .copyWith(color: Colors.grey[400], fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  // Future<void> _launchUrl(_url) async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  // _logoutConfirmetionBox(context) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: true,
  //     alertPadding: EdgeInsets.only(top: 200),
  //     descStyle: TextStyle(),
  //     animationDuration: Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //       side: BorderSide(color: Colors.grey),
  //     ),
  //     titleStyle: TextStyle(
  //         color: const Color.fromARGB(255, 243, 33, 33),
  //         fontWeight: FontWeight.bold),
  //     constraints: BoxConstraints.expand(width: 350),
  //     overlayColor: Color(0x55000000),
  //     alertElevation: 0,
  //     alertAlignment: Alignment.center,
  //   );
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     style: alertStyle,
  //     title: "Are you sure ?",
  //     desc:
  //         "Once you are logout your all data will be cleared and you should login again!",
  //     buttons: [
  //       DialogButton(
  //         width: 150,
  //         child: Text("Cancel",
  //             style: TextStyle(color: Colors.white, fontSize: 18)),
  //         highlightColor: Color.fromARGB(255, 203, 46, 46),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         color: Color.fromARGB(255, 139, 19, 19),
  //       ),
  //       DialogButton(
  //         width: 150,
  //         highlightColor: Color.fromARGB(255, 2, 2, 60),
  //         child:
  //             Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
  //         onPressed: () async {
  //           await logoutFunction(context, getx.loginuserdata[0].token);
  //           Navigator.pop(context);
  //           await logoutFunction(context, getx.loginuserdata[0].token);
  //           await clearSharedPreferencesExcept([
  //             'SelectedDownloadPathOfVieo',
  //             'SelectedDownloadPathOfFile',
  //             'DefaultDownloadpathOfFile',
  //             'DefaultDownloadpathOfVieo'
  //           ]);

  //           getx.loginuserdata.clear();

  //           Get.offAll(() => Mobilelogin());
  //         },
  //         color: const Color.fromARGB(255, 1, 12, 31),
  //       ),
  //     ],
  //   ).show();
  // }

  // Future<void> clearSharedPreferencesExcept(List<String> keysToKeep) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final allKeys = prefs.getKeys();

  //   for (String key in allKeys) {
  //     if (!keysToKeep.contains(key)) {
  //       await prefs.remove(key);
  //     }
  //   }
  // }

  Widget drawerItem(
      {required String title,
      required VoidCallback onTap,
      required Widget leading,
      Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(20),
        child: ListTile(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          onTap: onTap,
          leading: leading,
          trailing: trailing,
          title: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}