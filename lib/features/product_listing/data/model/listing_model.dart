import 'package:api_clean_architecture/features/product_listing/domain/entity/listing_entity.dart';

class ListingModel extends ListingEntity {
  const ListingModel({
    required super.id,
    required super.title,
    required super.price,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) => ListingModel(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    price: json['price'] ?? 0.0,
  );
}
