import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reqres_app/modals/user_list_modal.dart';
import 'package:reqres_app/widgets/user_card.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key, required this.userPageNumber}) : super(key: key);
  final int userPageNumber;

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool loading = true;
  UserList? userList;

  @override
  void initState() {
    getUserData(widget.userPageNumber).whenComplete(() => setState(() {
          loading = false;
        }));
    super.initState();
  }

  Future getUserData(int userPageNumber) async {
    http.Response response = await http.get(Uri.parse("https://reqres.in/api/users?page=$userPageNumber"));
    var parsed = jsonDecode(response.body);
    userList = UserList.fromJson(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reqres User List"),
        centerTitle: true,
      ),
      body: !loading
          ? SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  ListView.separated(
                    controller: ScrollController(),
                    itemCount: userList!.perPage!,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => UserCard(
                        userAvatar: userList!.data![index].avatar!,
                        userFirstName: userList!.data![index].firstName!,
                        userLastName: userList!.data![index].lastName!,
                        userEmail: userList!.data![index].email!),
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                  ),
                  const Text('Page 2'),
                  const SizedBox(height: 20),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
