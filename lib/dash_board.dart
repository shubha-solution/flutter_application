import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/color.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/dashboard_controller.dart';
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
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic> itemsBeforeAdd = {};

  List<String> place = [];
  List<String> process = [];

  @override
  void initState() {
    for (int i = 1; i <= 5; i++) {
      items.add({
        'name': 'Item $i',
        'quantity': i * 10, // Assigning quantities as multiples of 10
      });
    }
    for (int i = 1; i <= 5; i++) {
      place.add('Place $i');
    }

    for (int i = 1; i <= 5; i++) {
      process.add('Process $i');
    }
    super.initState();
  }

  DashboardController controller = Get.put(DashboardController());

  //  List<String> place = List.generate(10, (index) => "Place ${index + 1}");
  //  List<String> process =
  //     List.generate(10, (index) => "Process ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: ColorPage.appBarColor,
          title: Obx(
            () => Text(
              controller.selectedMaster.value == ''
                  ? 'Dash Board'
                  : 'Item Master (${controller.selectedMaster.value})',
              style: GoogleFonts.josefinSans().copyWith(color: Colors.white),
            ),
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
          leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu_rounded))),
      floatingActionButton: Obx(
        () => controller.selectedMaster.value != ''
            ? FloatingActionButton(
                backgroundColor: ColorPage.appBarColor,
                onPressed: () {
                  _showInputDialog(context);
                },
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ))
            : SizedBox(),
      ),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: Obx(() => controller.selectedMaster.value == 'Item'
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Material(
                  child: ListTile(
                    tileColor: index % 2 == 0
                        ? Colors.brown.shade50
                        : Colors.orangeAccent.shade100,
                    visualDensity: VisualDensity(vertical: 0.01),
                    dense: true,
                    onTap: () {
                      _showEditDialog(context, index);
                    },
                    subtitle: Text(
                      "${items[index]['quantity'].toString()} Units",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    title: Text(items[index]['name']),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
                );
              },
            )
          : controller.selectedMaster.value == 'Place'
              ? ListView.builder(
                  itemCount: place.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: ListTile(
                        tileColor: index % 2 == 0
                        ? Colors.brown.shade50
                        : Colors.orangeAccent.shade100,
                        visualDensity: VisualDensity(vertical: 0.01),      
                        dense: true,
                        onTap: () {
                          _showEditDialog(context, index);
                        },
                        // subtitle: Text("${items[index]['quantity'].toString()} Units",style: TextStyle(color: Colors.orange),),
                        title: Text(place[index]),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ),
                    );
                  },
                )
              : controller.selectedMaster.value == 'Process'
                  ? ListView.builder(
                      itemCount: process.length,
                      itemBuilder: (context, index) {
                        return Material(
                          child: ListTile(
                            tileColor: index % 2 == 0
                                ? Colors.brown.shade50
                        : Colors.orangeAccent.shade100,
                            visualDensity: VisualDensity(vertical: 0.01),
                            dense: true,
                            onTap: () {
                              _showEditDialog(context, index);
                            },
                            // subtitle: Text("${items[index]['quantity'].toString()} Units",style: TextStyle(color: Colors.orange),),
                            title: Text(process[index]),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox()),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    DashboardController controller = Get.put(DashboardController());

    TextEditingController productNameController = TextEditingController(
        text: controller.selectedMaster.value == 'Item'
            ? items[index]['name']
            : controller.selectedMaster.value == 'Place'
                ? place[index]
                : controller.selectedMaster.value == 'Process'
                    ? process[index]
                    : null);
    TextEditingController quantityController = TextEditingController(
        text: controller.selectedMaster.value == 'Item'
            ? items[index]['quantity'].toString()
            : null);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(),
                ),
              ),
              controller.selectedMaster.value == 'Item'
                  ? Column(
                      children: [
                        SizedBox(height: 16),
                        TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Unit',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: FontFamily.styleb
                    .copyWith(color: Colors.deepOrange, fontSize: 15),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPage.appBarColor),
              onPressed: () {
                String updatedName = productNameController.text;
                String updatedQuantity = quantityController.text;
                if (controller.selectedMaster.value == 'Item') {
                  if (updatedName.isNotEmpty && updatedQuantity.isNotEmpty) {
                    setState(() {
                      items[index]['name'] = updatedName;
                      items[index]['quantity'] = updatedQuantity;
                    });

                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                  }
                } else {
                  if (updatedName.isNotEmpty) {
                    controller.selectedMaster.value == 'Place'
                        ? setState(() {
                            place[index] = updatedName;
                          })
                        : controller.selectedMaster.value == 'Process'
                            ? setState(() {
                                process[index] = updatedName;
                              })
                            : null;
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                  }
                }
              },
              child: Text(
                'Save',
                style: FontFamily.style
                    .copyWith(fontSize: 14, color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    // TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add ${controller.selectedMaster.value}'),
          titleTextStyle: FontFamily.style
              .copyWith(fontSize: 22, color: ColorPage.appBarColor),
          titlePadding: EdgeInsets.only(top: 20, left: 24),
          contentPadding:
              EdgeInsets.only(top: 5, left: 24, right: 24, bottom: 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Provide the item details to add a new item.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Item: ',
                    style: FontFamily.styleb.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        labelText: 'Item',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                itemsBeforeAdd.clear();

                Get.back();
              },
              child: Text(
                'Cancel',
                style: FontFamily.styleb
                    .copyWith(color: Colors.deepOrange, fontSize: 15),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPage.appBarColor),
              onPressed: () {
                String productName = productNameController.text;
                if (controller.selectedMaster.value == 'Item') {
                  if (productName.isNotEmpty) {
                    itemsBeforeAdd['name'] = productName;
                    productNameController.clear();
                    // quantityController.clear();
                    Get.back();

                    _showUnitInputDialog(context);
                  } else {
                    Get.back();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        'Please fill in all fields.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      )),
                    );
                  }
                } else {
                  if (productName.isNotEmpty) {
                    controller.selectedMaster.value == 'Place'
                        ? setState(() {
                            place.add(productName);
                          })
                        : controller.selectedMaster.value == 'Process'
                            ? setState(() {
                                process.add(productName);
                              })
                            : null;
                    Get.back();
                  } else {
                    Get.back();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        'Please fill in all fields.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      )),
                    );
                  }
                }
              },
              child: Text(
                'Add',
                style: FontFamily.style
                    .copyWith(fontSize: 14, color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUnitInputDialog(BuildContext context) {
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add ${controller.selectedMaster.value}'),
          titleTextStyle: FontFamily.style
              .copyWith(fontSize: 22, color: ColorPage.appBarColor),
          titlePadding: EdgeInsets.only(top: 20, left: 24),
          contentPadding:
              EdgeInsets.only(top: 5, left: 24, right: 24, bottom: 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Provide the unit details to add a new item.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Unit: ',
                    style: FontFamily.styleb.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType
                          .number, // Set the keyboard type to number
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only digits
                      ],
                      decoration: InputDecoration(
                          labelText: 'Unit',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                itemsBeforeAdd.clear();

                Get.back();
              },
              child: Text(
                'Cancel',
                style: FontFamily.styleb
                    .copyWith(color: Colors.deepOrange, fontSize: 15),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPage.appBarColor),
              onPressed: () {
                // String productName = quantityController.text;
                String quantityText = quantityController.text;
                // if (controller.selectedMaster.value == 'Item') {
                if (quantityText.isNotEmpty) {
                  itemsBeforeAdd['quantity'] = quantityText;

                  setState(() {
                    items.add({
                      'name': itemsBeforeAdd['name'],
                      'quantity': itemsBeforeAdd['quantity']
                    });
                  });
                  itemsBeforeAdd.clear();
                  quantityController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                }
                Get.back();
              },
              child: Text(
                'Add',
                style: FontFamily.style
                    .copyWith(fontSize: 14, color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({
    super.key,
  });

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  List<String> socialMediaIcons = [];
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

  final List<String> transactions =
      List.generate(10, (index) => "Transaction ${index + 1}");
  final List<String> reports =
      List.generate(10, (index) => "Report ${index + 1}");

  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPage.bgcolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: ColorPage.appBarColor,
                  )),
              SizedBox(
                width: 20,
              )
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
                  title: Text('Master',
                      style: FontFamily.styleb
                          .copyWith(fontSize: 24, color: Colors.blueGrey)),
                  children: [
                    drawerItem(
                      title: "Item",
                      onTap: () {
                        controller.selectedMaster.value = 'Item';
                        Get.back();
                      },
                      leading: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.orangeAccent,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,
                          size: 15, color: Colors.grey),
                    ),
                    drawerItem(
                      title: "Place",
                      onTap: () {
                        controller.selectedMaster.value = 'Place';
                        Get.back();
                      },
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: Colors.orangeAccent,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,
                          size: 15, color: Colors.grey),
                    ),
                    // drawerItem(
                    //   title: "Person",
                    //   onTap: () {
                    //     controller.selectedMaster.value = 'Person';
                    //     Get.back();
                    //   },
                    //   leading: Icon(
                    //     Icons.person_2_outlined,
                    //     color: Colors.orangeAccent,
                    //   ),
                    //   trailing: Icon(Icons.arrow_forward_ios_rounded,
                    //       size: 15, color: Colors.grey),
                    // ),
                    drawerItem(
                      title: "Process",
                      onTap: () {
                        controller.selectedMaster.value = 'Process';
                        Get.back();
                      },
                      leading: Icon(
                        Icons.checklist,
                        color: Colors.orangeAccent,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,
                          size: 15, color: Colors.grey),
                    ),
                  ],
                ),
                ExpansionTile(
                  dense: true,
                  shape: Border.all(color: Colors.transparent),
                  title: Text('Transactions',
                      style: FontFamily.styleb
                          .copyWith(fontSize: 24, color: Colors.blueGrey)),
                  children: transactions.map((transaction) {
                    return drawerItem(
                      title: transaction,
                      onTap: () {},
                      leading: Icon(
                        Icons.trending_neutral_sharp,
                        color: Colors.green,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,
                          size: 15, color: Colors.grey),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  title: Text('Report',
                      style: FontFamily.styleb
                          .copyWith(fontSize: 24, color: Colors.blueGrey)),
                  children: reports.map((report) {
                    return drawerItem(
                      title: report,
                      onTap: () {},
                      leading: Icon(
                        Icons.bar_chart,
                        color: Colors.amber,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,
                          size: 15, color: Colors.grey),
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
  Widget drawerHeader({required String header, Widget? trailing}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              header,
              style: FontFamily.styleb
                  .copyWith(color: Colors.blueGrey.shade300, fontSize: 24),
            )
          ],
        ));
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
  const RightDrawer({
    super.key,
  });

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
  List<String> socialMediaIcons = [];
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
            decoration: BoxDecoration(
              color: ColorPage.appBarColor,
            ),
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
