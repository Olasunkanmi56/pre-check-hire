import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/employer_screens/employer_home_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_workers_listing_screen.dart';

class EmployerHomeNavigator extends StatelessWidget {
  const EmployerHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
       key: key,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const EmployerHomeScreen();
            break;
          case '/candidates':
            builder = (BuildContext _) => const EmployerExploreCandidatesScreen(
            
            );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
