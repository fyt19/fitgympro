import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/my_colors.dart';
import '../../Riverpod/Controllers/all_controllers.dart';
import 'profile_settings_view.dart';
import 'invite_friends_view.dart';
import 'faq_view.dart';
import 'body_scan_flow_view.dart'; // Body Scan akışı
import 'stats_view.dart'; // Placeholder
import 'language_view.dart'; // Placeholder

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(AllControllers.profileController);
    final controller = ref.read(AllControllers.profileController.notifier);

    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Profile",
            style: TextStyle(
              color: MyColors.darkBg,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // PROFİL FOTOSU VE İSİM
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profileState.photoUrl),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    profileState.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBg,
                    ),
                  ),
                  Text(
                    profileState.email,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // İSTATİSTİKLER (3'lü Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(Icons.access_time, "2h 30m", "Total Time"),
                _buildStatItem(
                  Icons.local_fire_department,
                  "7200 kcal",
                  "Burned",
                ),
                _buildStatItem(Icons.emoji_events_outlined, "28", "Done"),
              ],
            ),

            const SizedBox(height: 30),

            // 1. MENÜ GRUBU
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    Icons.person,
                    "Profile Settings",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const ProfileSettingsView(),
                      ),
                    ),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.bar_chart,
                    "Stats",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const StatsView()),
                    ),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.center_focus_strong,
                    "Ai Body Scan",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const BodyScanIntroView(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // PREMIUM KARTI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, color: Colors.amber, size: 30),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "Premium",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.amber),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. MENÜ GRUBU (Bildirimler vb.)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSwitchItem(
                    "Notifications",
                    profileState.notificationsEnabled,
                    (val) => controller.toggleNotifications(val),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.person_add_alt_1,
                    "Share with Friends",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const InviteFriendsView(),
                      ),
                    ),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.help_outline,
                    "FAQ",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const FAQView()),
                    ),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.language,
                    "App Language",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const LanguageView()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100), // Navbar payı
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String val, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Icon(icon, color: MyColors.primaryRed),
        ),
        const SizedBox(height: 8),
        Text(
          val,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: MyColors.darkBg),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: MyColors.darkBg,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: const Icon(Icons.notifications_active, color: MyColors.darkBg),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: MyColors.darkBg,
        ),
      ),
      trailing: CupertinoSwitch(
        value: value,
        activeColor: MyColors.primaryRed,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() =>
      const Divider(height: 1, indent: 20, endIndent: 20, color: Colors.grey);
}
