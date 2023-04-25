import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_php_crud/models/user.dart';
import 'package:flutter_php_crud/widgets/dialogs.dart';
import 'package:flutter_php_crud/widgets/texts.dart';
import 'package:http/http.dart' as http;

class UserController {
  List<UserModel> usersFromJson(String encodedJSON) => List<UserModel>.from(
      json.decode(encodedJSON).map((item) => UserModel.fromJson(item)));

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(READ_URL));
    if (response.statusCode == 200) {
      List<UserModel> users = usersFromJson(response.body);
      return users;
    } else {
      return <UserModel>[];
    }
  }

  Future<String> addUser(BuildContext context, UserModel userModel) async {
    final response =
        await http.post(Uri.parse(CREATE_URL), body: userModel.toJson());

    if (response.statusCode == 200) {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (addUserSuccess) =>
                successDialog(context, 'ADD USER', response.body));
      }
      return response.body;
    } else {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (deleteUserSuccess) => errorDialog(context, 'ADD USER',
                'Error ${response.statusCode.toString()}'));
      }
      return response.statusCode.toString();
    }
  }

  Future<String> updateUser(BuildContext context, UserModel userModel) async {
    final response = await http.post(Uri.parse(UPDATE_URL),
        body: {'id': userModel.id, 'name': userModel.name});

    if (response.statusCode == 200) {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (addUserSuccess) =>
                successDialog(context, 'UPDATE USER', response.body));
      }
      return response.body;
    } else {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (deleteUserSuccess) => errorDialog(context, 'UPDATE USER',
                'Error ${response.statusCode.toString()}'));
      }
      return response.statusCode.toString();
    }
  }

  Future<String> deleteUser(BuildContext context, UserModel userModel) async {
    final response = await http.post(Uri.parse(DELETE_URL),
        body: {'id': userModel.id, 'name': userModel.name});

    if (response.statusCode == 200) {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (deleteUserSuccess) =>
                successDialog(context, 'DELETE USER', response.body));
      }
      return response.body;
    } else {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (deleteUserSuccess) => errorDialog(context, 'DELETE USER',
                'Error ${response.statusCode.toString()}'));
      }
      return response.statusCode.toString();
    }
  }
}
