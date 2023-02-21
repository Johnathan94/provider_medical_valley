import '../data/api/search_client.dart';
import '../data/models/search_result.dart';

class SearchWithKeyboard {
  SearchClient client;

  SearchWithKeyboard(this.client);

  searchWithKeyword(String keyword, int page, int pageSize) async {
    var result = await client.searchWithKeyword(keyword, page, pageSize);
    return SearchResult.fromJson(result);
  }
}
