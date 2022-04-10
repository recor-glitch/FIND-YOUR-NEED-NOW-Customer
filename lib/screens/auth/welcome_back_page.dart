import 'package:demoecommerce/Components/customsnackbar.dart';
import 'package:demoecommerce/Components/social_card.dart';
import 'package:demoecommerce/Infrastructure/social_signup.dart';
import 'package:demoecommerce/Infrastructure/userfcade.dart';
import 'package:demoecommerce/app_properties.dart';
import 'package:demoecommerce/constants.dart';
import 'package:flutter/material.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  @override
  Widget build(BuildContext context) {
    Widget welcomeBack = Text(
      'Welcome Back,',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            'You can sign in with',
            style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialCard(
              icon: "https://www.svgrepo.com/show/355037/google.svg",
              press: () {
                GetGoogleCredential().then((value) {
                  if (value.isLeft) {
                    UserFcade google_facade = UserFcade();
                    google_facade.SigninWithCredential(value.left)
                        .then((credentialvalue) {
                      if (credentialvalue == 'success') {
                        Navigator.pushReplacementNamed(context, '/intro');
                      } else {
                        CustomSnackbar(credentialvalue, context);
                      }
                    });
                  } else {
                    CustomSnackbar(value.right, context);
                  }
                });
              },
            ),
            SocialCard(
              icon: "https://www.svgrepo.com/show/183607/facebook.svg",
              press: () {
                GetFacebookCredential().then((value) {
                  if (value.isLeft) {
                    UserFcade facebook_fcade = UserFcade();
                    facebook_fcade.SigninWithCredential(value.left)
                        .then((credentialvalue) {
                      if (credentialvalue == 'success') {
                        Navigator.pushReplacementNamed(context, '/intro');
                      } else {
                        CustomSnackbar(credentialvalue, context);
                      }
                    });
                  } else {
                    CustomSnackbar(value.right, context);
                  }
                });
              },
            ),
          ],
        )
      ],
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Login to your account using\nEmail and Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot your password? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Reset password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                welcomeBack,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                loginForm(),
                Spacer(flex: 2),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: socialRegister),
                forgotPassword
              ],
            ),
          )
        ],
      ),
    );
  }
}

class loginForm extends StatefulWidget {
  const loginForm({Key? key}) : super(key: key);

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  final _formkey = GlobalKey<FormState>();
  String? email, pass;
  bool ispassvisible = true;
  String? emailerror, passerror;
  UserFcade fcade = UserFcade();
  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 20,
      child: InkWell(
        onTap: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            setState(() {
              isclicked = true;
            });
            fcade.LoginWithEmailandPassword(email!, pass!).then((value) {
              if (value == 'success') {
                Navigator.pushReplacementNamed(context, '/intro');
              } else {
                if (value.contains('email')) {
                  setState(() {
                    emailerror = value;
                  });
                } else if (value.contains('password')) {
                  setState(() {
                    passerror = value;
                  });
                } else {
                  CustomSnackbar(value, context);
                }
                setState(() {
                  isclicked = false;
                });
              }
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: isclicked
                  ? CircularProgressIndicator()
                  : Text("Log In",
                      style: const TextStyle(
                          color: const Color(0xfffefefe),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(236, 60, 3, 1),
                    Color.fromRGBO(234, 60, 3, 1),
                    Color.fromRGBO(216, 78, 16, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    return Container(
      height: 260,
      child: Stack(
        children: <Widget>[
          Container(
            height: 185,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      onSaved: (newValue) => email = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            emailerror = kEmailNullError;
                          });
                        } else if (!emailValidatorRegExp.hasMatch(value)) {
                          setState(() {
                            emailerror = kInvalidEmailError;
                          });
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          emailerror = null;
                          passerror = null;
                        });
                      },
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "example@gmail.com",
                          errorText: emailerror,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.email)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        onSaved: (newValue) => pass = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              passerror = kPassNullError;
                            });
                          } else if (value.length < 6) {
                            setState(() {
                              passerror = kShortPassError;
                            });
                          }
                        },
                        onChanged: (value) {
                          emailerror = null;
                          passerror = null;
                        },
                        style: TextStyle(fontSize: 16.0),
                        obscureText: ispassvisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "********",
                            errorText: passerror,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: InkWell(
                                onTap: () {
                                  if (ispassvisible) {
                                    setState(() {
                                      ispassvisible = false;
                                    });
                                  } else {
                                    setState(() {
                                      ispassvisible = true;
                                    });
                                  }
                                },
                                child: ispassvisible
                                    ? Icon(Icons.lock)
                                    : Icon(Icons.lock_open))),
                      )),
                ],
              ),
            ),
          ),
          loginButton,
          Positioned(
            left: MediaQuery.of(context).size.width / 4,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don’t have an account?",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    fontSize: 14.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
