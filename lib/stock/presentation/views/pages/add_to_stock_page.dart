import 'dart:io';
import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:app_emprendimiento/stock/presentation/getx/stock_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/button.dart';
import 'package:app_emprendimiento/ui/widgets/input_currency_field.dart';
import 'package:app_emprendimiento/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddToStockPage extends GetWidget<StockController> {

  MainController mainController = Get.find();

  Future getImage(source) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file==null) return;
    final imageTemporary = File(file.path);
    var imagePath = file.path;
    print(imagePath);
    // File imageFile = await File(filePath);
    // controller.imageFile({"file": imageFile});
    await controller.addPhoto(imageTemporary,imagePath);
  }

  _saveNetworkImage(File image) async {

    // getting a directory path for saving
    final  Directory = await getApplicationDocumentsDirectory();
    print(Directory.path);
    // copy the file to a new path
    // print('${Directory.path}/image1.png');
    // await image.copy('${Directory.path}/image1.png');
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left:20, right:20),
        child: SingleChildScrollView(
          child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Añadir articulo",
                  style: headingStyle,
                ),
                MyInputField(title: "Nombre", hint:"ingrese nombre", textController: controller.nameTextController,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(child: MyInputCurrencyField(title: "precio", hint: "0.00\$", textController: controller.priceTextController,)),
                      SizedBox(width: 20,),
                      Expanded(child: MyInputField(title: "Cantidad disponible", hint: "0", onlyNumbers: true, textController: controller.quantityTextController,))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(child: MyButton(label: "Tomar foto", 
                        onTap: () async {
                          await getImage(ImageSource.camera);
                          }, 
                        color: purpleClr,)),
                      SizedBox(width: 20,),
                      Expanded(child: MyButton(label: "seleccionar imagen", 
                        onTap: () async {
                          await getImage(ImageSource.gallery);
                          }, 
                        color:purpleClr)),
                    ],
                  ),
                ),
                controller.imageFile.value['path']!=null?Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width - 10,
                      width: MediaQuery.of(context).size.width - 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(controller.imageFile.value['file'])
                        ),
                        color: white,
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                  ),
                ):SizedBox.shrink(),
                //MyInputField(title: "articulo", hint:"ingrese el articulo"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        label: "Añadir", 
                        onTap: () async {
                          if (controller.nameTextController.text!="" && controller.imageFile.value!={}) {
                            if (controller.priceTextController.text=="") {
                              controller.priceTextController.text="0.00";
                            }
                            if (controller.quantityTextController.text=="") {
                              controller.quantityTextController.text="0";
                            }

                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) {
                                return WillPopScope(
                                  onWillPop: () async => false,
                                  child:  Center(child: CircularProgressIndicator(strokeWidth: 5,)));
                              }
                            );
                            
                            _addItemToDB();
                            await mainController.getItemsInStock();
                            Get.back();
                            return Get.back();
                          }
                          Get.snackbar(
                            "Producto no registrado",
                            "ingrese un nombre y foto del producto",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: mainController.isDarkMode.value?white:Colors.grey[400],
                            colorText: pinkClr,
                            icon: Icon(Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            margin: EdgeInsets.only(bottom: 15, left: 15, right: 15)
                          );
                          //_saveNetworkImage(controller.imageFile.value['file']);
                        }),
                    ],
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addItemToDB() async {
    int value = await controller.addItem(
      Item( 
        name:controller.nameTextController.text, 
        price:controller.priceTextController.text, 
        photo:controller.imageFile.value["path"], 
        quantity:int.parse(controller.quantityTextController.text)
      )
    );
  }

  _appBar(){
    return AppBar(
      
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
        ),
      ),
    );
  }

  //_addItem
}