import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//Riverpod化
final textProvider = StateProvider((ref) => '');

void main() {
  runApp(
    //ProviderScopeを宣言
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

//HookWidgetを利用する
class MyHomePage extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //useProviderで宣言
    final textState = useProvider(textProvider);
    //TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter share'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Share.share(textState.state);
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              TextFormField(
                //controller: controller,
                decoration: InputDecoration(
                  hintText: '入力してください',
                  labelText: 'テキスト',
                ),
                onSaved: (String? value) {
                  textState.state = value!;
                  //controller.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
