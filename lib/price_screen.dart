import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(value: currency, child: Text(currency));
      dropDownItems.add(item);
    }
    return dropDownItems;
  }

  List<Widget> getPickerItems() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      pickerItems.add(item);
    }
    return pickerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex) {
                selectedCurrency = currenciesList[selectedIndex];
              },
              children: getPickerItems(),
            ),
          ),
        ],
      ),
    );
  }
}

/*DropdownButton<String>(
              value: selectedCurrency,
              items: getDropdownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value ?? '';
                });
              },
            )*/
