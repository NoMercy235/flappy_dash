import 'package:flappy_dash/domain/repositories/game_repository.dart';
import 'package:flappy_dash/presentation/pages/main_page.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flappy_dash/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(getIt.get<GameRepository>()),
      child: const SplashPageContent(),
    );
  }
}

class SplashPageContent extends StatefulWidget {
  const SplashPageContent({super.key});

  @override
  State<SplashPageContent> createState() => _SplashPageContentState();
}

class _SplashPageContentState extends State<SplashPageContent> {
  @override
  void initState() {
    context.read<SplashCubit>().onPageOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.openHomePage) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Container()),
                Image.asset(
                  Constants.files.splash,
                  width: Constants.ui.sizes.splashIconSize,
                  height: Constants.ui.sizes.splashIconSize,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Flappy Dash',
                        style: TextStyle(
                          fontSize: Constants.ui.fonts.sizeSmall,
                          color: Constants.ui.colors.splashText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
