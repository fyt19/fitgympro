import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<Map<String, String>> notifications = [
    {"title": "🎁 Premium avantajlarını kaçırma!", "time": "32 min ago"},
    {"title": "🤔 Nerede kalmıştık?", "time": "32 min ago"},
    {"title": "🔥 Hareket zamanı!", "time": "45 min ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showDeleteAllDialog(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Dismissible(
            key: Key(item['title']!),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (dir) => _confirmDeletion(),
            onDismissed: (dir) => setState(() => notifications.removeAt(index)),
            child: _notificationTile(item),
          );
        },
      ),
    );
  }

  void _showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.delete_outline,
              color: MyColors.primaryRed,
              size: 50,
            ),
            const SizedBox(height: 15),
            const Text(
              "Are you sure you want to delete all notifications?",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryRed,
            ),
            onPressed: () {
              setState(() => notifications.clear());
              Navigator.pop(ctx);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDeletion() async {
    return true; /* Tekli silme onayı */
  }

  Widget _notificationTile(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            item['time']!,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
