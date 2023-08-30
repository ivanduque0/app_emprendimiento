import 'package:app_emprendimiento/stock/domain/models/item.dart';

class ProductCart {
  Item product;
  int quantity;

  ProductCart({
    required this.product,
    this.quantity=1
    }
  );

  changeQuantity(int newQuantity){
    quantity=newQuantity;
  }

}