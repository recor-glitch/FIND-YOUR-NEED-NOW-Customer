import 'package:demoecommerce/Components/customsnackbar.dart';
import 'package:demoecommerce/Components/social_card.dart';
import 'package:demoecommerce/Infrastructure/social_signup.dart';
import 'package:demoecommerce/Infrastructure/userfcade.dart';
import 'package:demoecommerce/app_properties.dart';
import 'package:demoecommerce/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Glad To Meet You',
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

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

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
                                Navigator.pushReplacementNamed(
                                    context, '/intro');
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                title,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                registerForm(),
                Spacer(flex: 2),
                Padding(
                    padding: EdgeInsets.only(bottom: 20), child: socialRegister)
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class registerForm extends StatefulWidget {
  const registerForm({Key? key}) : super(key: key);

  @override
  State<registerForm> createState() => _registerFormState();
}

class _registerFormState extends State<registerForm> {
  final _formkey = GlobalKey<FormState>();

  bool errorvisible = false;
  String? email, pass, cmfpass;
  String? emailerror, passerror, cmfpasserror;
  bool isconfirmpassvisible = true;
  bool ispassvisible = true;
  UserFcade fcade = UserFcade();
  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 20,
      child: InkWell(
        onTap: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            setState(() {
              isclicked = true;
            });
            if (pass == cmfpass) {
              fcade.CreateUserWithEmailandPass(email!, pass!).then((value) {
                if (value == 'success') {
                  Navigator.pushReplacementNamed(context, '/phn');
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
            } else {
              setState(() {
                passerror = kMatchPassError;
                cmfpasserror = kMatchPassError;
                isclicked = false;
              });
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: isclicked
                  ? CircularProgressIndicator()
                  : Text("Register",
                      style: const TextStyle(
                          color: const Color(0xfffefefe),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: mainButton,
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
      height: 350,
      child: Stack(
        children: <Widget>[
          Container(
            height: 280,
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
                          passerror = null;
                          emailerror = null;
                          cmfpasserror = null;
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
                        setState(() {
                          passerror = null;
                          emailerror = null;
                          cmfpasserror = null;
                        });
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      onSaved: (newValue) => cmfpass = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            cmfpasserror = kPassNullError;
                          });
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          passerror = null;
                          emailerror = null;
                          cmfpasserror = null;
                        });
                      },
                      style: TextStyle(fontSize: 16.0),
                      obscureText: isconfirmpassvisible,
                      decoration: InputDecoration(
                          labelText: "Comfirm Password",
                          hintText: "********",
                          errorText: cmfpasserror,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: InkWell(
                              onTap: () {
                                if (isconfirmpassvisible) {
                                  setState(() {
                                    isconfirmpassvisible = false;
                                  });
                                } else {
                                  setState(() {
                                    isconfirmpassvisible = true;
                                  });
                                }
                              },
                              child: isconfirmpassvisible
                                  ? Icon(Icons.lock)
                                  : Icon(Icons.lock_open))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          registerButton,
        ],
      ),
    );
  }
}
