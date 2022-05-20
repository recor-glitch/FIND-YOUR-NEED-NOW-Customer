import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/staggered_category_card.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Category> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment(-1, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Category List',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, size: 30)),
                onChanged: (value) {},
              ),
            ),
            Flexible(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (BuildContext context, state) {
                if (state is CategoryLoaded) {
                  return ListView.builder(
                      itemCount: state.snap.size,
                      itemBuilder: (BuildContext context, int index) {
                        return StaggeredCardCard(
                            categoryName:
                                state.snap.docs[index].get('category'),
                            assetPath: state.snap.docs[index].get('img'));
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
