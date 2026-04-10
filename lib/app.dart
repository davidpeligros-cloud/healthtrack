import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/constants/app_colors.dart';

class HealthTrackApp extends StatelessWidget {
  const HealthTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthTrack',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.accentBlue,
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.accentBlue,
        scaffoldBackgroundColor: AppColors.backgroundPrimaryDark,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const Scaffold(
        body: Center(
          child: Text('HealthTrack scaffold'),
        ),
      ),
    );
  }
}
