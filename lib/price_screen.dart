import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:bitcoin_ticker_flutter/utils%20/NetworkHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  int conversionPrice = 0;
  Map<String, dynamic> coinPrices = {};

  @override
  void initState() {
    super.initState();
    getConversionPrice(selectedCurrency);
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(value: currency, child: Text(currency));
      dropDownItems.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value ?? '';
        });
        getConversionPrice(selectedCurrency);
      },
    );
  }

  void getConversionPrice(String selectedCurrency) async {
    String url =
        'https://api.coingecko.com/api/v3/simple/price?vs_currencies=$selectedCurrency&ids=${coinIds.values.join(',')}';
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();
    print('response: $data');
    setState(() {
      coinPrices = data;
    });
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      pickerItems.add(item);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getConversionPrice(selectedCurrency);
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: coinIds.map((coin) {
              return cryptoCard(coin);
            }).toList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }

  Widget cryptoCard(String coin) {
    print('coin: $coin');
    print('list: $coinPrices');
    String coinId = coinIds[symbol];
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: Text(
            '1 ${coin.toUpperCase()} = '
            '${coinPrices[coin]?[selectedCurrency.toLowerCase()] ?? '?'} '
            '$selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
