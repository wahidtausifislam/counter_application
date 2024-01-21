import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}

int count = 0;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  increment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    count++;
    setState(() {
      preferences.setInt("Countvalue", count);
    });
  }

  decrement() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    count--;
    setState(() {
      preferences.setInt("Countvalue", count);
    });
  }

  @override
  void initState() {
    action();
    super.initState();
  }

  action() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? countvalue = preferences.getInt("Countvalue");
    count = countvalue!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade50,
        title: const Text(
          "Counter App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 85,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CircularPercentIndicator(
                  radius: 100,
                  lineWidth: 16,
                  backgroundColor: Colors.deepPurple.shade100,
                  progressColor: Colors.deepPurple,
                  percent: (count / 100),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    count.toString(),
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade200,
                ),
                onPressed: () {
                  count = 0;
                  setState(() {});
                },
                child: Text("Reset Counter"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 15,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        decrement();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.minus,
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        increment();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
