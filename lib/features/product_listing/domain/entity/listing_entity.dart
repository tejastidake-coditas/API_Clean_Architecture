import 'package:equatable/equatable.dart';

class ListingEntity extends Equatable {
  final int id;
  final String title;
  final double price;

  const ListingEntity({
    required this.id,
    required this.title,
    required this.price,
  });

  @override
  List<Object?> get props => [id, title, price];
}
