import 'package:flutter/material.dart';
import 'package:kamara_parent/academics/subject_screen.dart';

class CardType extends StatefulWidget {
  String titile;
  String subtitle;
  String btnName;
  Widget card;
  CardType(this.titile, this.subtitle, this.btnName, this.card);
  @override
  _CardType createState() =>
      _CardType(this.titile, this.subtitle, this.btnName, card);
}

class _CardType extends State<CardType> {
  String titile;
  String subtitle;
  String btnName;
  Widget card;
  _CardType(this.titile, this.subtitle, this.btnName, this.card);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.album),
          title: Text(titile),
          subtitle: Text(subtitle),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: Text(btnName),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => card));
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('More'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ));
  }
}
