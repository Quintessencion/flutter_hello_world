import 'package:flutter/material.dart';
import 'package:flutter_hello_world/NewBox.dart';
import 'package:flutter_hello_world/async/sand.glass.dart';
import 'package:flutter_hello_world/http/http.request.dart';
import 'package:flutter_hello_world/input.form.dart';
import 'package:flutter_hello_world/main/main.screen.dart';
import 'package:flutter_hello_world/redux/myHomePage.dart';

void main() {
  runApp(ReduxApp());
}

void main6() =>
    runApp(new MaterialApp(home: new Scaffold(body: new HttpTest())));

void main5() => runApp(new MaterialApp(home: new Scaffold(body: new Clock())));

main4() {
  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => new MainScreen(),
          '/second': (BuildContext context) => new SecondScreen()
        },
        onGenerateRoute: (routeSettings) {
          List<String> paths = routeSettings.name.split('/');

          if (paths[1] == 'second') {
            return new MaterialPageRoute(
                builder: (context) => new SecondScreen(id: paths[2]),
                settings: routeSettings);
          }
        }),
  );
}

void main3() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
        appBar: new AppBar(title: new Text('Форма ввода')), body: InputForm()),
  ));
}

void main2() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(title: new Text('Анкета трансформера')),
          body: new NewBox(
            'Знакомство с Бабами и желтым железным другом',
            'Внушительный шмель с огромной выхлопной трубой!!!'
                '\nГотов жужжать дни напролет, заправляясь только в 17:45. '
                'Иногда из-за перевозбуждения трубы, может трансформироваться в машику и бомбить таксистом, '
                'правда не очень долго, пару месяцев, а потом опять назад, в стратосферу',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1Cl33rC5y94v9ApjICiUZjdHJJ1Jp7LBSMQ4u0ArWExAc8q_BMQ',
            like: true,
            num: 101,
          ))));
}
