import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.tabcontroller);
  final tabcontroller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {
    BlocProvider.of<CategoryCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: HomeHeader(isback: false, maincontext: context),
          ),
          backgroundColor: Colors.grey.shade200,
          body: Body(widget.tabcontroller)),
    );
  }
}
