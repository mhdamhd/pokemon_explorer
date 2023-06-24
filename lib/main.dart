import 'package:flutter/services.dart';
import 'package:pokemon_explorer/data/data_providers/api_client.dart';
import 'package:pokemon_explorer/data/repositories/app_config_repository.dart';
import 'package:pokemon_explorer/data/repositories/auth_repository.dart';
import 'package:pokemon_explorer/generated/l10n.dart';
import 'package:pokemon_explorer/logic/cubit/app_config/app_config_cubit.dart';
import 'package:pokemon_explorer/logic/cubit/session_controller/session_controller_cubit.dart';
import 'package:pokemon_explorer/presentation/router/app_router.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokemon_explorer/config/api_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppConfigRepository appConfigRepository = AppConfigRepository();
  await appConfigRepository.initializeApp();
  ApiClient apiClient = ApiClient(
      baseURL: ApiConfig.baseURL,
      languageCode: appConfigRepository.locale.languageCode);
  await apiClient.loadToken();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    App(
      appConfigRepository: appConfigRepository,
      apiClient: apiClient,
    ),
  );
}

class App extends StatelessWidget {
  final AppConfigRepository appConfigRepository;
  final ApiClient apiClient;

  late final AppRouter router;

  App({Key? key, required this.apiClient, required this.appConfigRepository})
      : super(key: key) {
    router = AppRouter(
        apiClient: apiClient, appConfigRepository: appConfigRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 2400),
        builder: (ctx, child) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => AppConfigCubit(appConfigRepository),
                ),
                BlocProvider(
                  create: (_) =>
                      SessionControllerCubit(AuthRepository(apiClient)),
                ),
              ],
              child: Builder(
                builder: (ctx) {
                  ctx.select<AppConfigCubit, String>(
                      (bloc) => bloc.state.langaugeCode);
                  apiClient
                      .setLanguageCode(appConfigRepository.locale.languageCode);
                  return BlocBuilder<SessionControllerCubit,
                      SessionControllerState>(
                    buildWhen: (previous, current) =>
                        current is SessionControllerSignedout,
                    builder: (context, state) {
                      return MaterialApp(
                        key: state.globalKey ?? GlobalKey(),
                        theme: ThemeData.light().copyWith(
                          primaryColor: AppColors.primaryColor,
                          colorScheme: ColorScheme.fromSwatch()
                              .copyWith(secondary: AppColors.accentColor),
                          appBarTheme: AppBarTheme(
                            color: AppColors.primaryColor,
                            elevation: 4,
                          ),
                        ),
                        themeMode: ThemeMode.light,
                        debugShowCheckedModeBanner: false,
                        locale: appConfigRepository.locale,
                        localizationsDelegates: const [
                          S.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],

                        // builder: DevicePreview.appBuilder,
                        supportedLocales: S.delegate.supportedLocales,
                        onGenerateRoute: router.generateRoute,
                      );
                    },
                  );
                },
              ),
            ));
  }
}
