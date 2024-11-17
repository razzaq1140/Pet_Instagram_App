import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pet_project/firebase_options.dart';
import 'package:pet_project/src/features/feed_and_recipe/recipe/controller/recipe_controller.dart';
import 'src/common/constants/global_variables.dart';
import 'src/features/_user_data/controllers/user_controller.dart';
import 'src/common/utils/shared_preferences_helper.dart';
import 'src/features/auth/pages/sign_in_page/controller/sign_in_controller.dart';
import 'src/features/auth/pages/sign_up_page/controller/sign_up_controller.dart';
import 'src/features/group_chat/provider/create_group_provider.dart';
import 'src/features/home/controller/home_story_controller.dart';
import 'src/features/settings/controller/settings_controller.dart';
import 'package:provider/provider.dart';
import 'src/features/home/controller/home_controller.dart';
import 'src/features/individual_chat/provider/message_provider.dart';
import 'src/router/routes.dart';
import 'src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.getInitialValue();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('ar'),
        Locale('nl'),
        Locale('fil'),
        Locale('el'),
        Locale('ja'),
        Locale('ru'),
        Locale('es'),
        Locale('tr'),
        Locale('de'),
        Locale('fa'),
        Locale('fr'),
        Locale('it'),
        Locale('ko'),
        Locale('pt'),
        Locale('sw'),
        Locale('zh'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => HomeStoryController()),
          ChangeNotifierProvider(create: (_) => GroupChatProvider()),
          ChangeNotifierProvider(create: (_) => UserController()),
          ChangeNotifierProvider(create: (_) => MessageProvider()),
          ChangeNotifierProvider(create: (_) => SignUpController()),
          ChangeNotifierProvider(create: (_) => SignInController()),
          ChangeNotifierProvider(create: (_) => SettingsController()),
          ChangeNotifierProvider(create: (_) => UploadRecipeController()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (progress) => const Center(
        child:
            CircularProgressIndicator(color: Color.fromRGBO(42, 205, 195, 1)),
      ),
      child: MaterialApp.router(
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: AppTheme.instance.lightTheme,
        routerConfig: MyAppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
