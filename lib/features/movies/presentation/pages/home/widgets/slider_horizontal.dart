import 'package:flutter/material.dart';

class SliderHorizontal extends StatelessWidget {
  const SliderHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Populares'),
        Container(
          color: Colors.red,
          height: 180,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.8,
              initialPage: 1,
            ),
            itemCount: 10,
            itemBuilder: (_, i) => Card(
              child: ClipRRect(
                child: Text('Hola'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SliderHorizontalItem extends StatelessWidget {
  const SliderHorizontalItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
