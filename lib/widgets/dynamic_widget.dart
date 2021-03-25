import 'package:flutter/material.dart';
import 'package:pdf_test/pages/form_screen.dart';

class BatteryField extends StatefulWidget {
  BatteryField({Key? key,this.voltageControllers}) : super(key: key);

  final VoltageControllers? voltageControllers;
  @override
  State<StatefulWidget> createState() => new _BatteryFieldState();
}

class _BatteryFieldState extends State<BatteryField> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: 
          new Row(
            children: <Widget>[
              new Container(
                width: _screenSize.width * 0.25,
                child: new TextFormField(
                  controller: widget.voltageControllers!.chargeVoltage,
                  maxLength: 20,
                  decoration: new InputDecoration(
                    labelText: "Voltaje carga",
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    hintText: "Voltaje carga",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            new Container(
                width: _screenSize.width * 0.25,
                child: new TextFormField(
                  controller: widget.voltageControllers!.standbyVoltage,
                  maxLength: 20,
                  decoration: new InputDecoration(
                    labelText: "Voltaje reposo",
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    hintText: "Voltaje reposo",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                width: _screenSize.width * 0.25,
                child: new TextFormField(
                  maxLength: 20,
                  controller: widget.voltageControllers!.mOhm,
                  decoration: new InputDecoration(
                    labelText: "°C/mOhm",
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    hintText: "°C/mOhm",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
    );
  }
}
