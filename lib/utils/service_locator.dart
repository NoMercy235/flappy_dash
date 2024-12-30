import 'package:flappy_dash/data/local/device_data_source.dart';
import 'package:flappy_dash/data/remote/nakama_data_source.dart';
import 'package:flappy_dash/domain/repositories/game_repository.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton(() => AudioHelper());

  // DataSources
  getIt.registerLazySingleton<DeviceDataSource>(() => DeviceDataSource());
  getIt.registerLazySingleton<NakamaDataSource>(() => NakamaDataSource());

  // Repositories
  getIt.registerLazySingleton<GameRepository>(
    () => GameRepository(
      getIt.get<DeviceDataSource>(),
      getIt.get<NakamaDataSource>(),
    ),
  );
}
