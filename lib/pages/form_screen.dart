import 'dart:convert';
import 'dart:io';

import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:pdf_test/PdfPreviewScreen.dart';
import 'package:pdf_test/widgets/dynamic_widget.dart';
import 'package:pdf_test/widgets/fields.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  int _currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _sign = GlobalKey<SignatureState>();
  BatteryHeader batteryHeader = BatteryHeader();
  /// dynamic list of texfileds
  final List<VoltageControllers> valtageControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valtageControllers.add(VoltageControllers(1,TextEditingController(),
        TextEditingController(), TextEditingController()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Demo")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: FAStepper(
                    steps: _stepper(),
                    currentStep: _currentStep,
                    onStepTapped: (step) {
                      setState(() {
                        this._currentStep = step;
                      });
                    },
                    onStepContinue: () {
                      setState(() {
                        if (this._currentStep < this._stepper().length - 1) {
                          this._currentStep = this._currentStep + 1;
                        } else {
                          print('Complete');
                        }
                      });
                    },
                    onStepCancel: () {
                      setState(() {
                        if (this._currentStep > 0) {
                          this._currentStep = this._currentStep - 1;
                        } else {
                          this._currentStep = 0;
                        }
                      });
                    },
                  )),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  List<FAStep> _stepper() {
    List<FAStep> _steps = [
      FAStep(title: Text("Información General"), content: _firstStep()),
      FAStep(title: Text("Contenido"), content: _secondStep()),
      FAStep(title: Text("Firma"), content: _thirdStep()),
    ];
    return _steps;
  }

  Widget _firstStep() {
    final _screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: _screenSize.width * 0.8,
        child: Column(
          children: <Widget>[
            TextFormField(
              maxLength: 20,
              onSaved: (input) => batteryHeader.empresa = input!,
              decoration: new InputDecoration(
                labelText: "Empresa",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                hintText: "Empresa",
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
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            TextFormField(
              maxLength: 20,
              onSaved: (input) => batteryHeader.ubication = input!,
              decoration: new InputDecoration(
                labelText: "Ubicación",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                hintText: "Ubicación",
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
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            TextFormField(
              maxLength: 20,
              onSaved: (input) => batteryHeader.marca = input!,
              decoration: new InputDecoration(
                labelText: "Marca",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                hintText: "Marca",
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
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            TextFormField(
              maxLength: 20,
              onSaved: (input) => batteryHeader.capacidad = input!,
              decoration: new InputDecoration(
                labelText: "Capacidad",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                hintText: "Capacidad",
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
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

int index = 1;
  Widget _secondStep() {
    return new LayoutBuilder(
      builder: (context, constraint) {
        return new Column(
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: new ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                    valtageControllers.length,
                    (index) => BatteryField(
                        voltageControllers: valtageControllers[index])),
              ),
            ),
            new TextButton(
              onPressed: () {
                /// adding three dynamic fileds
                index = index + 1;
                valtageControllers.add(VoltageControllers(
                    index,
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController()));
                setState(() {});
              },
              child: new Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }

  Widget _thirdStep() {
    final _screenSize = MediaQuery.of(context).size;
    var color = Colors.red;
    var strokeWidth = 5.0;
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: _screenSize.width * 0.35,
            height: _screenSize.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Signature(
                color: color,
                key: _sign,
                onSign: () {
                  final sign = _sign.currentState;
                  debugPrint('${sign?.points.length} points in the signature');
                },
                strokeWidth: strokeWidth,
              ),
            ),
            color: Colors.black12,
          ),
        ),
        MaterialButton(
            color: Colors.grey,
            onPressed: () {
              final sign = _sign.currentState;
              sign?.clear();
              setState(() {
                _img = ByteData(0);
              });
              debugPrint("cleared");
            },
            child: Text("Limpiar")),
      ],
    );
  }

  ByteData _img = ByteData(0);
  var buffer;
  var data;
  Widget submitButton() {
    return ElevatedButton(
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        _formKey.currentState!.save();
        final sign = _sign.currentState;
        final image = await sign?.getData();
         data = await image?.toByteData(format: ui.ImageByteFormat.png);
        sign?.clear();
        final encoded = base64.encode(data.buffer.asUint8List());
      
        setState(() {
        _img = data;
        buffer = data.buffer;
        });
      print(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
        writeOnPdf();
        await savePdf();
        Directory documentDirectory = await getApplicationDocumentsDirectory();

        String documentPath = documentDirectory.path;

        String fullPath = "$documentPath/example.pdf";

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PdfPreviewScreen(
                      path: fullPath,
                    )));
      },
    );
  }

  final pdf = pw.Document();
  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(await pdf.save());
  }


  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        List<List<String>> _lisTemp = [];
        valtageControllers.forEach((element) {
          return _lisTemp.add(
              [ element.headerRow.toString(),element.chargeVoltage.text,element.standbyVoltage.text,element.mOhm.text]);
        });
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Lalala")),
          pw.Paragraph(text: batteryHeader.empresa),
          pw.Paragraph(text: batteryHeader.ubication),
          pw.Header(level: 1, child: pw.Text("Second Heading")),
          pw.Paragraph(text: batteryHeader.marca),
          pw.Paragraph(text: batteryHeader.capacidad),
        pw.Table.fromTextArray(data: [
        ['N','Voltage carage','Volatage resposo','C/mOhm'],
          ..._lisTemp
        ]),
          pw.Image(pw.MemoryImage(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)))
        ];
      },
    ));
  }
}

/// model of dynamic textfilds
class VoltageControllers {
  final int headerRow;
  final TextEditingController chargeVoltage;
  final TextEditingController standbyVoltage;
  final TextEditingController mOhm;

  VoltageControllers(this.headerRow,this.chargeVoltage, this.standbyVoltage, this.mOhm);
}
