import 'package:flutter/material.dart';

class CustomPincodeField extends StatefulWidget {
  const CustomPincodeField(
      {Key? key, required this.controller, required this.modalcontext})
      : super(key: key);
  final TextEditingController controller;
  final BuildContext modalcontext;

  @override
  State<CustomPincodeField> createState() => _CustomPincodeFieldState();
}

class _CustomPincodeFieldState extends State<CustomPincodeField> {
  List pincodes = [
    '781001',
    '781002',
    '781003',
    '781004',
    '781005',
    '781006',
    '781007',
    '781008',
    '781009',
    '781010',
    '781011',
    '781012',
    '781013',
    '781014',
    '781015',
    '781016',
    '781017',
    '781018',
    '781019',
    '781020',
    '781021',
    '781022',
    '781023',
    '781024',
    '781025',
    '781026',
    '781027',
    '781028',
    '781029',
    '781030',
    '781031',
    '781032',
    '781033',
    '781034',
    '781035',
    '781036',
    '781037',
    '781038',
    '781039',
    '781040',
    '781128',
    '781171'
  ];
  String? error;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      onChanged: (value) {
        setState(() {
          error = null;
        });
      },
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        errorText: error,
        errorMaxLines: 1,
          suffixIcon: TextButton(
              child: Text('CHECK', style: TextStyle(color: Color.fromRGBO(226, 51, 72, 1))),
              onPressed: () {
                if (widget.controller.text != '') {
                  if (pincodes.contains(widget.controller.text)) {
                    Navigator.pop(widget.modalcontext);
                  } else {
                    setState(() {
                      error = 'Our Service is not available in that area yet.';
                    });
                  }
                }
              }),
          hintText: 'Enter Pincode',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
