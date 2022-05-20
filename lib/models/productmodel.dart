class ProductModel {
  ProductModel(
      {required this.price,
      required this.name,
      required this.img,
      required this.desc,
      required this.brand,
      required this.sizes,
      required this.colours});
  final String price, brand, desc, name;
  final List img;
  final List sizes;
  final List colours;
}

class CartProductModel {
  CartProductModel(
      {required this.price,
      required this.name,
      required this.img,
      required this.desc,
      required this.brand,
      required this.sizes,
      this.size,
      required this.colour,
      required this.quantity,
      required this.colours});
  final String price, brand, desc, name;
  final List<String> img;
  final List<String>? sizes;
  final dynamic size;
  final int quantity;
  final Map colour;
  final List<Map>? colours;
}
