import 'package:flutter/material.dart';
import 'package:flutter_hello_world/async/sand.glass.dart';
import 'package:flutter_hello_world/database/firebaseApp.dart';
import 'package:flutter_hello_world/http/http.request.dart';
import 'package:flutter_hello_world/input.form.dart';
import 'package:flutter_hello_world/main/main.screen.dart';
import 'package:flutter_hello_world/newBox.dart';
import 'package:flutter_hello_world/redux/myHomePage.dart';

void main() => runApp(FirebaseApp());

void main7() => runApp(ReduxApp());

void main6() => runApp(MaterialApp(home: Scaffold(body: HttpTest())));

void main5() => runApp(MaterialApp(home: Scaffold(body: Clock())));

main4() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => MainScreen(),
          '/second': (BuildContext context) => SecondScreen()
        },
        onGenerateRoute: (routeSettings) {
          List<String> paths = routeSettings.name.split('/');

          if (paths[1] == 'second') {
            return MaterialPageRoute(
                builder: (context) => SecondScreen(id: paths[2]),
                settings: routeSettings);
          }
        }),
  );
}

void main3() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
        Scaffold(appBar: AppBar(title: Text('Форма ввода')), body: InputForm()),
  ));
}

void main2() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: Text('Анкета трансформера')),
          body: NewBox(
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
