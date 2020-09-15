import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proton/provider/tasks.dart';
import 'package:proton/routes/app_routes.dart';
import 'package:proton/screens/task_form.dart';
import 'package:proton/screens/task_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.grey,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new ChangeNotifierProvider(
          create: (ctx) => Tasks(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            routes: {
              AppRoutes.HOME: (_) => TaskList(),
              AppRoutes.TASK_FORM: (_) => TaskForm(),
            },
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('pt'),
            ],
          ),
        );
      },
    );
  }
}
