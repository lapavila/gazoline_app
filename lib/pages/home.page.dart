import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gazoline/widgets/logo.widget.dart';
import 'package:gazoline/widgets/submit-form.widget.dart';
import 'package:gazoline/widgets/success.widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _gasCtrl = MoneyMaskedTextController();
  var _alcCtrl = MoneyMaskedTextController();
  var _completed = false;
  var _resultText = "Usa ...";
  var _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: ListView(
          children: <Widget>[
            Logo(),
            _completed
                ? Success(
                    result: _resultText,
                    reset: reset,
                  )
                : SubmitForm(
                    alcCtrl: _alcCtrl,
                    gasCtrl: _gasCtrl,
                    submitFunc: calculate,
                    busy: _busy,
                  ),
          ],
        ));
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), ''));
    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), ''));
    double res = alc / gas;
    _completed = false;
    _busy = true;

    setState(() {
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          _resultText = "Use Gasolina";
        } else {
          _resultText = "Use Álcool";
        }
        _busy = false;
        _completed = true;
      });
    });
  }

  reset() {
    setState(() {
      _alcCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
    });
  }
}
