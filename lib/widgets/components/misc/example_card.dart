import 'package:flutter/material.dart';

class ExampleCard extends StatelessWidget {
  const ExampleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://rodrigovarejao.com/wp-content/uploads/2020/03/80abc9bceb94535ef1e24cce7e5efb8e-sticker.png',
          ),
          radius: 30,
        ),
        SizedBox(height: 10),
        Text(
          "Google",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Product Designer",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "\$5K/mo",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              "Berlin, Germany",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
