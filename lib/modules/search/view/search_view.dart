import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/search_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar, body: _buildBody);
  }

  //! Build AppBar
  AppBar get _buildAppBar {
    return AppBar(
      title: Text(
        'Search',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: AppTheme.darkBg,
        ),
      ),
    );
  }

  //! Build Body
  Widget get _buildBody {
    return Column(children: [SearchWidget()]);
  }
}
