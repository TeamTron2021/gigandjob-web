import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-employeer/create_employeer_screen.dart';
import 'package:gigandjob_web/create-job-offer/presentation/create_job_offer_screen.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: Text('Home'),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: RaisedButton(
//               child: Text('logout'),
//               onPressed: () {
//                 BlocProvider.of<AuthenticationBloc>(context)
//                     .add(AdminLoggedOut());
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Dashboard> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.deepPurple[400],
              selectedColor: Colors.deepPurple,
              selectedTitleTextStyle: const TextStyle(color: Colors.black87),
              selectedIconColor: Colors.black87,
              unselectedIconColor: Colors.white,
              unselectedTitleTextStyle: const TextStyle(color: Colors.white),
             // unselectedTitleTextStyle: Colors.white70,
              // backgroundColor: Colors.amber,
              // openSideMenuWidth: 200
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: const Text('Git and Job\n   Backoffice', style: TextStyle(fontSize: 24),)
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer:  Padding(
              padding: const EdgeInsets.all(0.0),
              child: SideMenuItem(
                priority: 7,
                title: 'Exit',
                onTap: () async {BlocProvider.of<AuthenticationBloc>(context)
                    .add(AdminLoggedOut());},
                icon: Icons.exit_to_app,
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {

                },
                icon: Icons.home,
              ),
              SideMenuItem(
                priority: 1,
                title: 'Users',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icons.supervisor_account,
              ),
              SideMenuItem(
                priority: 2,
                title: 'Files',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icons.file_copy_rounded,
              ),
              SideMenuItem(
                priority: 3,
                title: 'Download',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icons.download,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Settings',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: Icons.settings,
              ),
              SideMenuItem(
                priority: 5,
                title: 'Create a Job Offer',
                onTap: () {
                  page.jumpToPage(5);
                },
                icon: Icons.assignment,
              ),
              SideMenuItem(
                priority: 6,
                title: 'Create a Employer',
                onTap: () {
                  page.jumpToPage(6);
                },
                icon: Icons.supervised_user_circle,
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Text(
                      'Page\n   1',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Text(
                      'Page\n   2',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Text(
                      'Page\n   3',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Text(
                      'Page\n   4',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  child:const Center(
                    child:  Text(
                      'Page\n   5',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  child: const CreateJobOfferScreen(),
                ),
                Container(
                  color: Colors.black54,
                  child: const CreateEmployerScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
