import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';

import '../Data Model/water_consume_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCountTEController =
      TextEditingController(text: '1');
  int count = 0;
  List<WaterConsume> waterConsumeList = [];
  final List<Map<String, dynamic>> _glassSizes = [
    {'size': 250, 'imagePath': 'assets/glass.png'},
    {'size': 500, 'imagePath': 'assets/mug.png'},
    {'size': 1000, 'imagePath': 'assets/bottle.png'},
  ];

  int _selectedGlassIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaBuddy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _addWaterConsume,
              child: Container(
                // height: 220,
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   border: Border.all(color: Colors.yellow, width: 8),
                // ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset('assets/water_droplet.json',
                        height: 210, fit: BoxFit.fill),
                    const Column(
                      children: [
                        Icon(Icons.water_drop_outlined, size: 50),
                        SizedBox(height: 6),
                        Text(
                          'Tap Here',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _glassCountTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    label: Text('Glass Number'),
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Type of Glass',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _glassSizes.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGlassIndex = index;
                    });
                  },
                  child: _buildGlassContainer(
                      _glassSizes[index], index == _selectedGlassIndex),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Total Glass: ${_getTolatWaterConsumeCount()}',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            const Divider(height: 10),
            _waterConsumeHistory(),
          ],
        ),
      ),
    );
  }

  Widget _waterConsumeHistory() {
    return Expanded(
      child: ListView.builder(
          itemCount: waterConsumeList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat.yMEd().add_jm().format(
                          waterConsumeList[index].time,
                        ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    '${waterConsumeList[index].glassSizeML} ML',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    '${waterConsumeList[index].glassCount.toString()} G',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildGlassContainer(Map<String, dynamic> glass, bool isSelected) {
    final int size = glass['size'];
    final String imagePath = glass['imagePath'];

    return Container(
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.green,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 26,
              height: 28,
            ),
            Text(
              '$size ML',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  void _addWaterConsume() {
    int glassCount = int.tryParse(_glassCountTEController.text) ?? 1;
    if (_selectedGlassIndex != -1) {
      final selectedSize = _glassSizes[_selectedGlassIndex];
      int glassSizeML = selectedSize['size'];
      WaterConsume waterConsume = WaterConsume(
          time: DateTime.now(),
          glassCount: glassCount,
          glassSizeML: glassSizeML);
      waterConsumeList.add(waterConsume);
    }
    _selectedGlassIndex = -1;
    setState(() {});
  }

  int _getTolatWaterConsumeCount() {
    int totalCount = 0;
    for (WaterConsume waterConsume in waterConsumeList) {
      totalCount += waterConsume.glassCount;
    }
    return totalCount;
  }
}
