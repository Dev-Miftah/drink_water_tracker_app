import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
        title: const Text('Water Consume Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: _addWaterConsume,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.yellow, width: 8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Icon(Icons.water_drop_outlined),
                      Text('Tap Here',
                        style: TextStyle(
                          fontSize: 14
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _glassCountTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  label: Text('Glass Number'),
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder( borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  )
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Type of Glass',
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.yellowAccent,
                      width: 4
                    )
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(Icons.coffee_outlined),
                          Text('250 ML')
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.yellowAccent,
                          width: 4
                      )
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(Icons.coffee_outlined),
                          Text('350 ML')
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.yellowAccent,
                          width: 4
                      )
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(Icons.coffee_outlined),
                          Text('450 ML')
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('History',
                style: TextStyle(
                  fontSize: 18
                ),
                ),
                Text('Total: ${_getTolatWaterConsumeCount()}',
                  style: const TextStyle(
                      fontSize: 18
                  ),
                )
              ],
            ),
            const Divider(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    var reversedList = waterConsumeList.reversed.toList();
                    return ListTile(
                      title: Text(DateFormat.yMEd().add_jm().format(waterConsumeList[index].time)),
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      trailing: Text(
                        waterConsumeList[index].glassCount.toString(),
                        style: const TextStyle(fontSize: 18,
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
