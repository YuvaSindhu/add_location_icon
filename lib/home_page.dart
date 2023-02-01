import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double x = 0.0;
  double y = 0.0;
  Offset? mark;

  void updatePosition(TapDownDetails details) {
    x = details.localPosition.dx;
    y = details.localPosition.dy;
    setState(() {
      mark = Offset(x, y);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getMarks();
  }

  // _getMarks() {
  //   mark = const [
  //     Offset(172.8, 58.3),
  //     Offset(124.8, 78.8),
  //     Offset(102.9, 104.8),
  //     Offset(143.3, 152.2),
  //     Offset(250.7, 78.8),
  //     Offset(216.7, 76.3)
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Co-Ordination"),
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: updatePosition,
          child: RepaintBoundary(
              child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"),
                    // AssetImage(
                    //   'assets/dark.jpg',
                    // ),
                    fit: BoxFit.cover)),
            child: mark == null
                ? Container()
                : CustomPaint(
                    painter: MyCustomPainter(mark!),
                  ),
          )),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Offset marks;
  const MyCustomPainter(this.marks);

  @override
  void paint(Canvas canvas, Size size) async {
    print("marks:$marks");

    //For draw location icon
    const icon = Icons.location_on;
    var builder = ParagraphBuilder(ParagraphStyle(
      fontFamily: icon.fontFamily,
    ))
      ..addText(
        String.fromCharCode(icon.codePoint),
      );
    var para = builder.build();
    para.layout(const ParagraphConstraints(width: 60));
    canvas.drawParagraph(para, marks);

    //For draw green points
    // Paint paint = Paint()
    //   ..color = // Colors.redAccent
    //       Colors.green
    //   ..strokeCap = StrokeCap.round
    //   ..strokeWidth = 15.0;

    // canvas.drawPoints(PointMode.points, marks, paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
