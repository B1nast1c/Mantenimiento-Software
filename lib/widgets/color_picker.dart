import 'package:flutter/material.dart';

List<Color> colors = const [
  Color(0xffff9aa2),
  Color(0xffffb7b2),
  Color(0xffffdac1),
  Color(0xffe2f0cb),
  Color(0xffb5ead7),
  Color(0xffc7ceea),
];

class ColorPicker extends StatefulWidget {
  final Function onSelectedColor;
  final Color chosenColor;

  const ColorPicker(
      {Key? key, required this.onSelectedColor, required this.chosenColor})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color selectedColor;

  @override
  void initState() {
    selectedColor = widget.chosenColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 30.0, top: 15.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final itemColor = colors[index];
          return InkWell(
            onTap: () {
              widget.onSelectedColor(itemColor);
              setState(() {
                selectedColor = itemColor;
              });
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: itemColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.grey.shade300)),
              child: itemColor == selectedColor
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
