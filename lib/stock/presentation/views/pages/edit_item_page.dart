import 'dart:io';

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
import 'package:awesome_dialog/awesome_dialog.dart';

class EditItemPage extends GetWidget<StockController> {
  EditItemPage({
    super.key,
    this.id,
    this.photo,
    this.priceTextController,
    this.nameTextController,
    this.quantityTextController
    });

  final id;
  final photo;
  final TextEditingController? priceTextController;
  final TextEditingController? nameTextController;
  final TextEditingController? quantityTextController;
   
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
                Text("Editar articulo",
                  style: headingStyle,
                ),
                MyInputField(title: "Nombre", hint:"ingrese nombre", textController: nameTextController,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(child: MyInputCurrencyField(title: "precio", hint: "0.00\$", textController: priceTextController,)),
                      SizedBox(width: 20,),
                      Expanded(child: MyInputField(title: "Cantidad disponible", hint: "0", onlyNumbers: true, textController: quantityTextController,))
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Hero(
                      tag:"photoItem_$id",
                      child: Container(
                        height: MediaQuery.of(context).size.width - 10,
                        width: MediaQuery.of(context).size.width - 10,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: FileImage(controller.imageFile.value['file']??File(photo))
                          ),
                          color: white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                  ),
                ),
                //MyInputField(title: "articulo", hint:"ingrese el articulo"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                        color: Colors.red,
                        label: "Eliminar\nArticulo", 
                        onTap: () async {
                          AwesomeDialog(
                            btnCancelText: "NO",
                            btnOkText: "SI",
                            titleTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black
                            ),
                            // descTextStyle: TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: 20,
                            //   color: Colors.black
                            // ),
                            context: context,
                            animType: AnimType.bottomSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.warning,
                            showCloseIcon: true,
                            title: "Seguro que desea eliminar el articulo?",
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              controller.deleteItem(id);
                              await mainController.getItemsInStock();
                              Get.back();
                            },
                          ).show();
                        }
                      ),
                      MyButton(
                        label: "Editar", 
                        onTap: () async {
                          if (nameTextController!.text!="") {
                            if (priceTextController!.text=="") {
                              priceTextController!.text="0.00";
                            }
                            if (quantityTextController!.text=="") {
                              quantityTextController!.text="0";
                            }
                            _updateItemInDB();
                            await mainController.getItemsInStock();
                            return Get.back();
                          }
                          Get.snackbar(
                            "Producto no editado",
                            "ingrese un nombre para el producto",
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

  _updateItemInDB() async {
    int value = await controller.updateItem(
      Item( 
        id:id,
        name:nameTextController!.text, 
        price:priceTextController!.text, 
        photo:controller.imageFile.value["path"]??photo, 
        quantity:int.parse(quantityTextController!.text)
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
}