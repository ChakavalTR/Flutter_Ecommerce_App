import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/title_result_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final List<ProductModel> products;
  const SearchResultWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          TitleResultWidget(
            title: 'Search Results',
            resultCount: products.length,
          ),
          ListView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  RouteView.detail.go(arguments: product);
                },
                child: Container(
                  height: 130,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          width: 120,
                          height: 120,
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primary,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[200],
                            child: Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${product.category} | ${product.brand}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.greyText.withOpacity(0.7),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    product.rating.toString(),
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                '\$${product.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: AppTheme.success,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppTheme.greyText.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
