import 'package:demoecommerce/Components/customsnackbar.dart';
import 'package:demoecommerce/Infrastructure/userfcade.dart';
import 'package:demoecommerce/app_properties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ConfirmOtpPage extends StatefulWidget {
  ConfirmOtpPage({required this.phn});
  final phn;
  @override
  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  Widget otpBox(TextEditingController otpController) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: SizedBox(
          width: 9,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.zero),
              style: TextStyle(fontSize: 16.0),
              keyboardType: TextInputType.phone,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Confirm your OTP',
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
          'Please wait, we are confirming your OTP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Row buildTimer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Resend again after ",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          TweenAnimationBuilder(
            tween: Tween(begin: 60.0, end: 0.0),
            duration: Duration(seconds: 60),
            builder: (_, dynamic value, child) => Text(
              "00:${value.toInt()}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      );
    }

    return Container(
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
                    Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: Center(
                        child: OtpForm(phn: widget.phn),
                      ),
                    ),
                    Spacer(flex: 2),
                    buildTimer(),
                    Spacer()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key, required this.phn}) : super(key: key);
  final phn;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  late String verificationcode;
  int? _resendtoken;
  UserFcade fcade = UserFcade();
  String? error;

  @override
  void initState() {
    verificationcode = '';
    VerifyOtp();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> VerifyOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: _resendtoken,
        phoneNumber: '+91 ${widget.phn}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          fcade.LinkWithCredential(credential).then((value) {
            if (value == 'success') {
              fcade.StoreUserdata(widget.phn).then((storevalue) {
                if (storevalue == 'success') {
                  Navigator.pushReplacementNamed(context, '/intro');
                } else {
                  CustomSnackbar(storevalue, context);
                }
              });
            } else {
              CustomSnackbar(value, context);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          CustomSnackbar(e.code.replaceAll('-', ' '), context);
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationcode = verificationId;
          _resendtoken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationcode = verificationId;
        },
        timeout: const Duration(seconds: 60));
  }

  AuthCredential GeneratePhnCredential() {
    return PhoneAuthProvider.credential(
        verificationId: verificationcode, smsCode: controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
          fontSize: 20, color: Color.fromRGBO(70, 69, 66, 1)),
      decoration: BoxDecoration(
        color: Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Column(
      children: [
        Pinput(
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          length: 6,
          errorText: error,
          onChanged: (value) {
            setState(() {
              error = null;
            });
          },
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          separator: SizedBox(width: 16),
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                  offset: Offset(0, 3),
                  blurRadius: 16,
                )
              ],
            ),
          ),
          showCursor: true,
          cursor: cursor,
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Center(
            child: InkWell(
              onTap: () {
                if (controller.text.length == 6 && verificationcode != '') {
                  AuthCredential credential = GeneratePhnCredential();
                  fcade.LinkWithCredential(credential).then((value) {
                    if (value == 'success') {
                      fcade.StoreUserdata(widget.phn).then((storevalue) {
                        if (storevalue == 'success') {
                          Navigator.pushReplacementNamed(context, '/intro');
                        } else {
                          CustomSnackbar(storevalue, context);
                        }
                      });
                    } else {
                      CustomSnackbar(value, context);
                    }
                  });
                } else {
                  CustomSnackbar('Invalid Pin', context);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 80,
                child: Center(
                    child: new Text("Verify",
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
          ),
        ),
      ],
    );
  }
}
