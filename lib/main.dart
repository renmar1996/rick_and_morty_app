import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/conectivity_module/bloc/conectivity_bloc.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'modules/home_module/presentation/bloc/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colors.primary==Colors.white?Brightness.light:Brightness.dark));
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConectivityBloc(), //* Este bloc puede ser utilizado por otro/s bloc para gestionar el estado de la conectividad por módulo
        ),
        BlocProvider(
          create: (context) => HomeBloc(context.read<ConectivityBloc>()),
        ),
        
      ],
      child: const CustomMaterialRouter(),
    );
  }
}

class CustomMaterialRouter extends StatefulWidget {
  const CustomMaterialRouter({
    super.key,
  });

  @override
  State<CustomMaterialRouter> createState() => _CustomMaterialRouterState();
}

class _CustomMaterialRouterState extends State<CustomMaterialRouter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme().darkTheme(),
      theme: AppTheme().lightTheme(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
