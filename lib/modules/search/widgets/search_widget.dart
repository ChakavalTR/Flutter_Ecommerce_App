import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: SizedBox(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkBg.withOpacity(0.5),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 250, 250, 250),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppTheme.darkBg.withOpacity(0.1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppTheme.primary),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppTheme.darkBg.withOpacity(0.1)),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_list_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
