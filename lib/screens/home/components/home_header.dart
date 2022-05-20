import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/screens/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {Key? key, required this.isback, required this.maincontext, this.press})
      : super(key: key);
  final bool isback;
  final BuildContext maincontext;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isback
            ? IconButton(
                onPressed: press != null
                    ? press
                    : () {
                        Navigator.of(maincontext).pop();
                        BlocProvider.of<CategoryCubit>(context);
                      },
                icon: Icon(Icons.arrow_back_ios))
            : Container(),
        Expanded(
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                backgroundColor: Colors.transparent),
            title: Text('Fyn Now'),
          ),
        ),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.search, color: Colors.grey)),
        IconBtnWithCounter(svgSrc: "assets/icons/Cart Icon.svg", press: () {}),
        IconBtnWithCounter(
          svgSrc: "assets/icons/Bell.svg",
          numOfitem: 3,
          press: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NotificationsPage())),
        ),
      ],
    );
  }
}
