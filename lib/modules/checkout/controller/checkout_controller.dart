import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:flutter_ecommerce_app/modules/checkout/model/credit_card_model.dart';
import 'package:flutter_ecommerce_app/modules/checkout/model/shipping_address_model.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/card_name_holder_formatter_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/card_number_formatter_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/expiry_date_formatter_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  //* Variables Section *\\
  late final List<CartModel> checkoutItems;
  final selectedShipping = 0.obs;
  final selectedPaymentMethod = 0.obs;
  final List<String> creditCardImages = [
    'assets/icons/visa_icon.png',
    'assets/icons/mastercard_icon.png',
  ];
  final discount = 0.0.obs;
  final shippingAddress = <ShippingAddressModel>[].obs;
  final selectedAddressIndex = 0.obs;
  final isDefaultAddress = false.obs;
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String shippingAddressKey = 'shipping_address_key';
  bool isAddressFormPrepare = false;
  final savedCards = <CreditCardModel>[].obs;
  final isCardDropDownOpen = false.obs;
  final selectedCardIndex = (-1).obs;
  static const String creditCardKey = 'credit_cards_key';
  final cardNumberController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final creditCardFormKey = GlobalKey<FormState>();
  final promoCodeController = TextEditingController();
  final isPromoCodeApplied = false.obs;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    checkoutItems = (Get.arguments as List<CartModel>?) ?? [];
    loadShippingAddressFromLocalStorage();
    loadCreditCardsFromLocalStorage();
  }

  @override
  void onClose() {
    //! Address Form Controllers
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();

    //! Credit Card Form Controllers
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();

    //! Promo Code Controller
    promoCodeController.dispose();
    super.onClose();
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! Select Shipping Method
  void selectShippingMethod(int index) {
    selectedShipping.value = index;
  }

  //! Select Payment Method
  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
    if (index != 0) {
      isCardDropDownOpen.value = false;
    }
  }

  //! Toggle Credit/Debit Card
  void toggleCardDropDown() {
    selectedPaymentMethod.value = 0;
    isCardDropDownOpen.value = !isCardDropDownOpen.value;
  }

  //! Select Saved Card
  void selectSavedCard(int index) {
    if (index < 0 || index >= savedCards.length) return;
    selectedPaymentMethod.value = 0;
    selectedCardIndex.value = index;
  }

  //! Delete Saved Card
  Future<void> deleteSavedCard(int index) async {
    if (index < 0 || index >= savedCards.length) return;
    savedCards.removeAt(index);
    if (savedCards.isEmpty) {
      selectedCardIndex.value = -1;
    } else if (selectedCardIndex.value == index) {
      selectedCardIndex.value = 0;
    } else if (selectedCardIndex.value > index) {
      selectedCardIndex.value--;
    }
    await saveCreditCardsToLocalStorage();
  }

  //! Select Cash On Delivery
  void selectCashOnDelivery() {
    selectedPaymentMethod.value = 1;
    selectedCardIndex.value = -1;
    isCardDropDownOpen.value = false;
  }

  // //! Apply Promo Code
  void applyPromoCode() {
    final code = promoCodeController.text.trim().toLowerCase();
    if (code == 'flutter') {
      discount.value = 10.0;
      isPromoCodeApplied.value = true;
      Get.snackbar(
        'Success',
        'Promo code applied successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      discount.value = 0.0;
      isPromoCodeApplied.value = false;
      Get.snackbar(
        'Error',
        'Invalid promo code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Remove Promo Code
  void removePromoCode() {
    discount.value = 0.0;
    isPromoCodeApplied.value = false;
    promoCodeController.clear();
    Get.snackbar(
      'Success',
      'Promo code removed successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Fill Shipping Address
  void fillAddressForm(ShippingAddressModel address) {
    fullNameController.text = address.fullName;
    phoneController.text = address.phone;
    addressController.text = address.address;
    cityController.text = address.city;
    postalCodeController.text = address.postalCode;
    countryController.text = address.country;
    isDefaultAddress.value = address.isDefault;
  }

  //! Clear Shipping Address Form
  void clearShippingAddressForm() {
    fullNameController.clear();
    phoneController.clear();
    addressController.clear();
    cityController.clear();
    postalCodeController.clear();
    countryController.clear();
    countryController.text = 'Cambodia';
    isDefaultAddress.value = false;
  }

  //! Save Shipping Address
  void saveShippingAddress({ShippingAddressModel? oldAddress}) {
    if (!formKey.currentState!.validate()) return;
    final newAddress = ShippingAddressModel(
      id: oldAddress?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      city: cityController.text.trim(),
      postalCode: postalCodeController.text.trim(),
      country: countryController.text.trim(),
      isDefault: isDefaultAddress.value,
    );
    if (newAddress.isDefault) {
      for (var i = 0; i < shippingAddress.length; i++) {
        shippingAddress[i] = shippingAddress[i].copyWith(isDefault: false);
      }
    }
    if (oldAddress == null) {
      shippingAddress.add(newAddress);
      selectedAddressIndex.value = shippingAddress.length - 1;
    } else {
      final index = shippingAddress.indexWhere((e) => e.id == oldAddress.id);
      if (index != -1) {
        shippingAddress[index] = newAddress;
        selectedAddressIndex.value = index;
      }
    }
    saveShippingAddressToLocalStorage();
    clearShippingAddressForm();
    resetAddressFormPrepare();
    Get.back();
    Get.snackbar(
      'Success',
      'Address saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Select Shipping Address
  void selectShippingAddress(int index) {
    selectedAddressIndex.value = index;
    saveShippingAddressToLocalStorage();
  }

  //! Delete Shipping Address
  void deleteShippingAddress(int index) {
    shippingAddress.removeAt(index);
    if (selectedAddressIndex.value >= shippingAddress.length) {
      selectedAddressIndex.value = 0;
    }
    saveShippingAddressToLocalStorage();
    Get.snackbar(
      'Success',
      'Address deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Get Selected Shipping Address
  ShippingAddressModel? get selectedShippingAddress {
    if (shippingAddress.isEmpty) return null;
    return shippingAddress[selectedAddressIndex.value];
  }

  //! Edit Shipping Address
  void editShippingAddress(ShippingAddressModel oldAddress) {
    RouteView.addEditAddress.go(arguments: oldAddress);
  }

  //! Save Shipping Address to Local Storage
  void saveShippingAddressToLocalStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final data = shippingAddress.map((e) => e.toJson()).toList();
    await preferences.setString(shippingAddressKey, jsonEncode(data));
  }

  //! Load Shipping Address from Local Storage
  void loadShippingAddressFromLocalStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(shippingAddressKey);
    if (data == null) return;
    final List decodedData = jsonDecode(data);
    shippingAddress.value = decodedData
        .map((e) => ShippingAddressModel.fromJson(e))
        .toList();
    final defaultIndex = shippingAddress.indexWhere((e) => e.isDefault);
    if (defaultIndex != -1) {
      selectedAddressIndex.value = defaultIndex;
    }
  }

  //! Prepare Address Form
  void prepareAddressForm(ShippingAddressModel? editAddress) {
    if (isAddressFormPrepare) return;
    if (editAddress != null) {
      fillAddressForm(editAddress);
    } else {
      clearShippingAddressForm();
    }
    isAddressFormPrepare = true;
  }

  //! Reset Address Form Preparation
  void resetAddressFormPrepare() {
    isAddressFormPrepare = false;
  }

  //! Save Credit Card
  Future<void> saveCreditCard() async {
    final isValid = creditCardFormKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final cardNumber = cardNumberController.text.trim();
    final cardHolderName = cardHolderNameController.text.trim();
    final expiryDate = expiryDateController.text.trim();
    final card = CreditCardModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      cardNumber: maskCardNumber(cardNumber),
      cardHolder: cardHolderName,
      expiryDate: expiryDate,
      cardImage: getCardImage(cardNumber),
    );
    savedCards.add(card);
    selectedCardIndex.value = savedCards.length - 1;
    selectPaymentMethod(0);
    await saveCreditCardsToLocalStorage();
    clearCreditCardForm();
    Get.back();
    Get.snackbar(
      'Success',
      'Card saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Card Image based on Card Number
  String getCardImage(String cardNumber) {
    final number = cardNumber.replaceAll(' ', '');
    if (number.startsWith('4')) {
      return 'assets/icons/visa_icon.png';
    }
    if (number.startsWith('5')) {
      return 'assets/icons/mastercard_icon.png';
    }
    return 'assets/icons/visa_icon.png';
  }

  //! Mask The Card Number
  String maskCardNumber(String cardNumber) {
    final number = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (number.length < 4) {
      return '**** **** ****';
    }
    final last4 = number.substring(number.length - 4);
    return '**** **** **** $last4';
  }

  //! Save Credit Cards to Local Storage
  Future<void> saveCreditCardsToLocalStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final data = savedCards.map((card) => card.toJson()).toList();
    await preferences.setString(creditCardKey, jsonEncode(data));
  }

  //! Load Credit Cards from Local Storage
  Future<void> loadCreditCardsFromLocalStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(creditCardKey);
    if (data == null) return;
    final List<dynamic> decodedData = jsonDecode(data);
    savedCards.value = decodedData
        .map(
          (card) => CreditCardModel.fromJson(Map<String, dynamic>.from(card)),
        )
        .toList();
    if (savedCards.isNotEmpty) {
      selectedCardIndex.value = 0;
    }
  }

  //! Clear Credit Card Form
  void clearCreditCardForm() {
    cardNumberController.clear();
    cardHolderNameController.clear();
    expiryDateController.clear();
    cvvController.clear();
  }

  //! Add Credit Card Bottom Sheet
  void showAddCreditCardBottomSheet() {
    clearCreditCardForm();
    Get.bottomSheet(
      GestureDetector(
        onTap: () => FocusScope.of(Get.context!).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: Get.height * 0.80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 14),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Use the new Credit/Debit Card",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.08),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.verified_user, color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            'Rest assured, all data will be encrypted.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'Support Card Type :',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...List.generate(creditCardImages.length, (index) {
                            return Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.asset(
                                creditCardImages[index],
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    bottom: 10,
                  ),
                  child: Form(
                    key: creditCardFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Number',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          maxLength: 19,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardnumberformatterWidget(),
                          ],
                          decoration: InputDecoration(
                            hintText: '0000 0000 0000 0000',
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            final number = value?.replaceAll(' ', '') ?? '';
                            if (number.isEmpty) {
                              return 'Card number is required';
                            } else if (!RegExp(r'^\d{16}$').hasMatch(number)) {
                              return 'Card number must be 16 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Card Holder Name',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: cardHolderNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [CardNameHolderFormatterWidget()],
                          decoration: InputDecoration(
                            hintText:
                                'Must be consistant with the card infomation',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            final name = value?.trim() ?? '';
                            if (name.isEmpty) {
                              return 'Card holder name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Validity Period',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: expiryDateController,
                          keyboardType: TextInputType.datetime,
                          maxLength: 5,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ExpiryDateFormatterWidget(),
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'MM/YY',
                            suffixIcon: Icon(
                              Icons.question_mark_rounded,
                              size: 18,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            final expiry = value?.trim() ?? '';
                            if (expiry.isEmpty) {
                              return 'Expiry date is required';
                            } else if (!RegExp(
                              r'^\d{2}/\d{2}$',
                            ).hasMatch(expiry)) {
                              return 'Expiry date must be in MM/YY format';
                            }
                            final month = int.tryParse(expiry.substring(0, 2));
                            if (month == null || month < 1 || month > 12) {
                              return 'Invalid month';
                            }
                            final year = int.tryParse(expiry.substring(3, 5));
                            if (year == null) {
                              return 'Invalid expiry year';
                            }
                            final now = DateTime.now();
                            final currentYear = now.year % 100;
                            final currentMonth = now.month;
                            if (year < currentYear ||
                                (year == currentYear && month < currentMonth)) {
                              return 'Card has expired';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 14),
                        Text(
                          'CVV',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: 'Security code',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                'assets/icons/cvv.jpeg',
                                width: 20,
                                height: 20,
                              ),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.primary),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            final cvv = value?.trim() ?? '';
                            if (cvv.isEmpty) {
                              return 'CVV is required';
                            } else if (!RegExp(r'^\d{3}$').hasMatch(cvv)) {
                              return 'CVV must be 3 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              saveCreditCard();
                            },
                            child: Text('Confirm'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      ignoreSafeArea: true,
    );
  }

  //------------------------------------------
  //* Calculated Properties Section *\\
  //! Subtotal
  double get subTotal {
    double total = 0;
    for (final item in checkoutItems) {
      total += item.product.price * item.quantity.value;
    }
    return total;
  }

  //! Shipping Fee
  double get shippingFee {
    return selectedShipping.value == 0 ? 0 : 9.99;
  }

  //! Discount
  double get discountAmount {
    return subTotal * (discount.value / 100);
  }

  //! Total
  double get total {
    return subTotal + shippingFee - discountAmount;
  }
}
