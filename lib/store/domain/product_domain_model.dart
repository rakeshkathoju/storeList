class ProductDomainModelList {
    List<ProductDomainModel> productDomainModels;

  ProductDomainModelList({
    required this.productDomainModels,
  });


}

class ProductDomainModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductDomainModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductDomainModel.fromJson(
    Map<String, dynamic> json,
  ) => ProductDomainModel(
    id: json['id'],
    title: json['title'],
    price: (json['price'] as num).toDouble(),
    description: json['description'],
    category: json['category'],
    image: json['image'],
    rating: Rating.fromJson(json['rating']),
  );
}

enum Category { ELECTRONICS, JEWELERY, MEN_S_CLOTHING, WOMEN_S_CLOTHING }

class Rating {
  double rate;
  int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: (json['rate'] as num).toDouble(), count: json['count']);
}
