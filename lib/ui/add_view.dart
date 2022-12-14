import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = <String>['Bitcoin', 'Ethereum', 'Tether'];
  var dropVal = 'Bitcoin';
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          DropdownButton(
            value: dropVal,
            onChanged: (String? value) {

              setState(() => dropVal = value.toString());
            },
            items: coins.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: "Coin Amount",
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.white),
            child: MaterialButton(
              onPressed: () async {
                print('add coin');
                 addCoin(dropVal, _amountController.text,true);
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
