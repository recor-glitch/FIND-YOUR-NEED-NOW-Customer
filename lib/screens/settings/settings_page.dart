import 'package:demoecommerce/Infrastructure/userfcade.dart';
import 'package:demoecommerce/app_properties.dart';
import 'package:demoecommerce/custom_background.dart';
import 'package:demoecommerce/screens/settings/change_country.dart';
import 'package:demoecommerce/screens/settings/legal_about_page.dart';
import 'package:demoecommerce/screens/settings/notifications_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'change_language_page.dart';

class SettingsPage extends StatelessWidget {
  UserFcade fcade = UserFcade();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Language A / का'),
                              leading: Image.asset('assets/icons/language.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeLanguagePage())),
                            ),
                            ListTile(
                              title: Text('Change Country'),
                              leading: Image.asset('assets/icons/country.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeCountryPage())),
                            ),
                            ListTile(
                              title: Text('Notifications'),
                              leading:
                                  Image.asset('assets/icons/notifications.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          NotificationSettingsPage())),
                            ),
                            ListTile(
                              title: Text('Legal & About'),
                              leading: Image.asset('assets/icons/legal.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => LegalAboutPage())),
                            ),
                            ListTile(
                              title: Text('About Us'),
                              leading: Image.asset('assets/icons/about_us.png'),
                              onTap: () {},
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Change Password'),
                              leading:
                                  Image.asset('assets/icons/change_pass.png'),
                              onTap: () {
                                Navigator.pushNamed(context, '/reset');
                              },
                            ),
                            ListTile(
                              title: Text('Sign out'),
                              leading: Image.asset('assets/icons/sign_out.png'),
                              onTap: () {
                                try {
                                  fcade.SignOut().then((value) {
                                    Navigator.popAndPushNamed(context, '/');
                                  });
                                } catch (e) {}
                              },
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
