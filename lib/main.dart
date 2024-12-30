import 'package:flappy_dash/domain/repositories/game_repository.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/pages/splash/splash_page.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flappy_dash/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(
        getIt.get<AudioHelper>(),
        getIt.get<GameRepository>(),
      ),
      child: MaterialApp(
        title: 'Flappy Dash',
        home: SplashPage(),
        theme: ThemeData(fontFamily: Constants.ui.fonts.mainFont),
      ),
    );
  }
}
