import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();

  String roundedBtc;
  String roundedEth;
  String roundedLtc;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  Future<void> updateUI() async {
    roundedLtc = '?';
    roundedBtc = '?';
    roundedEth = '?';
    
    var btcRateData = await coinData.getExchangeRate(selectedCurrency, 'BTC');
    var ethRateData = await coinData.getExchangeRate(selectedCurrency, 'ETH');
    var ltcRateData = await coinData.getExchangeRate(selectedCurrency, 'LTC');

    if (btcRateData != null && ltcRateData != null && ethRateData != null) {
      setState(() {
        double btcRate = btcRateData['rate'];
        roundedBtc = btcRate.toInt().toString();
        double ltcRate = ltcRateData['rate'];
        roundedLtc = ltcRate.toInt().toString();
        double ethRate = ethRateData['rate'];
        roundedEth = ethRate.toInt().toString();
      });
      return;
    }

  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            updateUI();
            print(selectedCurrency);
          });
        });
  }

  CupertinoPicker getIosPicker() {
    List<Text> cupertinoItems = [];

    for (String currency in currenciesList) {
      var newItem =
          Text(currency, style: TextStyle(color: Colors.white, fontSize: 17));
      cupertinoItems.add(newItem);
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 20.0,
        onSelectedItemChanged: (int value) {
          setState(() {
            selectedCurrency = currenciesList[value];
            updateUI();
          });
        },
        children: cupertinoItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1 BTC = $roundedBtc $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1 ETH = $roundedEth $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1 LTC = $roundedLtc $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIosPicker() : getDropDownButton(),
            ),
          ]),
    );
  }
}
