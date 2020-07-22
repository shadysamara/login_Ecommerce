class DBProduct {
  String ProductId;
  String ProductName;
  String ProdictImage;
  String ProductPrice;
  int ProductsCount;
  DBProduct(
      {this.ProdictImage,
      this.ProductId,
      this.ProductName,
      this.ProductPrice,
      this.ProductsCount});
  DBProduct.fromMap(Map<String, dynamic> map) {
    this.ProductId = map['ProductId'];
    this.ProductName = map['ProductName'];
    this.ProdictImage = map['ProdictImage'];
    this.ProductPrice = map['ProductPrice'];
    this.ProductsCount = map['ProductsCount'];
  }
  toJson() {
    return {
      'ProductId': this.ProductId,
      'ProductName': this.ProductName,
      'ProdictImage': this.ProdictImage,
      'ProductPrice': this.ProductPrice,
      'ProductsCount': this.ProductsCount
    };
  }
}
