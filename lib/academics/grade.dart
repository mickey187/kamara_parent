import 'package:flutter/material.dart';

class Grade extends StatefulWidget {
  String titile;
  String subtitle;
  String btnName;
  String grade;
  Widget card;
  Grade(this.titile, this.subtitle, this.btnName, this.card, this.grade);
  @override
  _Grade createState() =>
      _Grade(this.titile, this.subtitle, this.btnName, card, this.grade);
}

class _Grade extends State<Grade> {
  String titile;
  String subtitle;
  String btnName;
  String grade;
  Widget card;
  _Grade(this.titile, this.subtitle, this.btnName, this.card, this.grade);

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
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(grade, style: TextStyle(fontSize: 18))),
          ],
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
            // TextButton(
            //   child: const Text('More'),
            //   onPressed: () {/* ... */},
            // ),
            // const SizedBox(width: 8),
          ],
        ),
      ],
    ));
  }
}
