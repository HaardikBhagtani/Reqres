import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.userAvatar, required this.userFirstName, required this.userEmail, required this.userLastName})
      : super(key: key);
  final String userAvatar;
  final String userFirstName;
  final String userLastName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundImage: NetworkImage(userAvatar),
            radius: 50,
          ),
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$userFirstName $userLastName",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
