import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_gp/app_properties.dart';
import 'package:team_gp/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Login/login_form.dart';

import 'change_country.dart';
import 'change_language_page.dart';
import 'change_password_page.dart';
import 'legal_about_page.dart';

class SettingsPage extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
        title: Text("SETTING",
            style: TextStyle(color: Colors.black, fontSize: 16.5)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red[100],
        iconTheme: IconThemeData(
          color: Colors.red[700],
        ),
      ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'General',
                                style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Language A / का'),
                              trailing: Icon(Icons.language,color: Colors.red,),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeLanguagePage())),
                            ),
                            ListTile(
                              title: Text('Change Country'),
                              trailing: Icon(Icons.home_work_outlined,color: Colors.red,),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeCountryPage())),
                            ),
                            ListTile(
                              title: Text('Legal & About'),
                              trailing: Icon(Icons.mobile_screen_share,color: Colors.red,),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => LegalAboutPage())),
                            ),
                            ListTile(
                              title: Text('About Us'),
                              trailing: Icon(Icons.info_outline_rounded,color: Colors.red,),
                              onTap: () {},
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Account',
                                style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Change Password'),
                              trailing: Icon(Icons.dangerous,color: Colors.red,),

                              //   leading:Image.asset('assets/icons/change_pass.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangePasswordPage())),
                            ),
                            ListTile(
                              title: Text('Sign out'),
                              trailing: Icon(Icons.logout,color: Colors.red,),
                              //leading: Image.asset('assets/icons/sign_out.png'),
                              onTap: () => FirebaseAuth.instance.signOut(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}