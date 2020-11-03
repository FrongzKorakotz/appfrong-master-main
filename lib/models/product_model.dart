class ProductModel {
  String name, detail, pathImage;

  ProductModel(this.name, this.detail, this.pathImage);

  ProductModel.fromMap(Map<String, dynamic> map) {
    name = map['Name'];
    detail = map['Detail'];
    pathImage = map['PathImage'];
  }
}
