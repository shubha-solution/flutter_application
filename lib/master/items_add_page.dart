import 'package:flutter/material.dart';
import 'package:flutter_application/color.dart';
import 'package:flutter_application/font_family.dart';
import 'package:get/get.dart';

class ItemsAddPage extends StatefulWidget {
  final String itemName;
  const ItemsAddPage({super.key, required this.itemName});

  @override
  State<ItemsAddPage> createState() => _ItemsAddPageState();
}

class _ItemsAddPageState extends State<ItemsAddPage> {
  List<Map<String,dynamic>> items = [];
  @override
  void initState() {
    
     for (int i = 1; i <= 5; i++) {
    items.add({
      'name': 'Item $i',
      'quantity': i * 10, // Assigning quantities as multiples of 10
    });
  }
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text( widget.itemName,style: FontFamily.styleb.copyWith(color: Colors.white),),
        iconTheme: IconThemeData(color:  Colors.white70),
        backgroundColor: ColorPage.appBarColor,
        actions: [IconButton(onPressed: (){ 
          _showInputDialog(context);

        }, icon: Icon(Icons.add_rounded,color: Colors.white70,))],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            _showEditDialog(context,index);
          },
          subtitle: Text(items[index]['quantity'].toString()),
          title: Text(items[index]['name']),
          trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          );
      },),
    );
  }
   void _showInputDialog(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add ${widget.itemName}'),
         titleTextStyle: FontFamily.style.copyWith(
          fontSize: 22,
          color: ColorPage.appBarColor),
          titlePadding: EdgeInsets.only(top: 20,left: 24),
          contentPadding: EdgeInsets.only(top: 5,left: 24,right: 24,bottom: 24),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                Expanded(
                  child: Text(
                    'Provide the necessary details to add a new item to the list.',
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
                  Text('Item: ',style: FontFamily.styleb.copyWith(fontSize: 14),),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        labelText: 'Item',
                        labelStyle: TextStyle(color: Colors.grey),

                        border: UnderlineInputBorder()
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                children: [
                  Text('Unit: ',style: FontFamily.styleb.copyWith(fontSize: 14),),
                  SizedBox(width: 10,),

                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                           Get.back();

              },
              child: Text('Cancel',style: FontFamily.styleb.copyWith(color: Colors.deepOrange,fontSize: 15),),
              
            ),
            ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: ColorPage.appBarColor),
              onPressed: () {
                
                String productName = productNameController.text;
    String quantityText = quantityController.text;

    if (productName.isNotEmpty && quantityText.isNotEmpty) {
      

        setState(() {
          items.add({
            'name': productName,
            'quantity': quantityText,
          });
        });

      
        productNameController.clear();
        quantityController.clear();
     
    } else {
   
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
              Get.back();
              },
              child: Text('Add',style: FontFamily.style.copyWith(fontSize: 14,color: Colors.white70),),
            ),
          ],
        );
      },
    );
  }

void _showEditDialog(BuildContext context, int index) {
    TextEditingController productNameController =
        TextEditingController(text: items[index]['name']);
    TextEditingController quantityController =
        TextEditingController(text: items[index]['quantity'].toString());

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
          ),
          actions: <Widget>[
           TextButton(
              onPressed: () {
                           Get.back();

              },
              child: Text('Cancel',style: FontFamily.styleb.copyWith(color: Colors.deepOrange,fontSize: 15),),
              
            ),
            











            
            ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: ColorPage.appBarColor),
               onPressed: () {
                String updatedName = productNameController.text;
                String updatedQuantity = quantityController.text;

                if (updatedName.isNotEmpty && updatedQuantity.isNotEmpty) {
                 

                
                    setState(() {
                      items[index]['name'] = updatedName;
                      items[index]['quantity'] = updatedQuantity;
                    });

                    Navigator.of(context).pop(); // Close the dialog
                  
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                }
              },
              child: Text('Save',style: FontFamily.style.copyWith(fontSize: 14,color: Colors.white70),),
            ),
          ],
        );
      },
    );
  }
}