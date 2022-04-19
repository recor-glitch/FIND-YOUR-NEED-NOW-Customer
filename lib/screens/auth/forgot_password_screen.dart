import 'package:demoecommerce/Components/customsnackbar.dart';
import 'package:demoecommerce/Infrastructure/userfcade.dart';
import 'package:demoecommerce/app_properties.dart';
import 'package:demoecommerce/constants.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formkey = GlobalKey<FormState>();

  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;
  String? error, email;

  @override
  Widget build(BuildContext context) {
    Widget background = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
      foregroundDecoration: BoxDecoration(color: transparentYellow),
    );

    Widget title = Text(
      'Reset Password',
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
          "Enter your registered email address and we'll send you a link to reset your password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget sendButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();

            UserFcade fcade = UserFcade();
            fcade.ResetPassword(email!).then((value) {
              if (value == 'success') {
                Navigator.pop(context);
              } else {
                CustomSnackbar(value, context);
              }
            });
          } else {
            CustomSnackbar(error!, context);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Reset",
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

    Widget phoneForm = Container(
      height: 210,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0, bottom: 30),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Form(
                      key: _formkey,
                      child: TextFormField(
                        onSaved: (newValue) => email = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            error = kEmailNullError;
                          } else if (!emailValidatorRegExp.hasMatch(value)) {
                            error = kInvalidEmailError;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          error = null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'example@gmail.com',
                        ),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          sendButton,
        ],
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(color: transparentYellow),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(flex: 3),
                      title,
                      Spacer(),
                      subTitle,
                      Spacer(flex: 2),
                      phoneForm,
                      Spacer(flex: 2),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
