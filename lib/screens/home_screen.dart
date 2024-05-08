import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCountTEController = TextEditingController(
      text: '1');
  int count = 0;
  List<WaterConsume> waterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drink Water Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Tap here to track water consume'),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _addWaterConsume,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.yellow, width: 8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(Icons.water_drop_outlined),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 80,
              child: TextField(
                controller: _glassCountTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('History'),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(waterConsumeList[index].time.toString()),
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      trailing: Text(
                        waterConsumeList[index].glassCount.toString(),
                        style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  }

              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addWaterConsume() {
    int glassCount = int.tryParse(_glassCountTEController.text) ?? 1;
    WaterConsume waterConsume = WaterConsume(
        time: DateTime.now(), glassCount: glassCount);
    waterConsumeList.add(waterConsume);
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

class WaterConsume {
  final DateTime time;
  final int glassCount;

  WaterConsume({required this.time, required this.glassCount});

}
