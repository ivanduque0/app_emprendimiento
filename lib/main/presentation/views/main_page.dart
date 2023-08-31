import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/main/presentation/views/screens/orders_screen.dart';
import 'package:app_emprendimiento/main/presentation/views/screens/stock_screen.dart';
import 'package:app_emprendimiento/main/presentation/views/screens/tasa_dolar.dart';
import 'package:app_emprendimiento/services/notification_services.dart';
import 'package:app_emprendimiento/services/theme_services.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {

class MainPage extends GetWidget<MainController> {

  PageController _pageController = PageController(initialPage: 0);

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: "Pedidos"
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory_2_sharp),
      label: "Inventario"
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on_outlined),
      label: "Tasa"
      ),
  ];

  void _onItemTapped(int index)async{
    _pageController.animateToPage(
      index, 
      duration: Duration(milliseconds: 500), 
      curve: Curves.decelerate
    );
  }

  void _onSwapScreen(int index)async{
    controller.mainScreenIndex(index);
    if (index==2) {
      controller.calculatorTextController.clear();
      controller.calculoDolar(0);
      // try {
      //   await controller.updateTasa();
      // } catch (e) {
      //   NotifyHelper().displayNotification(
      //     title:"¡ATENCION!",
      //     body:"Error al actualizar la tasa, intentelo de nuevo"
      //   );
      //   return ;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        appBar: _appBar(),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onSwapScreen,
          children: [
            OrdersScreen(),
            StockScreen(),
            TasaDolarScreen()
          ],
        ),
        floatingActionButton: controller.mainScreenIndex.value==2?
        FloatingActionButton(
          onPressed: () async {
            try {
              controller.changeUpdateTasaState(UpdateTasaState.update);
              await controller.updateTasa();
            } catch (e) {
              NotifyHelper().displayNotification(
                title:"¡ATENCION!",
                body:"Error al actualizar la tasa, intentelo de nuevo"
              );
            }
            controller.changeUpdateTasaState(UpdateTasaState.initial);
            if (controller.calculatorTextController.text.isEmpty) {
              return;
            }
            controller.calculoDolar(double.parse(controller.calculatorTextController.text)*controller.tasaDolar.value);
            controller.refreshScreenFunction();
          },
          backgroundColor: yellowClr,
          shape: const RoundedRectangleBorder( // <= Change BeveledRectangleBorder to RoundedRectangularBorder
            // borderRadius: BorderRadius.all(Radius.circular())
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(5.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: controller.updateTasaState.value==UpdateTasaState.update?
          Transform(
            transform: Matrix4.identity()..scale(0.8),
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(
              strokeWidth: 5,
            ),
          ):Icon(Icons.refresh_outlined,
            size: 30,
            color: black,
          ), 
        ):
        null,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: controller.isDarkMode.value?darkGreyClr:white,
          currentIndex: controller.mainScreenIndex.value,
          onTap: _onItemTapped,
          items: _bottomNavigationBarItems,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: primaryClr,),
      ),
    );
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchThemeMode();
          NotifyHelper().displayNotification(
            title:"¡Tema cambiado!",
            body:Get.isDarkMode?"Modo claro activado":"Modo oscuro activado"
          );
          
          //notifyHelper.scheduledNotification();
        },
        child: Obx( ()=>Icon(
            controller.isDarkMode.value?Icons.wb_sunny_outlined:Icons.nightlight_outlined,
            size: 25,
            //color: Colors.white,
          ),
        ),
      ),
      // actions: [
      //   Icon(
      //     Icons.person,
      //     size: 25,
      //     //color: Colors.white
      //   ),
      //   SizedBox(
      //     width: 20,
      //   )
      // ],
    );
  }
}
