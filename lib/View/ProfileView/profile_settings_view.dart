import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: MyColors.darkBg),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Profile Settings",
          style: TextStyle(color: MyColors.darkBg, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profil Resmi Düzenleme
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/profile_user.jpg"),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: MyColors.primaryRed,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Jhon Doe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "jhondoe@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            _buildSectionTitle("Basic Detail"),
            _buildTextField("Full Name", "Jhon Doe"),
            _buildDropdown("Date of Birth", "1 Nov 2000"),
            _buildTextField("Change Password", "*******", obscureText: true),

            const SizedBox(height: 20),
            _buildSectionTitle("Contact Detail"),
            _buildTextField("E-mail", "jhondoe@gmail.com"),

            const SizedBox(height: 20),
            _buildSectionTitle("Personal Detail"),
            _buildTextField("Weight (kg)", "80"),
            _buildTextField("Height (cm)", "186.5"),

            const SizedBox(height: 40),

            // BUTONLAR
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.darkBg,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildOutlineButton("Logout", Colors.black)),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildOutlineButton(
                    "Delete Account",
                    MyColors.primaryRed,
                    isSolid: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String value, {
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: value,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontSize: 16)),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildOutlineButton(String text, Color color, {bool isSolid = false}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSolid ? color : Colors.white,
        foregroundColor: isSolid ? Colors.white : color,
        side: isSolid ? null : const BorderSide(color: Colors.grey),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Text(text),
    );
  }
}
