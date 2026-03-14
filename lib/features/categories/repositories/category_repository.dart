import '../../../core/constants/app_constants.dart';
import '../../../models/category_model.dart';
import '../../../services/mock_data_service.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> getCategories(String examId);
}

class CategoryRepository implements ICategoryRepository {
  const CategoryRepository();

  @override
  Future<List<CategoryModel>> getCategories(String examId) async {
    await Future.delayed(AppConstants.mockDelay);
    return MockDataService.getCategories(examId);
  }
}
