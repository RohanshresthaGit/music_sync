import 'package:music_sync/core/utils/either.dart';

import '../error/failures.dart';

abstract interface class UseCaseWithParams<SuccessType, ParamsType> {
  Future<Either<Failure, SuccessType>> call(ParamsType params);
}

abstract interface class UseCaseWithourParam<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}