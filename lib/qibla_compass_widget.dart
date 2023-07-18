import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'qibla_compass_viewmodel.dart';

class QiblahCompass extends StatelessWidget {
  const QiblahCompass({super.key});

  @override
  Widget build(BuildContext context) {
    final qiblahDirection = context.watch<QiblaCompassViewModel>().qiblahDirection;

    if (qiblahDirection == null) {
      return const Center(child: CircularProgressIndicator());
    }

    var platformBrightness = Theme.of(context).brightness;
    var angle = ((qiblahDirection.qiblah) * (pi / 180) * -1);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: angle,
          child: SvgPicture.asset('assets/5.svg', // compass
              color: platformBrightness == Brightness.dark ? Colors.yellow : Colors.orange),
        ),
        const _KaabaSvg(),
        SvgPicture.asset('assets/3.svg', //needle
            color: platformBrightness == Brightness.dark ? Colors.yellow : Colors.orange),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Align both arrow head\nDo not put device close to a metal object.\nCalibrate the compass every time you use it.",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class _KaabaSvg extends StatelessWidget {
  const _KaabaSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/4.svg');
  }
}

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback callback;

  LocationErrorWidget({required this.error, required this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(error),
          ElevatedButton(
            onPressed: callback,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
