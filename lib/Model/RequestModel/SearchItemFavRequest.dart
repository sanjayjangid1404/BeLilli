
class SearchItemFavRequest {
  String searchKey;


  SearchItemFavRequest(this.searchKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'search_key': searchKey.trim(),

    };

    return map;
  }
}