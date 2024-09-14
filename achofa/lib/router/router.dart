import 'package:achofa/cubit/page_maquinaria.dart';
import 'package:achofa/screens/home.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/mp',
      builder: (context, state) => MaquinariaPage(),
    ),

  ]
);