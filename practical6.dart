import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Icons Images Charts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dashboard'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 1. HEADER ICON
            const Center(
              child: Icon(
                Icons.dashboard,
                size: 70,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Icons, Images & Charts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // More Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.home, size: 40, color: Colors.blue),
                Icon(Icons.favorite, size: 40, color: Colors.red),
                Icon(Icons.star, size: 40, color: Colors.orange),
                Icon(Icons.settings, size: 40, color: Colors.grey),
              ],
            ),

            const SizedBox(height: 30),

            // 2. NETWORK IMAGE
            const Text(
              'Image Section',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://picsum.photos/600/250',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,

                // Shows loading indicator
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },

                // Shows error icon if image fails
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // 3. CHART SECTION
            const Text(
              'Sales Chart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 280,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: const [
                  ChartBar(
                    label: 'Mon',
                    height: 100,
                    color: Colors.blue,
                  ),
                  ChartBar(
                    label: 'Tue',
                    height: 160,
                    color: Colors.green,
                  ),
                  ChartBar(
                    label: 'Wed',
                    height: 130,
                    color: Colors.orange,
                  ),
                  ChartBar(
                    label: 'Thu',
                    height: 200,
                    color: Colors.red,
                  ),
                  ChartBar(
                    label: 'Fri',
                    height: 150,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 4. INFORMATION CARDS
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.trending_up,
                            color: Colors.green,
                            size: 35,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Sales',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹25,000',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.people,
                            color: Colors.blue,
                            size: 35,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Users',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '1,250',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Custom bar used to create the chart
class ChartBar extends StatelessWidget {
  final String label;
  final double height;
  final Color color;

  const ChartBar({
    super.key,
    required this.label,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 35,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}