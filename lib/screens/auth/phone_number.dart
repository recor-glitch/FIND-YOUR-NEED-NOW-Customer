import 'package:demoecommerce/app_properties.dart';
import 'package:demoecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneNumber extends StatefulWidget {
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController phoneNumber = TextEditingController();

  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;
  String? error;

  Widget prefix() {
    return Container(
        key: prefixKey,
        margin: EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black, width: 0.5))),
        child: CountryCodePicker(
          initialSelection: 'IN',
          favorite: ['+91', 'IN'],
        ));
  }

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
      'OTP Verification',
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
          'Enter your registered mobile number to get the OTP',
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
          if (phoneNumber.text.isNotEmpty && phoneNumber.text.length == 10) {
            Navigator.pushNamed(context, '/otp', arguments: phoneNumber.text);
          } else {
            setState(() {
              error = kInvalidNumber;
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Send OTP",
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
                prefix(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          error = null;
                        });
                      },
                      decoration: InputDecoration(errorText: error),
                      controller: phoneNumber,
                      style: TextStyle(fontSize: 16.0),
                      keyboardType: TextInputType.phone,
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

    Widget resendAgainText = Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Didn't receive the OPT? ",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14.0,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Resend again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ));
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
                      resendAgainText
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
