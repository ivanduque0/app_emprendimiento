import 'package:app_emprendimiento/db/db_helper.dart';
import 'package:app_emprendimiento/order/domain/models/product_cart.dart';
import 'package:app_emprendimiento/order/domain/repositories/api_order_repository.dart';
import 'package:app_emprendimiento/order/domain/repositories/local_order_repository.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:get/get.dart';

enum OrderStep {
  selectItems,
  setOrderInfo,
  finish
}

enum CartState {
  initial,
  change
}

enum SelectItemsState {
  normal,
  detail,
  cart
}

class OrderController extends GetxController {
  final LocalOrderInterface localOrderInterface;  
  final ApiOrderInterface apiOrderInterface;  

  OrderController({
    required this.localOrderInterface,
    required this.apiOrderInterface,
  });

  RxBool orderDateSelected = false.obs;
  RxInt selectedRemindTime = 5.obs;
  RxInt selectedColor = 0.obs;
  Rx<DateTime> orderDateTime = DateTime.now().obs;
  var orderStep = OrderStep.selectItems.obs;
  var selectItemsState = SelectItemsState.normal.obs;
  var cartState = CartState.initial.obs;
  RxList itemsList = [].obs;
  RxInt itemQuantity = 1.obs;
  RxList<ProductCart> cartProducts = <ProductCart>[].obs;
  late Rx<ProductCart> selectedProduct;
  RxString heroTag = "".obs;
  RxInt productsInCartQuantity=0.obs;
  RxDouble totalToPay = 0.00.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getItemsInStock();
    super.onInit();
  }

  increaseItemQuantity(){
    itemQuantity(itemQuantity.value+1);
  }

  decreaseItemQuantity(){
    itemQuantity(itemQuantity.value-1);
  }

  resetItemQuantity(){
    itemQuantity(1);
  }

  changeOrderStep(OrderStep step){
    orderStep(step);
  }

  changeSelectItemsState(SelectItemsState state){
    selectItemsState(state);
  }

  getItemsInStock()async{
  List items = await DBHelper.queryItems();
  // itemsList.assignAll(items.map((data) => print(data['price'].runtimeType)));
  // itemsList.assignAll(items.map((data) => print(data)));
  itemsList.assignAll(items.map((data) => new Item.fromJson(data)).toList());
}

  addProductToCart(ProductCart productToCart){
    // List<ProductCart> cart = cartProducts.value;
    // cart.contains(product);
    // cart.add(product);
    // cartProducts(cart);
    for (ProductCart productCart in cartProducts.value) {
      if (productCart.product.id==productToCart.product.id) {
        if (productCart.quantity<productToCart.quantity) {
          int deltaQuantity=productToCart.quantity-productCart.quantity;
          totalToPay=(totalToPay.value + deltaQuantity*double.parse(productToCart.product.price??"0")).obs;
          productsInCartQuantity=(productsInCartQuantity.value+deltaQuantity).obs;
        } else {
          int deltaQuantity=productCart.quantity-productToCart.quantity;
          totalToPay=(totalToPay.value - deltaQuantity*double.parse(productToCart.product.price??"0")).obs;
          productsInCartQuantity=(productsInCartQuantity.value-deltaQuantity).obs;
        }
        return productCart.changeQuantity(productToCart.quantity);
      }
    }
    cartProducts.add(productToCart); 
    totalToPay=(totalToPay.value + productToCart.quantity*double.parse(productToCart.product.price??"0")).obs;
    productsInCartQuantity=(productsInCartQuantity.value+productToCart.quantity).obs;
  }

  
  lookForProductInCart(int productID){
    for (ProductCart productCart in cartProducts.value) {
      
      if (productCart.product.id == productID) {
        selectedProduct = productCart.obs;
        itemQuantity(selectedProduct.value.quantity);
      }
    }
    
  }

  refresCart(){
    cartState(CartState.change);
    cartState(CartState.initial);
    
  }

  deleteProductOnCart(int productID){
    for (ProductCart productCart in cartProducts.value) {
      if (productCart.product.id == productID) {
        productsInCartQuantity=(productsInCartQuantity.value-productCart.quantity).obs;
        totalToPay=(totalToPay.value - productCart.quantity*double.parse(productCart.product.price??"0")).obs;
        cartProducts.remove(productCart);
        refresCart();
      }
    }
  }
}