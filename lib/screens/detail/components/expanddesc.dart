import 'package:flutter/material.dart';

class ExpandedDesc extends StatefulWidget {
  const ExpandedDesc({Key? key, required this.desc}) : super(key: key);
  final String desc;

  @override
  State<ExpandedDesc> createState() => _ExpandedDescState();
}

class _ExpandedDescState extends State<ExpandedDesc> {
  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isclicked? Text(widget.desc) : Text(widget.desc, maxLines: 3, overflow: TextOverflow.ellipsis),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      isclicked = !isclicked;
                    });
                  },
                  child: isclicked
                      ? Text(
                          'see less',
                          style: TextStyle(color: Colors.blue),
                        )
                      : Text(
                          'see more',
                          style: TextStyle(color: Colors.grey),
                        ))
            ],
          ),
        )
      ],
    );
  }
}
