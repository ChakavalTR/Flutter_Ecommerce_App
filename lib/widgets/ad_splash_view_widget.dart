import 'dart:async';

import 'package:flutter/material.dart';

class AdSplashViewWidget extends StatefulWidget {
  const AdSplashViewWidget({super.key});

  @override
  State<AdSplashViewWidget> createState() => _AdSplashViewWidgetState();
}

class _AdSplashViewWidgetState extends State<AdSplashViewWidget> {
  //* Variables Section *\\
  int countdown = 3;
  Timer? _timer;
  //-------------------------
  //* Lifecycle Section *\\
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
