import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/feature_card.dart';
import '../../widgets/section_title.dart';
import '../lost_found/lost_found_screen.dart';
import '../navigation/navigation_screen.dart';
import '../clubs/clubs_screen.dart';
import '../events/events_screen.dart';
import '../events/event_detail_page.dart';
import '../bus/bus_tracker_screen.dart';
import '../notifications/notifications_screen.dart';
import '../../features/notifications/services/in_app_notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return ColoredBox(
      color: AppColors.background,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, ${user.name} 👋', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                const Text('Welcome back to Campus Connect', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
              ],
            ),
            actions: [
              Builder(
                builder: (ctx) {
                  final unread = InAppNotificationService().unreadCount;
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                      ),
                      if (unread > 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                            child: Text(
                              unread > 9 ? '9+' : '$unread',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
              children: [
                FeatureCard(title: 'Lost & Found', subtitle: 'Find items', icon: Icons.inventory_2, iconBgColor: AppColors.featureIconBg1, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LostFoundScreen()))),
                FeatureCard(title: 'Navigation', subtitle: 'Find locations', icon: Icons.navigation_rounded, iconBgColor: AppColors.featureIconBg2, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NavigationScreen()))),
                FeatureCard(title: 'Clubs', subtitle: 'Join clubs', icon: Icons.groups, iconBgColor: AppColors.featureIconBg3, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClubsScreen()))),
                FeatureCard(title: 'Events', subtitle: 'Upcoming', icon: Icons.event, iconBgColor: AppColors.featureIconBg4, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen()))),
                FeatureCard(title: 'Bus Tracker', subtitle: 'Track buses', icon: Icons.directions_bus, iconBgColor: AppColors.featureIconBg5, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BusTrackerScreen()))),
              ],
            ),

            const SizedBox(height: 32),
            SectionTitle(title: 'Upcoming Events', actionText: 'View All', onActionPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen()));
            }),
            const SizedBox(height: 16),
            ...MockData.events.take(2).map((event) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: AppColors.featureIconBg1, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.event, color: AppColors.primary),
                    ),
                    title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${event.timeString} • ${event.location}', style: const TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => EventDetailPage(event: event)));
                    },
                  ),
                )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
