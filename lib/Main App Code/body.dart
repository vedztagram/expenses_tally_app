import 'package:flutter/material.dart';

import '../util/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  // ignore: non_constant_identifier_names
  late int TipPercentage = 0;

  // ignore: non_constant_identifier_names
  int Person_Number = 1;
  double billAmount = 0.0;
  Color neonGreen = HexColor("#39FF14");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.1),
        alignment: Alignment.center,
        color: Colors.white54,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: neonGreen.withOpacity(0.3),
                borderRadius: BorderRadius.circular(14.5),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        "Cost Per Person:",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      "\$ ${calculateCostPerPerson(calculateTotalTip(
                          billAmount, Person_Number, TipPercentage), billAmount,
                          Person_Number)}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.5),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      prefixText: "Enter Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        billAmount = double.parse(value);
                      } catch (exception) {
                        billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Split",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  if (Person_Number > 1) {
                                    Person_Number--;
                                  } else {
                                    //do nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: neonGreen.withOpacity(0.25),
                                ),
                                child: Center(
                                  child: Text("-",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.90,
                                      )),
                                ),
                              )),
                          Text(
                            "$Person_Number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Person_Number++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: neonGreen.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.00,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Tip",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$ ${calculateTotalTip(
                            billAmount, Person_Number, TipPercentage)}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$TipPercentage %",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: neonGreen,
                          inactiveColor: Colors.grey,
                          divisions: 20,
                          value: TipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              TipPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateCostPerPerson(double totalTip, double billAmount, int splitBy) {
    var CostPerPerson = (totalTip + billAmount) / splitBy;
    return CostPerPerson.toStringAsFixed(1);
  }

  calculateTotalTip(double billAmount, int splitBy, int TipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0) {
      Text("Free mein khaya besharam");
    } else {
      totalTip = (billAmount * TipPercentage) / 100;
    }
    return totalTip;
  }
}
