import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_clean_architecture/core/di/injector.dart';
import 'package:api_clean_architecture/core/networking/failure.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/bloc/listing_bloc.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/bloc/listing_event.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/bloc/listing_state.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              Injector.injectorInstatnce<ListingBloc>()
                ..add(GetAllProductsEvent()),
      child: const ListingView(),
    );
  }
}

class ListingView extends StatelessWidget {
  const ListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listing Screen')),
      body: BlocConsumer<ListingBloc, ListingState>(
        listenWhen: (prev, curr) => curr is ErrorState,
        buildWhen: (prev, curr) => curr is! ErrorState,
        listener: (context, state) {
          if (state is ErrorState) {
            final errorMessage = CustomError(state.message).toString();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorMessage)));
          }
        },
        builder: (context, state) {
          switch (state) {
            case InitialState():
              return LinearProgressIndicator(minHeight: 2);

            case LoadingState():
              return const Center(child: CircularProgressIndicator());

            case ProductListingState():
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('\$ ${product.price}'),
                  );
                },
              );

            case ErrorState():
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
