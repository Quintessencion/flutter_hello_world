import 'package:flutter/material.dart';
import 'package:flutter_hello_world/MyBody.dart';
import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/baseScreenState.dart';
import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:flutter_hello_world/redux/model/itemState.dart';
import 'package:flutter_hello_world/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class ReduxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: prepareStore(),
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: StoreBuilder<AppState>(
//            onInit: (store) => store.dispatch(GitItemsAction()),//onInit можно вызвать отсюда
            builder: (BuildContext context, Store<AppState> store) =>
                MyHomePage(store),
          ),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  final DevToolsStore<AppState> store;

  MyHomePage(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        onInit: (store) => store.dispatch(GitItemsAction()),
        builder: (BuildContext context, _ViewModel vm) => Column(
              children: <Widget>[
                AddItemWidget(vm),
                SizedBox(height: 20.0),
                Expanded(child: ItemListWidget(vm)),
                RemoveItemButton(vm)
              ],
            ),
      ),
      drawer: Container(child: ReduxDevTools(store)),
    );
  }
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  AddItemWidget(this.model);

  @override
  State<StatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends BaseScreenState<AddItemWidget> {
//  StreamSubscription _itemSubscription;
  final TextEditingController controller = TextEditingController();

//  @override
//  void initState() {
//    getStream(widget.model.onUpdateItem)
//        .then((StreamSubscription s) => _itemSubscription = s);
//    super.initState();
//  }

//  @override
//  void dispose() {
//    _itemSubscription.cancel();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'add an item',
        contentPadding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
      ),
      onSubmitted: (String s) {
        widget.model.onAddItem(s, "Group 1");
        controller.text = '';
        showToast('Item added');
      },
    );
  }
}

//Future<StreamSubscription<Event>> getStream(Function(Item) onUpdateItem) async {
//  StreamSubscription<Event> subscription = FirebaseDatabase.instance
//      .reference()
//      .child("Items")
//      .onChildChanged
//      .listen((Event event) {
//    var key = event.snapshot.key;
//    var snapshot = event.snapshot;
//    var value1 = snapshot.value;
//    var value = event.snapshot.value;
//    onUpdateItem(value);
//  });
//
//  return subscription;
//}

class ItemListWidget extends StatefulWidget {
  final _ViewModel model;

  ItemListWidget(this.model);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends BaseScreenState<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.model.items.map(
      (Item item) {
        return Container(
            child: Column(children: <Widget>[
          ListTile(
            title: Text(item.body),
            leading: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => widget.model.onRemoveItem(item),
            ),
            trailing: Checkbox(
              value: item.completed,
              onChanged: (b) {
                openScreen(MyBody());
              },
            ),
          ),
          Divider(color: Colors.white),
        ]));
      },
    ).toList());
  }
}

class RemoveItemButton extends StatelessWidget {
  final _ViewModel model;

  RemoveItemButton(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Delete all items'),
      onPressed: model.onRemoveItems,
    );
  }
}

class _ViewModel {
  final List<Item> items;
  final Function(String, String) onAddItem;

//  final Function(Item) onUpdateItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;
  final Function(Item) onCompleted;

  _ViewModel(
      {this.items,
      this.onAddItem,
//      this.onUpdateItem,
      this.onRemoveItem,
      this.onRemoveItems,
      this.onCompleted});

  factory _ViewModel.create(Store<AppState> store) {
    _onAddITem(String body, String group) {
      store.dispatch(AddItemAction(body, group));
    }

//    _onUpdateItem(Item item) {
//      store.dispatch(UpdateItemAction(item));
//    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction("Items"));
    }

    _onCompleted(Item item) {
      store.dispatch(ItemCompletedAction(item));
    }

    return _ViewModel(
        items: store.state.items,
        onAddItem: _onAddITem,
//        onUpdateItem: _onUpdateItem,
        onRemoveItem: _onRemoveItem,
        onRemoveItems: _onRemoveItems,
        onCompleted: _onCompleted);
  }
}
