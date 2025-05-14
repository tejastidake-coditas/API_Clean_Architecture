import 'package:api_clean_architecture/core/di/injector.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/screen/listing_screen.dart';
import 'package:flutter/material.dart';

void main() {
  Injector.initInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListingScreen(),
    );
  }
}
