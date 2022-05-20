import 'dart:math';
import 'package:demoecommerce/models/productmodel.dart';
import 'package:demoecommerce/screens/cart/components/customtextfield.dart';
import 'package:demoecommerce/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({Key? key, required this.products}) : super(key: key);
  final List<CartProductModel> products;
  TextEditingController controller = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {

    Widget EditDeliveryAddress(BuildContext modalcontext) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Change Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(modalcontext);
                  },
                  icon: Icon(Icons.close))
            ]),
            Divider(
                color: Colors.grey.shade200,
                indent: 0,
                endIndent: 0,
                thickness: 5),
            CustomPincodeField(
                controller: controller, modalcontext: modalcontext),
            Container(
                width: MediaQuery.of(modalcontext).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.grey.shade200,
                child: Center(
                    child: Text('OR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey)))),
            InkWell(
              onTap: () {},
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(modalcontext).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text('ADD NEW ADDRESS',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(226, 51, 72, 1))))),
            )
          ],
        ),
      );
    }

    Widget DeliveryAddress() {
      return Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(text: 'Deliver to:', children: [
                          TextSpan(text: 'Rishi Sarmah'),
                          TextSpan(text: '781020')
                        ])),
                        Text('Geetanagar, Panipath, house no. 89')
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          return showModalBottomSheet(
                              context: context,
                              builder: (BuildContext modalcontext) {
                                return EditDeliveryAddress(modalcontext);
                              });
                        },
                        child: Text('CHANGE',style: TextStyle(color: Color.fromRGBO(226, 51, 72, 1))))
                  ]),
            ),
          ),
        ),
      );
    }

    Widget CustomCircle(Function() press, bool isclicked, dynamic size) {
      return InkWell(
        onTap: press,
        child: Container(
            margin: EdgeInsets.only(right: 15),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              border: isclicked
                  ? Border.all(
                      color: Color.fromARGB(255, 92, 216, 232), width: 3)
                  : Border.all(color: Colors.grey.shade300, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(child: Text(size.toString()))),
      );
    }

    Widget CustomDropDown(BuildContext context, String attribute, int index) {
      return Container(
        child: Row(children: [
          Text.rich(TextSpan(text: attribute, children: [
            TextSpan(
                text: attribute == 'Size' ? products[index].sizes![0] : '1')
          ])),
          IconButton(
              onPressed: () async {
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext modalcontext) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Wrap(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      attribute == 'Size'
                                          ? 'Select Size'
                                          : 'Select Quantity',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(modalcontext);
                                      },
                                      icon: Icon(Icons.close))
                                ]),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: attribute == 'Sizes'
                                    ? products[index].sizes!.length
                                    : 10,
                                itemBuilder: (BuildContext context, int l_index) {
                                  return CustomCircle(
                                      () {},
                                      true,
                                      attribute == 'Sizes'
                                          ? products[index].sizes![0]
                                          : l_index + 1);
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('DONE'),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(226, 51, 72, 1)),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(Icons.arrow_drop_down))
        ]),
      );
    }

    Widget CustomProductCard(int index) {
      return Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: InkWell(
                    onTap: (() {}),
                    child: Image.network(products[index].img[0]))),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(products[index].desc,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text.rich(TextSpan(
                        text: 'Sold by: ',
                        children: [TextSpan(text: 'Rajo Store')])),
                    Row(children: [
                      products[index].sizes!.isNotEmpty
                          ? CustomDropDown(
                              context,
                              'Size:',
                              products[index].size,
                            )
                          : Container(),
                      CustomDropDown(
                          context, 'Quantity:', products[index].quantity)
                    ]),
                    Text('₹ ${products[index].price}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('In stock', style: TextStyle(color: Colors.green)),
                    Text(products[index].name)
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.close))
            ],
          ),
        ),
      );
    }

    Widget ProductList() {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomProductCard(index);
        },
      );
    }

    Widget CustomPriceRow(String detail, String value, bool isbold) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(detail,
                style: TextStyle(fontWeight: isbold ? FontWeight.bold : null)),
            Text('₹ $value',
                style: TextStyle(fontWeight: isbold ? FontWeight.bold : null))
          ],
        ),
      );
    }

    Widget PriceDetails(List<CartProductModel> products) {
      double totalprice = 0;
      double discount = 800;
      double conveince_charge = 25;
      products.forEach(
        (element) => totalprice = double.parse(element.price) + totalprice,
      );
      return Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text.rich(TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  text: 'PRICE DETAILS ',
                  children: [TextSpan(text: '(${products.length} items)')])),
              Divider(
                  color: Colors.grey.shade200,
                  indent: 0,
                  endIndent: 0,
                  thickness: 2),
              Column(
                children: [
                  CustomPriceRow('Total MRP', totalprice.toString(), false),
                  CustomPriceRow('Discount on MRP', discount.toString(), false),
                  CustomPriceRow(
                      'Convenience Fee', conveince_charge.toString(), false),
                  Divider(
                      color: Colors.grey.shade200,
                      indent: 0,
                      endIndent: 0,
                      thickness: 2),
                  CustomPriceRow(
                      'Total Amount',
                      '${totalprice - discount + conveince_charge}'.toString(),
                      true)
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget ContinueButton() {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.98,
        child: ElevatedButton(
            onPressed: () {},
            child: Text('CONTINUE'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(226, 51, 72, 1),
            )),
      );
    }

    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        DeliveryAddress(),
        ProductList(),
        // YouMayLike(),
        PriceDetails(products),
        ContinueButton()
      ]),
    );
  }
}
