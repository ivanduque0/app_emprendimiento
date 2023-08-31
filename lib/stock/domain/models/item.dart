class Item {
  int? id;
  String? name;
  String? price;
  String? photo;
  int? quantity;

  Item({
    this.id,
    this.name,
    this.price,
    this.photo,
    this.quantity
  });

  Item.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString()).toStringAsFixed(2);
    photo = json['photo'];
    quantity = json['quantity'];
  }

  Map<String, Object?> toJson(){
    var data = <String, Object?>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['photo'] = photo;
    data['quantity'] = quantity;
    return data;
  }

}