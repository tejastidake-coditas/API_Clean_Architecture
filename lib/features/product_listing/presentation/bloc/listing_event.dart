import 'package:equatable/equatable.dart';

sealed class ListingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllProductsEvent extends ListingEvent {}
