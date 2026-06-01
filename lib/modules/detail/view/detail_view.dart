import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/detail/controller/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar);
  }

  //! Build AppBar
  AppBar get _buildAppbar {
    return AppBar(
      title: Text(controller.product.title),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
      ],
    );
  }
}
