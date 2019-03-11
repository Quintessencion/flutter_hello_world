import 'package:flutter/material.dart';
import 'package:flutter_hello_world/redux/actions/actions.dart';
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
      appBar: AppBar(title: Text('Redux Items')),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        onInit: (store) => store.dispatch(GitItemsAction()),
        builder: (BuildContext context, _ViewModel vm) => Column(
              children: <Widget>[
                AddItemWidget(vm),
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

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: 'add an item'),
      onSubmitted: (String s) {
        widget.model.onAddItem(s);
        controller.text = '';
      },
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final _ViewModel model;

  ItemListWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: model.items
            .map(
              (Item item) => Container(
                      child: Column(children: <Widget>[
                    ListTile(
                      title: Text(item.body),
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => model.onRemoveItem(item),
                      ),
                      trailing: Checkbox(
                        value: item.completed,
                        onChanged: (b) {
                          model.onCompleted(item);
                        },
                      ),
                    ),
                    Divider(color: Colors.white),
                  ])),
            )
            .toList());
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
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;
  final Function(Item) onCompleted;

  _ViewModel(
      {this.items,
      this.onAddItem,
      this.onRemoveItem,
      this.onRemoveItems,
      this.onCompleted});

  factory _ViewModel.create(Store<AppState> store) {
    _onAddITem(String body) {
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    _onCompleted(Item item) {
      store.dispatch(ItemCompletedAction(item));
    }

    return _ViewModel(
        items: store.state.items,
        onAddItem: _onAddITem,
        onRemoveItem: _onRemoveItem,
        onRemoveItems: _onRemoveItems,
        onCompleted: _onCompleted);
  }
}
