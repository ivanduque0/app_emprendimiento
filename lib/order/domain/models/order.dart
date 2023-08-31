class Order {
  int? id;
  String? name;
  String? note;
  String? toPay;
  String? paid;
  String? products;
  String? date;
  String? time;
  int? remind;
  int? color;
  bool? isCompleted;

  Order({
    this.id,
    this.name,
    this.note,
    this.toPay,
    this.paid,
    this.products,
    this.date,
    this.time,
    this.remind,
    this.color,
    this.isCompleted,
  }
  );

  Order.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    toPay = double.parse(json['to_pay'].toString()).toStringAsFixed(2);
    paid = double.parse(json['paid'].toString()).toStringAsFixed(2);
    products = json['products'];
    date = json['date'];
    time = json['time'];
    remind = json['remind'];
    color = json['color'];
    isCompleted = json['is_completed']==1?true:false;
  }

  Map<String, Object?> toJson(){
    var data = <String, Object?>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['note'] = this.note;
    data['to_pay'] = this.toPay;
    data['paid'] = this.paid;
    data['products'] = this.products;
    data['date'] = this.date;
    data['time'] = this.time;
    data['remind'] = this.remind;
    data['color'] = this.color;
    data['is_completed'] = this.isCompleted==true?1:0;
    
    return data;
  }

}