import '../../../core/constants/app_constants.dart';
import '../../../models/year_model.dart';
import '../../../services/mock_data_service.dart';

abstract class IYearRepository {
  Future<List<YearModel>> getYears(String examId);
}

class YearRepository implements IYearRepository {
  const YearRepository();

  @override
  Future<List<YearModel>> getYears(String examId) async {
    await Future.delayed(AppConstants.mockDelay);
    return MockDataService.getYears(examId);
  }
}
