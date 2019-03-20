import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/database.dart';
import 'package:flutter_hello_world/database/edit_mountain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        EditSumPage.routeName: (context) => EditSumPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Query _query;

  @override
  void initState() {
    Database.queryExpense().then((Query query) => _reInitState(query));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Text("The list is empty...");

    if (_query != null) {
      body = FirebaseAnimatedList(
        query: _query,
        itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,
        ) {
          String noteKey = snapshot.key;
          Map map = snapshot.value;
          String sum = map[Database.SUM] as String;
          return Column(
            children: <Widget>[
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _remove(noteKey),
                ),
                title: Text('$sum'),
                onTap: () => _edit(noteKey),
              ),
              Divider(height: 2.0),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _createExpenseRecord,
      ),
    );
  }

  void _createExpenseRecord() {
    Database.createExpenseRecord()
        .then((String mountainKey) => _edit(mountainKey));
  }

  void _remove(String noteKey) {
    Database.removeExpenseRecord(noteKey)
        .then((Query query) => _reInitState(query));
  }

  void _edit(String mountainKey) {
    var route = MaterialPageRoute(
      builder: (context) => EditSumPage(mountainKey: mountainKey),
    );
    Navigator.of(context).push(route);
  }

  void _reInitState(Query query) {
    setState(() {
      _query = query;
    });
  }
}

//void main() {
//  runApp(ReduxApp());
//}

//void main6() =>
//    runApp(new MaterialApp(home: new Scaffold(body: new HttpTest())));
//
//void main5() => runApp(new MaterialApp(home: new Scaffold(body: new Clock())));
//
//main4() {
//  runApp(
//    new MaterialApp(
//        debugShowCheckedModeBanner: false,
//        initialRoute: '/',
//        routes: {
//          '/': (BuildContext context) => new MainScreen(),
//          '/second': (BuildContext context) => new SecondScreen()
//        },
//        onGenerateRoute: (routeSettings) {
//          List<String> paths = routeSettings.name.split('/');
//
//          if (paths[1] == 'second') {
//            return new MaterialPageRoute(
//                builder: (context) => new SecondScreen(id: paths[2]),
//                settings: routeSettings);
//          }
//        }),
//  );
//}
//
//void main3() {
//  runApp(new MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: new Scaffold(
//        appBar: new AppBar(title: new Text('Форма ввода')), body: InputForm()),
//  ));
//}
//
//void main2() {
//  runApp(new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: new Scaffold(
//          appBar: new AppBar(title: new Text('Анкета трансформера')),
//          body: new NewBox(
//            'Знакомство с Бабами и желтым железным другом',
//            'Внушительный шмель с огромной выхлопной трубой!!!'
//                '\nГотов жужжать дни напролет, заправляясь только в 17:45. '
//                'Иногда из-за перевозбуждения трубы, может трансформироваться в машику и бомбить таксистом, '
//                'правда не очень долго, пару месяцев, а потом опять назад, в стратосферу',
//            imageUrl:
//                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1Cl33rC5y94v9ApjICiUZjdHJJ1Jp7LBSMQ4u0ArWExAc8q_BMQ',
//            like: true,
//            num: 101,
//          ))));
//}
