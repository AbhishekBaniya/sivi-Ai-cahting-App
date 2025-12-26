import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_log_tracer.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/imports_utils.dart';
import '../../model/portfolio_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<PortfolioModel> getPortfolio({required String endPoint});
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final DioClient dioClient;

  PortfolioRemoteDataSourceImpl(this.dioClient);

  @override
  Future<PortfolioModel> getPortfolio({required String endPoint}) async {
    try {
      final response = await dioClient.getRequest(
        endPoint,
        queryParams: {'limit': 340},
      );
      //dioClient.logRequest('GET', endPoint);
      //dioClient.logResponse(endPoint, response);
      ApiLogTracer().logResponse(
        endPoint,
        response.data,
        DateTime.now().difference(DateTime.now()),
      );

      // final data = response.data as Map<String, dynamic>;
      // final list = data['comments'] as List;
      //
      // return (list as List)
      //     .map((item) => PortfolioModel.fromJson(item))
      //     .toList(growable: false);

      return PortfolioModel.fromJson(response.data);
      // return (response.data as List)
      //     .map((item) => PortfolioModel.fromJson(item))
      //     .toList(growable: false);
    } catch (error) {
      Logger().error('Failed to fetch data: $error');
      throw ServerException();
    }
  }
}
