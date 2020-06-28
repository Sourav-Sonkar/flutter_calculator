import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  final minimumPadding = 5.0;

  var currency = ['Rupee', 'Dollar', 'Pound'];
  var currentItemselected = "";

  @override
  void initState() {
    super.initState();
    currentItemselected = currency[0];
  }

  String display = "";
  TextEditingController principal = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController time = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle ts = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Simple Interest Calculator")),
      // backgroundColor: Colors.black,
      body: Form(
        //color: Colors.orangeAccent,
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImage(),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: TextFormField(
                  validator: ((String value) {
                    if (value.isEmpty) {
                      return 'Please enter Principal Amount';
                    }
                  }),
                  keyboardType: TextInputType.number,
                  style: ts,
                  controller: principal,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellow, fontSize: 15.0),
                    labelText: 'Principal',
                    labelStyle: ts,
                    hintText: ("Enter Principal e.g. 1200"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: TextFormField(
                  style: ts,
                  controller: interest,
                  validator: ((String value) {
                    if (value.isEmpty) {
                      return 'Please enter Rate of Interest';
                    }
                  }),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    labelStyle: ts,
                    errorStyle: TextStyle(color: Colors.yellow, fontSize: 15.0),
                    hintText: ("In percent"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: ts,
                          validator: ((String value) {
                            if (value.isEmpty) {
                              return 'Please enter Time period';
                            }
                          }),
                      controller: time,
                      decoration: InputDecoration(
                        labelText: 'Term',
                        errorStyle: TextStyle(color: Colors.yellow, fontSize: 15.0),

                        hintText: 'Time e.g. 1,2 years',
                        labelStyle: ts,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )),
                    Container(
                      width: minimumPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: currency.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          dropDownItemSelected(newValueSelected);
                        },
                        value: currentItemselected,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              if (formkey.currentState.validate()) {
                                this.display = calculatetotalreturn();
                              }
                            });
                          },
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                        ),
                      ),
                      Container(
                        width: minimumPadding * 2,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              resetfields();
                            });
                          },
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: Text(
                  display,
                  style: ts,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImage() {
    //AssetImage assetImage=AssetImage('images/money.png');
    Image image = Image(
      image: AssetImage('images/money.png'),
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minimumPadding * 10),
    );
  }

  void dropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentItemselected = newValueSelected;
    });
  }

  String calculatetotalreturn() {
    double price = double.parse(principal.text);
    double roi = double.parse(interest.text);
    double timeperiod = double.parse(time.text);
    double totalAmountPayable = (price * roi * timeperiod) / 100;
    return 'After $timeperiod years,your invesment will be worth $totalAmountPayable $currentItemselected ';
  }

  void resetfields() {
    principal.text = "";
    interest.text = "";
    time.text = "";
    currentItemselected = currency[0];
  }
}
