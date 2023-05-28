import 'package:expenses/pages/add_expenses.dart';
import 'package:expenses/pages/categories_details.dart';
import 'package:expenses/pages/expenses_details.dart';
import 'package:expenses/pages/home_page.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/providers/local_notifications.dart';
import 'package:expenses/providers/shared_prefs.dart';
import 'package:expenses/providers/theme_provider.dart';
import 'package:expenses/providers/ui_provider.dart';
import 'package:expenses/utils/objectbox_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ObjectBoxDB().initStore();
  final prefs = UserPrefs();
  await prefs.initPrefs();

  await LocalNotifications().init();
  // await UserPrefs().initPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs.darkMode)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        // supportedLocales: const [Locale('es'), Locale('en')],
        theme: value.getTheme(),
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePg(),
          'add_expenses': (_) => const AddExpensesPage(),
          'category_details': (_) => const CategoriesDetailPage(),
          'exp_details': (_) => const ExpensesDetailPage(),
          // 'add_entries': (_) => const AddEntriesPage(),
        },
      );
    });
  }
}
