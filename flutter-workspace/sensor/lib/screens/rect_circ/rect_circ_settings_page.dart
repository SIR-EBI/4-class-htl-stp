import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_sensor_plus/screens/rect_circ/rect_circ_manager.dart';

class RectCircSettingsPage extends StatefulWidget {
  const RectCircSettingsPage({Key? key}) : super(key: key);

  @override
  State<RectCircSettingsPage> createState() => _RectCircSettingsPageState();
}

class _RectCircSettingsPageState extends State<RectCircSettingsPage> {
  void _changeColor(Color color) {
    setState(() => RectCircManager.circleColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0e5ec),
      appBar: AppBar(
        backgroundColor: const Color(0xffe0e5ec),
        elevation: 0,
        title: const Text(
          "Rectangle Circle Settings",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          height: 600,
          padding: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: const Color(0xffe0e5ec),
            boxShadow: const [
              BoxShadow(
                offset: Offset(-4, -4),
                blurRadius: 4,
                color: Colors.white,
              ),
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 4,
                color: Color(0xffa3b1c6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColorPicker(
                pickerColor: RectCircManager.circleColor,
                onColorChanged: _changeColor,
              ),
              Slider(
                value: RectCircManager.factor,
                min: 1,
                max: 50,
                divisions: 50,
                label: RectCircManager.factor.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    RectCircManager.factor = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
