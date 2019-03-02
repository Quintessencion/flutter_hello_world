import 'package:flutter/material.dart';

enum Gender { male, female }

class InputForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InputFormState();
}

class InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Gender _gender;
  bool _agreement = false;

  TextStyle _headerStyle = new TextStyle(fontSize: 20.0);
  SizedBox _emptyDivider = SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new Text('Имя пользователя:', style: _headerStyle),
                new TextFormField(validator: _nameValidator),
                _emptyDivider,
                new Text('E-mail', style: _headerStyle),
                new TextFormField(validator: _emailValidator),
                _emptyDivider,
                new Text('Ваш пол', style: _headerStyle),
                new RadioListTile(
                    title: new Text('Мужской'),
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender value) =>
                        setState(() => _gender = value)),
                new RadioListTile(
                    title: new Text('Женский'),
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender value) =>
                        setState(() => _gender = value)),
                _emptyDivider,
                new CheckboxListTile(
                    title: new Text('Я ознакомлен(а)'),
                    value: _agreement,
                    onChanged: _onChange),
                new RaisedButton(
                  onPressed: _validate,
                  child: Text('Проверить'),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            )));
  }

  String _nameValidator(String value) =>
      value.isEmpty ? 'Пожалуйста, введите имя' : null;

  String _emailValidator(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, введите адрес электронной почты';
    } else if (!value.contains('@')) {
      return 'Некоректный адрес электронной почты';
    }
    return null;
  }

  void _onChange(bool value) => setState(() => _agreement = value);

  void _validate() {
    if (_formKey.currentState.validate()) {
      Color color = Colors.red;
      String text = _gender == null ? 'Укажите свой пол' : '';

      if (_gender == null) {
        text = 'Укажите свой пол';
      } else if (!_agreement) {
        text = 'Необходимо подтвердить соглашение';
      } else {
        text = 'Форма успешно заполнена';
        color = Colors.green;
      }

      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(text),
        backgroundColor: color,
      ));
    }
  }
}
