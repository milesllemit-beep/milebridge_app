import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MileBridge Hub", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        actions: [IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15, 
                mainAxisSpacing: 15,
                children: [
                  _hubCard(context, "Live\nTranslator", Icons.camera_alt, Colors.blue.shade100, '/translator'),
                  _hubCard(context, "Learn Sign\nLanguage", Icons.school, Colors.green.shade100, '/learn'),
                  _hubCard(context, "Messenger\nBridge", Icons.chat_bubble, Colors.indigo.shade100, '/messenger'),
                  _hubCard(context, "Emotional\nSupport", Icons.favorite, Colors.pink.shade100, '/support'),
                ],
              ),
            ),
            const Text("Quick Modes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _quickBtn(context, "Hospital", Icons.local_hospital, Colors.blue),
                _sosBtn(context),
                _quickBtn(context, "School", Icons.history_edu, Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _hubCard(BuildContext context, String label, IconData icon, Color col, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: Colors.black54),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _sosBtn(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: "sos",
          backgroundColor: Colors.red,
          onPressed: () => _showSOSDialog(context),
          child: const Icon(Icons.warning, color: Colors.white),
        ),
        const Text("SOS HELP", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget _quickBtn(BuildContext context, String label, IconData icon, Color col) {
    return Column(
      children: [
        // FIXED: Modern color values for the avatar background
        CircleAvatar(backgroundColor: col.withValues(alpha: 0.2), child: Icon(icon, color: col)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showSOSDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const SOSBottomSheet(),
    );
  }
}

class SOSBottomSheet extends StatelessWidget {
  const SOSBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("SOS EMERGENCY MODE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.red.shade50,
            child: const Text("SOS MODE IS ACTIVE! YOUR LOCATION IS BEING SENT.", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: Center(child: Icon(Icons.map, size: 200, color: Colors.grey))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _sosAction(Icons.sms, "SEND SMS", Colors.red),
              _sosAction(Icons.lightbulb, "FLASH LIGHT", Colors.orange),
              _sosAction(Icons.videocam, "RECORDING", Colors.amber),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 50)),
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL SOS", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _sosAction(IconData icon, String label, Color col) {
    return Column(
      children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}