import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_php_crud/controllers/user.dart';
import 'package:flutter_php_crud/models/user.dart';
import 'package:flutter_php_crud/widgets/colors.dart';
import 'package:flutter_php_crud/widgets/dialogs.dart';
import 'package:flutter_php_crud/widgets/texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> usersList = [];
  StreamController streamController = StreamController();
  TextEditingController name = TextEditingController();

  Future getUsers() async {
    usersList = await UserController().getUsers();
    streamController.sink.add(usersList);
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) => getUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Title(
        title: 'Flutter PHP CRUD App',
        color: white,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: black,
                title: poppins('Flutter PHP CRUD App', white, 20, fsNormal,
                    fwBold, taLeft),
                actions: [
                  FloatingActionButton.small(
                      onPressed: () => addUserForm(),
                      backgroundColor: blue,
                      child: Icon(Icons.add, color: white))
                ]),
            body: SafeArea(
                child: StreamBuilder(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: poppins(snapshot.error.toString(), darkRed,
                                20, fsNormal, fwBold, taCenter));
                      } else if (snapshot.hasData) {
                        if (usersList.isEmpty) {
                          return Center(
                              child: poppins('EMPTY RECORDS!', darkRed, 20,
                                  fsNormal, fwBold, taCenter));
                        } else {
                          return ListView.builder(
                              itemCount: usersList.length,
                              itemBuilder: (context, index) {
                                var name = usersList[index].name;
                                var id = usersList[index].id;
                                return ListTile(
                                  title: poppins(name, black, 15, fsNormal,
                                      fwBold, taLeft),
                                  subtitle: poppins(
                                      id, gray, 12, fsNormal, fwBold, taLeft),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FloatingActionButton.small(
                                          onPressed: () => editUserForm(
                                              UserModel(id: id, name: name)),
                                          backgroundColor: darkGreen,
                                          child:
                                              Icon(Icons.edit, color: white)),
                                      const SizedBox(width: 10),
                                      FloatingActionButton.small(
                                          onPressed: () => deleteUser(
                                              UserModel(id: id, name: name)),
                                          backgroundColor: darkRed,
                                          child:
                                              Icon(Icons.delete, color: white))
                                    ],
                                  ),
                                );
                              });
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }))),
      );

  addUserForm() async => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (addUserDialog) => AlertDialog(
              scrollable: true,
              title:
                  poppins('ADD USER', darkBlue, 20, fsNormal, fwBold, taCenter),
              content: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Column(children: [
                  TextField(
                      controller: name,
                      cursorColor: darkBlue,
                      onSubmitted: (value) =>
                          addUser(UserModel(id: generateID(), name: name.text)),
                      decoration: InputDecoration(
                          label: poppins(
                              'NAME', darkBlue, 15, fsNormal, fwBold, taLeft),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkBlue),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkBlue),
                              borderRadius: BorderRadius.circular(10))))
                ]),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      name.text = '';
                    },
                    icon: Icon(Icons.close, color: darkRed)),
                IconButton(
                    onPressed: () =>
                        addUser(UserModel(id: generateID(), name: name.text)),
                    icon: Icon(Icons.check, color: darkGreen))
              ]));

  addUser(UserModel userModel) async => name.text.isEmpty
      ? showDialog(
          context: context,
          barrierDismissible: false,
          builder: (nameEmptyWarning) => errorDialog(
              context, 'ADD USER', 'Add failed! Please do not leave a blank!'))
      : await UserController()
          .addUser(context, userModel)
          .then((value) => Navigator.pop(context))
          .then((value) => name.text = '');

  editUserForm(UserModel userModel) async {
    name.text = userModel.name;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (addUserDialog) => AlertDialog(
                scrollable: true,
                title: poppins(
                    'EDIT USER', darkGreen, 20, fsNormal, fwBold, taCenter),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Column(children: [
                    TextField(
                        controller: name,
                        cursorColor: darkGreen,
                        onChanged: (value) => value = name.text,
                        onSubmitted: (value) => updateUser(
                            UserModel(id: userModel.id, name: name.text)),
                        decoration: InputDecoration(
                            label: poppins('NAME', darkGreen, 15, fsNormal,
                                fwBold, taLeft),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: darkGreen),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: darkGreen),
                                borderRadius: BorderRadius.circular(10))))
                  ]),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        name.text = '';
                      },
                      icon: Icon(Icons.close, color: darkRed)),
                  IconButton(
                      onPressed: () => updateUser(
                          UserModel(id: userModel.id, name: name.text)),
                      icon: Icon(Icons.check, color: darkGreen))
                ]));
  }

  updateUser(UserModel userModel) async => name.text.isEmpty
      ? showDialog(
          context: context,
          barrierDismissible: false,
          builder: (nameEmptyWarning) => errorDialog(context, 'EDIT USER',
              'Update failed! Please do not leave a blank!'))
      : await UserController()
          .updateUser(context, userModel)
          .then((value) => Navigator.pop(context))
          .then((value) => name.text = '');

  deleteUser(UserModel userModel) async => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (deleteUserDialog) => AlertDialog(
              scrollable: true,
              title:
                  poppins('DELETE', darkBlue, 20, fsNormal, fwBold, taCenter),
              content: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: poppins(
                    'Are you sure you want to delete "${userModel.name}"?',
                    black,
                    15,
                    fsNormal,
                    fwNormal,
                    taLeft),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: darkRed)),
                IconButton(
                    onPressed: () async => await UserController()
                        .deleteUser(context, userModel)
                        .then((value) => Navigator.pop(context)),
                    icon: Icon(Icons.check, color: darkGreen))
              ]));
}
