import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  //* Variables Section *\\
  late ProductModel product;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    product = Get.arguments as ProductModel;
    super.onInit();
  }

  //-------------------------------------------
  //* Functions Section*\\
}
