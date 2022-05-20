import 'package:demoecommerce/BusinessLogic/cubit/quantity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Quantity extends StatelessWidget {
  const Quantity({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<QuantityCubit, QuantityState>(
          builder: (context, countstate) {
            if (countstate is QuantityInitial) {
              return Row(
                children: [
                  Text('quantity:', style: TextStyle(fontSize: 20)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<QuantityCubit>(context)
                                .DecrementCount(countstate.count);
                          },
                          icon: Icon(Icons.remove))),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(countstate.count.toString()),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<QuantityCubit>(context)
                                .IncrementCount(countstate.count);
                          },
                          icon: Icon(Icons.add)))
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
  }
}