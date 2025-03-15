import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/core/utils/theme.dart';
import 'core/config/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Ensures that plugin services are initialized before the app starts.
  WidgetsFlutterBinding.ensureInitialized();
  // Loads environment variables from the .env file.
  await dotenv.load();

  // Runs the app and sets up the top-level provider scope for state management.
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      theme: CupertinoThemeData(primaryColor: AppTheme.primaryColor),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
