class CreditCardModel {
  final String id;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cardImage;

  CreditCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'expiryDate': expiryDate,
      'cardImage': cardImage,
    };
  }

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      cardHolder: json['cardHolder'],
      expiryDate: json['expiryDate'],
      cardImage: json['cardImage'],
    );
  }
}
