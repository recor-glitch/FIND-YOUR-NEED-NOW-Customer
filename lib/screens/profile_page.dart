import 'package:demoecommerce/BusinessLogic/theme/cubit/theme_cubit.dart';
import 'package:demoecommerce/screens/faq_page.dart';
import 'package:demoecommerce/screens/payment/payment_page.dart';
import 'package:demoecommerce/screens/settings/settings_page.dart';
import 'package:demoecommerce/screens/tracking_page.dart';
import 'package:demoecommerce/screens/wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../BusinessLogic/profile/cubit/profile_cubit.dart';


enum photoprovider { camera, gallery }

class ProfilePage extends StatelessWidget {
  static late bool isdark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return state is ProfileLoaded
                              ? SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                        image: NetworkImage(state.img),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 100,
                                  height: 100,
                                )
                              : state is ProfileLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Center(child: CircularProgressIndicator());
                        },
                      ),
                      InkWell(
                          child: Align(
                              child: CircleAvatar(
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.white),
                                  backgroundColor: Colors.black26,
                                  maxRadius: 18),
                              alignment: Alignment.bottomRight),
                          onTap: () async {
                            return showModalBottomSheet(
                                builder: (context) {
                                  return BlocBuilder<ThemeCubit, ThemeState>(
                                    builder: (context, theme_state) {
                                      return Container(
                                        color: theme_state is ThemeLoaded
                                            ? theme_state.theme ==
                                                    ThemeData.dark()
                                                ? Colors.grey.shade900
                                                : Colors.white
                                            : null,
                                        child: Wrap(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                BlocProvider.of<ProfileCubit>(
                                                        context)
                                                    .RemovePhoto();
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.delete),
                                                title: Text(
                                                    'Remove Profile Photo'),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                BlocProvider.of<ProfileCubit>(
                                                        context)
                                                    .get_image(
                                                        photoprovider.gallery);
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.photo),
                                                title:
                                                    Text('Choose from Gallery'),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                BlocProvider.of<ProfileCubit>(
                                                        context)
                                                    .get_image(
                                                        photoprovider.camera);
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title: Text('Take a Photo'),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                context: context);
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rose Helbert',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    border: Border(),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/wallet.png'),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => WalletPage())),
                            ),
                            Text(
                              'Wallet',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/truck.png'),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => TrackingPage())),
                            ),
                            Text(
                              'Shipped',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/card.png'),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => PaymentPage())),
                            ),
                            Text(
                              'Payment',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/contact_us.png'),
                              onPressed: () {},
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text('Privacy and logout'),
                  leading: Icon(Icons.settings, size: 30),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Theme'),
                  subtitle: Text('Customize your theme'),
                  leading: Icon(Icons.dashboard_customize, size: 30),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () async {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomThemeChoose();
                        });
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Icon(Icons.help, size: 30),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Icon(Icons.question_answer, size: 30),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomThemeChoose extends StatefulWidget {
  const CustomThemeChoose({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomThemeChoose> createState() => _CustomThemeChooseState();
}

class _CustomThemeChooseState extends State<CustomThemeChoose> {
  late int id;

  void RadioActiveCheck() {
    try {
      var box = Hive.box('settings');
      id = box.get('theme');
    } catch (exception) {
      var brightness = SchedulerBinding.instance!.window.platformBrightness;
      if (brightness == Brightness.dark) {
        id = 1;
      } else {
        id = 2;
      }
    }
  }

  @override
  void initState() {
    RadioActiveCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Choose theme'),
      children: [
        ListTile(
          title: Text('Dark'),
          leading: Radio(
              value: 1,
              groupValue: id,
              onChanged: (int? value) {
                setState(() {
                  id = value!;
                });
              }),
        ),
        ListTile(
          title: Text('Light'),
          leading: Radio(
              value: 2,
              groupValue: id,
              onChanged: (int? value) {
                setState(() {
                  id = value!;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('cancel')),
            TextButton(
                onPressed: () async {
                  BlocProvider.of<ThemeCubit>(context).SetTheme(id);
                  Navigator.pop(context);
                },
                child: Text('ok'))
          ],
        )
      ],
    );
  }
}
