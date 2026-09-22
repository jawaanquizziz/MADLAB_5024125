import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Stopwatch",
      theme: ThemeData(
        colorSchemeSeed: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const StopwatchPage(),
    );
  }
}

class StopwatchData {
  Duration duration;
  bool isRunning;
  List<String> laps;

  StopwatchData()
      : duration = Duration.zero,
        isRunning = false,
        laps = <String>[];
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopwatchData _data = StopwatchData();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleStopwatch() {
    setState(() {
      if (_data.isRunning) {
        _timer?.cancel();
      } else {
        _timer = Timer.periodic(
          const Duration(milliseconds: 10),
          (timer) {
            if (mounted) {
              setState(() {
                _data.duration += const Duration(milliseconds: 10);
              });
            }
          },
        );
      }

      _data.isRunning = !_data.isRunning;
    });
  }

  void _resetStopwatch() {
    setState(() {
      _timer?.cancel();
      _data.isRunning = false;
      _data.duration = Duration.zero;
      _data.laps.clear();
    });
  }

  void _addLap() {
    setState(() {
      _data.laps.add(_formatDuration(_data.duration));
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    final milliseconds =
        (d.inMilliseconds.remainder(1000) ~/ 10)
            .toString()
            .padLeft(2, '0');

    return "$minutes:$seconds.$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        title: const Text("Stopwatch"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                _formatDuration(_data.duration),
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  fontFeatures: [
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),

              child: ListView.builder(
                itemCount: _data.laps.length,
                itemBuilder: (context, index) {
                  final reverseIndex =
                      _data.laps.length - 1 - index;

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("${reverseIndex + 1}"),
                    ),
                    title: Text(
                      "Lap ${reverseIndex + 1}",
                    ),
                    trailing: Text(
                      _data.laps[reverseIndex],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filledTonal(
                  onPressed: _resetStopwatch,
                  icon: const Icon(Icons.refresh),
                  iconSize: 32,
                ),

                FloatingActionButton.large(
                  onPressed: _toggleStopwatch,
                  child: Icon(
                    _data.isRunning
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),

                IconButton.filledTonal(
                  onPressed:
                      _data.isRunning ? _addLap : null,
                  icon: const Icon(Icons.flag),
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}