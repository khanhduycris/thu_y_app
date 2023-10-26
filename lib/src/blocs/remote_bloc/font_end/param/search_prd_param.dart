
class SearchPrdParam  {
  //categories=5&brands=1&name=sach nhi&min=0&max=100000&sort_key=price_low_to_high
  int? categories;
  int? brands;
  String? name;
  String? min;
  String? max;
  //price_low_to_high,price_high_to_low,new_arrival,popularity,top_rated
  String? sort_key;
  int? page;
  int? limit;

  SearchPrdParam({
    this.categories,
    this.brands,
    this.name,
    this.min,
    this.max,
    this.sort_key,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'categories': this.categories,
      'brands': this.brands,
      'name': this.name,
      'min': this.min,
      'max': this.max,
      'sort_key': this.sort_key,
      'page': this.page,
      'limit': this.limit,
    };
  }
}