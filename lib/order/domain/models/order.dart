class Order {
  int? id;
  String? name;
  String? note;
  double? toPay;
  String? items;
  String? date;
  String? time;
  int? remind;
  int? color;
  bool? isCompleted;

  Order(
    this.id,
    this.name,
    this.note,
    this.toPay,
    this.items,
    this.date,
    this.time,
    this.remind,
    this.color,
    this.isCompleted,
  );

  Order.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    toPay = json['toPay'];
    items = json['items'];
    date = json['date'];
    time = json['time'];
    remind = json['remind'];
    color = json['color'];
    isCompleted = json['isCompleted'];
  }

  Map toJson(){
    final Map data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['note'] = this.note;
    data['toPay'] = this.toPay;
    data['items'] = this.items;
    data['date'] = this.date;
    data['time'] = this.time;
    data['remind'] = this.remind;
    data['color'] = this.color;
    data['isCompleted'] = this.isCompleted;
    
    return data;
  }

}