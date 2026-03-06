import 'package:get_it/get_it.dart';
import 'package:project_ocr2/feture/data/datasourse/id_card_remote_datasource.dart';
import 'package:project_ocr2/feture/data/repository/id_card_repository_impl.dart';
import 'package:project_ocr2/feture/data/service/encryption_service.dart';
import 'package:project_ocr2/feture/domain/usecase/scan_idcard_usecase.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //Service
  sl.registerLazySingleton(() => EncryptionService());

  //DataSource
  sl.registerLazySingleton(
    () => IdCardRemoteDataSourceImpl(sl()),
  );

  //Repository
  sl.registerLazySingleton(
    () => IdCardRepositoryImpl(sl()),
  );

  //UseCase
  sl.registerLazySingleton(
    () => ScanIdCardUseCase(sl()),
  );

  //Bloc
  sl.registerFactory(
    () => IdCardBloc(sl()),
  );
}