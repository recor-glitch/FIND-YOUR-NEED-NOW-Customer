import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          primary: true,
          title: Text(doc.get('category'), style: TextStyle(fontSize: 20))),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: doc.get('subcategory').length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/productlisting',
                          arguments: doc.get('Sub_Category')[
                              doc.get('subcategory')[index]['Name']]); 
                    },
                    title: Text(doc.get('subcategory')[index]['Name']),
                  ),
                );
              }),
          Card(
            child: ListTile(
              onTap: () {},
              title: Text('View All'),
            ),
          )
        ]),
      )),
    );
  }
}
