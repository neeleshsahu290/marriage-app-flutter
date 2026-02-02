import 'package:flutter/material.dart';

class SwipeCardsPage extends StatefulWidget {
  @override
  State<SwipeCardsPage> createState() => _SwipeCardsPageState();
}

class _SwipeCardsPageState extends State<SwipeCardsPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  double dx = 0;
  double dy = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (currentIndex + 1 < profiles.length)
              buildCard(currentIndex + 1, isBehind: true),

            buildCard(currentIndex),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index, {bool isBehind = false}) {
    if (index >= profiles.length) return const SizedBox();

    final profile = profiles[index];

    return Transform.translate(
      offset: isBehind ? const Offset(0, 10) : Offset(dx, dy),
      child: Transform.rotate(
        angle: isBehind ? 0 : dx / 3000,
        child: GestureDetector(
          onPanUpdate: (details) {
            if (isBehind) return;

            setState(() {
              dx += details.delta.dx;
              dy += details.delta.dy;
            });
          },
          onPanEnd: (_) {
            if (dx.abs() > 120) {
              swipeAway();
            } else {
              resetPosition();
            }
          },
          child: Container(
            width: 320,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(profile),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black26,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void swipeAway() {
    setState(() {
      dx = 0;
      dy = 0;
      currentIndex++;
    });
  }

  void resetPosition() {
    setState(() {
      dx = 0;
      dy = 0;
    });
  }
}

final profiles = [
  "https://picsum.photos/400/600?1",
  "https://picsum.photos/400/600?2",
  "https://picsum.photos/400/600?3",
  "https://picsum.photos/400/600?4",
];
