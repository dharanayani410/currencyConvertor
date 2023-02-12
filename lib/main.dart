import 'package:currencyconvertor/helpers/api_helper.dart';
import 'package:currencyconvertor/modal/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic dropDownVal = 'USD';
  dynamic dropDownVal1 = 'INR';
  var dropDown = ['USD', 'INR', 'AUD', 'CAD'];
  var dropDown1 = ['INR', 'USD', 'AUD', 'CAD'];
  dynamic convertedAmount = 0;
  double converterAmount = 0;
  double convertToAmount = 0;
  dynamic amount = 0;
  String sign = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: APIHelper.apiHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Currency? data = snapshot.data;
            return (data != null)
                ? Center(
                    child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.brown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Currency Convertor",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            amount = int.parse(val);
                            print(amount);
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Amount',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixText: "\$"),
                        ),
                        DropdownButton(
                            value: dropDownVal,
                            dropdownColor: Colors.brown,
                            iconSize: 30,
                            iconEnabledColor: Colors.white,
                            items: dropDown.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                dropDownVal = val;
                                //   if (dropDownVal == "INR") {
                                //     convertToAmount = amount * data.inr;
                                //   } else if (dropDownVal == "USD") {
                                //     convertToAmount = amount * data.usd;
                                //   } else if (dropDownVal == "AUD") {
                                //     convertToAmount = amount * data.aud;
                                //   } else if (dropDownVal == "CAD") {
                                //     convertToAmount = amount * data.cad;
                                //   }
                                //   print("covert ${convertToAmount}");
                              });
                            }),
                        const Text(
                          "Convert To",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: Colors.white,
                        ),
                        DropdownButton(
                            value: dropDownVal1,
                            dropdownColor: Colors.brown,
                            iconSize: 30,
                            iconEnabledColor: Colors.white,
                            items: dropDown1.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                dropDownVal1 = val;
                                if (dropDownVal1 == "USD") {
                                  converterAmount = data.usd;
                                  sign = "\$";
                                } else if (dropDownVal1 == "AUD") {
                                  converterAmount = data.aud;
                                  sign = "\$";
                                } else if (dropDownVal1 == "CAD") {
                                  converterAmount = data.cad;
                                  sign = "\$";
                                } else if (dropDownVal1 == "INR") {
                                  converterAmount = data.inr;
                                  sign = "₹";
                                }
                              });
                              print(dropDownVal1);
                              print(converterAmount);
                            }),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              convertedAmount = amount * converterAmount;
                              print(convertedAmount);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 200,
                            color: Colors.white,
                            child: const Text(
                              "Converter",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "$dropDownVal Converted to $dropDownVal1 $sign $convertedAmount",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ))
                : const Center(
                    child: Text(
                      "No Data...",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}
