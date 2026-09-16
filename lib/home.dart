import 'package:app2/dashboard.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drop_down_list/drop_down_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _MyState();
}

class _MyState extends State<Home> {
  TextEditingController firstname = TextEditingController();
  TextEditingController midname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  late final List<TextEditingController> controllers;
  final titles = ["firstName", "midName", "lastName", "email/phone", "age"];

  Future<void> setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("firstname", controllers[0].text);
    await prefs.setString("midname", controllers[1].text);
    await prefs.setString("lastname", controllers[2].text);
    await prefs.setString("id", controllers[3].text);
    await prefs.setString("age", controllers[4].text);
    await prefs.setBool("isLogged", true);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => App()),
      (route) => false,
    );
  }

  void showDrop() {
    DropDownState(
      dropDown: DropDown(
        data: List.generate(28, (index) {
          var ageval = (index + 18).toString();
          return SelectedListItem<String>(data: ageval, isSelected: false);
        }),
        onSelected: (List<SelectedListItem<dynamic>> selectedList) {
          if (selectedList.isNotEmpty) {
            setState(() {
              controllers[4].text = selectedList.first.data;
            });
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  void initState() {
    super.initState();
    controllers = List.generate(titles.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login Page')),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Row(
              children: [
                ...List.generate(3, (i) {
                  return _CustomField(
                    width: 100,
                    title: titles[i],
                    controller: controllers[i],
                  );
                }),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
                  child: SizedBox(
                    width: 330,
                    child: _CustomField(
                      width: 0,
                      title: titles[3],
                      controller: controllers[3],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
                  child: SizedBox(
                    width: 330,
                    child: _CustomField(
                      readonly: true,
                      width: 0,
                      controller: controllers[4],
                      title: titles[4],
                      builder: showDrop,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(100, 230, 100, 0),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (controllers[0].text != "" &&
                          controllers[1].text != "" &&
                          controllers[2].text != "" &&
                          controllers[3].text != "" &&
                          controllers[4].text != "") {
                        setData();
                      }
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomField extends StatefulWidget {
  const _CustomField({
    required this.width,
    required this.title,
    this.builder,
    this.controller,
    this.readonly,
  });
  final double width;
  final String title;
  final Function()? builder;
  final TextEditingController? controller;
  final bool? readonly;
  @override
  State<_CustomField> createState() => __CustomFieldState();
}

class __CustomFieldState extends State<_CustomField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Form(
        child: TextFormField(
          readOnly: widget.readonly ?? false,
          controller: widget.controller,
          onTap: widget.builder,
          decoration: InputDecoration(
            labelText: widget.title,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ),
    );
  }
}
