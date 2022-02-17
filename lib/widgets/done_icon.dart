import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DoneIcon extends StatefulWidget {
  const DoneIcon({Key? key}) : super(key: key);

  @override
  _DoneIconState createState() => _DoneIconState();
}

class _DoneIconState extends State<DoneIcon>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late AnimationController _controller;

@override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Lottie.asset(
        'assets/done.json',
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = const Duration(milliseconds: 2000)
            ..forward();

          _controller.isCompleted
              ? Navigator.of(context).pushReplacementNamed('/')
              : null;
        },
      ),
    );
  }
}
