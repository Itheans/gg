class MyOrder {
  String? id;
  String? name;
  String? phone;
  String? address;
  double? latitude;
  double? longtitude;
  double? amount;

  MyOrder(
      {required this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.latitude,
      required this.longtitude,
      required this.amount});

  MyOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude']?.toDouble();
    longtitude = json['longtitude']?.toDouble();
    amount = json['amount']?.toDouble();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "latitude": latitude,
        "longtitude": longtitude,
        "amount": amount,
      };

  void add(MyOrder order) {}
}
