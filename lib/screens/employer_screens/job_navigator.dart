import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/employer_screens/employer_joboffer_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_offer_detail.dart';

class EmployerJobsNavigator extends StatelessWidget {
  const EmployerJobsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: key,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const EmployerJobOffersScreen();
            break;
          case '/offerDetail':
            builder = (BuildContext _) => const EmployerOfferDetailScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
