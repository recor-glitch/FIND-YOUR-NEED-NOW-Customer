import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoecommerce/BusinessLogic/connectioncheck/cubit/connectioncheck_cubit.dart';
import 'package:demoecommerce/screens/cart/cart.dart';
import 'package:demoecommerce/screens/category/category_list_page.dart';
import 'package:demoecommerce/screens/detail/productdetail.dart';
import 'package:demoecommerce/screens/home/home_screen.dart';
import 'package:demoecommerce/screens/listing/product_listing.dart';
import 'package:demoecommerce/screens/nointernet.dart';
import 'package:demoecommerce/screens/profile_page.dart';
import 'package:demoecommerce/sub%20category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/custom_bottom_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late TabController bottomTabController;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    bottomTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectioncheckCubit, ConnectioncheckState>(
        builder: (context, connection_state) {
      if (connection_state is CheckDisconnected) {
        return NoInternet();
      } else {
        return Scaffold(
          bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
          body: TabBarView(
            controller: bottomTabController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Navigator(
                key: navigatorKey,
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case '/':
                      return MaterialPageRoute(
                          builder: (_) => HomeScreen(bottomTabController));
                    case '/subcategory':
                      var doc = settings.arguments as DocumentSnapshot;
                      return MaterialPageRoute(
                          builder: (_) => SubCategory(doc: doc));
                    case '/productlisting':
                      var product = settings.arguments as List;
                      return MaterialPageRoute(
                          builder: (_) => ProductListing(products: product));
                    case '/productdetail':
                      var product = settings.arguments as Map;
                      return MaterialPageRoute(builder: (_) => ProductDetail(product: product));
                    default:
                      return MaterialPageRoute(
                          builder: (_) => HomeScreen(bottomTabController));
                  }
                },
              ),
              CategoryListPage(),
              Cart(controller: bottomTabController),
              ProfilePage()
            ],
          ),
        );
      }
    });
  }
}
