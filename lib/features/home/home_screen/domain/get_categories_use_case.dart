import '../data/api/categories_client.dart';
import '../data/models/categories_model.dart';

class GetCategoriesUseCase {
  CategoriesClient client;

  GetCategoriesUseCase(this.client);

  Future<CategoryResponse> getCategories(int page, int pageSize) async {
    var result = await client.getCategories(page, pageSize);
    CategoryResponse category = CategoryResponse.fromJson(result);
    return category;
  }
}
