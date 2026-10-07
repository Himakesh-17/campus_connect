import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock_data.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 50, color: AppColors.white),
            ),
            const SizedBox(height: 16),
            Text(user.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('${user.department} • ${user.year}', style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Posts', user.postsCount.toString()),
                _buildStatColumn('Clubs', user.clubsCount.toString()),
                _buildStatColumn('Events', user.eventsCount.toString()),
              ],
            ),
            const SizedBox(height: 32),
            _buildProfileListTile(Icons.post_add, 'My Posts', () {}),
            _buildProfileListTile(Icons.book_online, 'My Bookings', () {}),
            _buildProfileListTile(Icons.workspace_premium, 'My Certificates', () {}),
            _buildProfileListTile(Icons.local_activity, 'My Activity', () {}),
            _buildProfileListTile(Icons.edit, 'Edit Profile', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      ],
    );
  }

  Widget _buildProfileListTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
