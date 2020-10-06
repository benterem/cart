//Class for product formatting
class ProductModel {
  String _name;
  int _price;
  int _quantity;

  ProductModel(String name, int price) {
    this._name = name;
    this._price = price;
    //this._quantity = 0;
  }

  //getters
  String getName() => this._name;
  int getPrice() => this._price;
  int getQuantity() => this._quantity;

  //setters
  int setQuantity(bool increase) {
    return increase ? this._quantity++ : this._quantity--;
  }
}
