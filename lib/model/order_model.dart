class OrderModel {
  String? userName;
  String? userEmail;
  String? userAddress;
  String? userUID;
  String? orderID;
  String? orderTime;
  String? totalPrice;
  String? imageUrl;
  String? orderStatus;
  String? userPhoneNumber;
  List<dynamic>? orderItems;
  List<dynamic>? sellerUIDs;

  OrderModel({
    this.userName,
    this.userEmail,
    this.userAddress,
    this.userUID,
    this.orderID,
    this.orderTime,
    this.totalPrice,
    this.imageUrl,
    this.orderStatus,
    this.userPhoneNumber,
    this.orderItems,
    this.sellerUIDs

});
}