import 'package:flutter/material.dart';
import 'package:reqres_app/screens/user_list_page.dart';
import 'package:reqres_app/screens/create_user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon.png",
              color: Colors.blueAccent.shade700,
              width: MediaQuery.of(context).size.width / 2,
              //height: MediaQuery.of(context).size.height / 2,
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const UserListPage(userPageNumber: 2)),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      //side: BorderSide(color: kMainColor, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text("Reqres User List"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const CreateUserPage()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      //side: BorderSide(color: kMainColor, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text("Create Reqres User"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
