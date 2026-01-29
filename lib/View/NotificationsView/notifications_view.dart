import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  // Tasarımdaki verilerin birebir örneği
  final List<Map<String, String>> _notifications = [
    {
      "emoji": "🎁",
      "title": "Premium avantajlarını kaçırma!",
      "body":
          "Premium abonesi olarak fırsatları yakala!\nYeni egzersizlerin tadını çıkar.",
      "time": "32 minutes ago",
    },
    {
      "emoji": "🤔",
      "title": "Nerede kalmıştık?",
      "body":
          "Selam Jhon, spora dönerek eski formunu kazanmak ister misin?\nİşte sana özel seçtiğimiz 4 haftalık program",
      "time": "32 minutes ago",
    },
    {
      "emoji": "🔥",
      "title": "Hareket zamanı!",
      "body":
          "Son antrenmanın üzerinden 7 gün geçti! Hedeflerine ulaşmak için şimdi kaldığın yerden devam et! 💪",
      "time": "45 minutes ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC), // Tasarımdaki arka plan rengi
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F5FC),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.darkBg,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: MyColors.darkBg,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // 3 nokta menüsü ve Tümünü Sil seçeneği
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: MyColors.darkBg),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onSelected: (value) {
              if (value == 'delete_all') _showDeleteAllDialog();
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete_all',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: MyColors.primaryRed,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Delete All',
                      style: TextStyle(color: MyColors.primaryRed),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return _buildNotificationItem(item, index);
              },
            ),
    );
  }

  // Bildirim Kartı ve Kaydırma (Dismissible) Yapısı
  Widget _buildNotificationItem(Map<String, String> item, int index) {
    return Dismissible(
      key: Key(item['title']! + index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: MyColors.primaryRed,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      // Silme onayı sor
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (ctx) => _buildDeleteConfirmDialog(ctx, singleItem: true),
        );
      },
      // Silindiğinde listeden at
      onDismissed: (direction) {
        setState(() {
          _notifications.removeAt(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık ve Emoji
            Row(
              children: [
                Text(item['emoji']!, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: MyColors.darkBg,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Açıklama Metni
            Text(
              item['body']!,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            // Saat/Zaman
            Text(
              item['time']!,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // Tümünü Sil Dialogu Tetikleyici
  void _showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          _buildDeleteConfirmDialog(context, singleItem: false),
    );
  }

  // Ortak Silme Onay Penceresi (Tasarım: Rounded & Icon)
  Widget _buildDeleteConfirmDialog(
    BuildContext ctx, {
    required bool singleItem,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      contentPadding: const EdgeInsets.all(25),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F0),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_outline,
              color: MyColors.primaryRed,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            singleItem
                ? "Are you sure you want to delete this notification?"
                : "Are you sure you want to delete all notifications?",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.darkBg,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (!singleItem) {
                      setState(() {
                        _notifications.clear();
                      });
                    }
                    Navigator.pop(ctx, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryRed,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Text(
            "No notifications yet",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
