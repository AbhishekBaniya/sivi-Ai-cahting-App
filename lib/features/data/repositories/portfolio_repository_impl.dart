import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/network/endpoints.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../data_source/remote_data_source/portfolio_remote_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PortfolioEntity>> getPortfolio() async {
    try {
      final portfolioModels = await remoteDataSource.getPortfolio(
        endPoint: EndPoints.user,
      );
      return Right(
        PortfolioEntity(
          total: portfolioModels.total,
          skip: portfolioModels.skip,
          limit: portfolioModels.limit,
          comments: portfolioModels.comments
              ?.map(
                (e) => CommentsEntity(
                  id: e.id,
                  body: e.body,
                  postId: e.postId,
                  likes: e.likes,
                  userEntity: e.user != null
                      ? UserEntity(
                          id: e.user!.id,
                          username: e.user!.username,
                          fullName: e.user!.fullName,
                        )
                      : null,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
