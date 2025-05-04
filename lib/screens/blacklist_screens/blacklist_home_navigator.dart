import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_candidate_profile_screen.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_home.dart';

class BlacklistHomeNavigator extends StatelessWidget {
  const BlacklistHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
       key: key,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const BlacklistHomeScreen();
            break;
          case '/candidate':
            builder = (BuildContext _) => const BlacklistCandidateProfileScreen(
            
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
