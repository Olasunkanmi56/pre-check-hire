import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_domestic_jobs.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_employment.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_home.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_job_detail.dart';

class JobseekerNavigator extends StatelessWidget {
  const JobseekerNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: key,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const JobSeekerHomeScreen();
            break;
          // case '/domestic-jobs':
          //   builder = (BuildContext _) =>  DomesticJobScreen();
          
           case '/domestic-jobs':
            builder = (BuildContext _) =>  JobSeekerEmploymentScreen();
            break;
            case '/jobs-details':
            builder = (BuildContext _) =>  JobSeekerJobDetailScreen();
            break;
            
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
