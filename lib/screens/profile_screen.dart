import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = _getDemoUserProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        userProfile.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userProfile.displayName ?? 'User',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userProfile.email,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('Posts', '3'),
                        _buildStatItem('Saved', '12'),
                        _buildStatItem('Matches', '8'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Profile Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Age', userProfile.age?.toString() ?? 'Not specified'),
                    _buildDetailRow('Gender', userProfile.gender ?? 'Not specified'),
                    _buildDetailRow('Occupation', userProfile.occupation ?? 'Not specified'),
                    _buildDetailRow('Budget', userProfile.monthlyBudget != null ? '\$${userProfile.monthlyBudget!.toInt()}/month' : 'Not specified'),
                    _buildDetailRow('Move-in Date', userProfile.preferredMoveInDate != null ? _formatDate(userProfile.preferredMoveInDate!) : 'Not specified'),
                    if (userProfile.preferredLocations != null && userProfile.preferredLocations!.isNotEmpty)
                      _buildDetailRow('Preferred Locations', userProfile.preferredLocations!.join(', ')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Lifestyle Tags
            if (userProfile.lifestyleTags != null && userProfile.lifestyleTags!.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lifestyle',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: userProfile.lifestyleTags!.map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // My Posts
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Posts',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('View all posts coming soon!')),
                            );
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._getDemoPosts().map((post) => _buildPostItem(post)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Settings & Actions
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit profile coming soon!')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notifications settings coming soon!')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('Privacy'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy settings coming soon!')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Help & support coming soon!')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          post['title'],
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post['description'], maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getPostTypeColor(post['type']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    post['type'],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '\$${post['rent']}/month',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            // Handle menu selection
          },
        ),
      ),
    );
  }

  Color _getPostTypeColor(String type) {
    switch (type) {
      case 'Looking for Room':
        return Colors.blue;
      case 'Offering Room':
        return Colors.green;
      case 'Team Up':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate back to login screen
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  UserProfile _getDemoUserProfile() {
    return UserProfile(
      uid: 'currentUser',
      email: 'demo@example.com',
      displayName: 'John Doe',
      age: 28,
      gender: 'Male',
      occupation: 'Software Engineer',
      monthlyBudget: 1200,
      lifestyleTags: ['professional', 'clean', 'early riser', 'remote worker'],
      preferredMoveInDate: DateTime.now().add(const Duration(days: 30)),
      preferredLocations: ['Downtown', 'University District'],
      photoUrl: null,
      isEmailVerified: true,
    );
  }

  List<Map<String, dynamic>> _getDemoPosts() {
    return [
      {
        'title': 'Looking for roommates in Downtown',
        'description': 'Professional working in tech, looking for 2-3 roommates to share a 3-bedroom apartment.',
        'type': 'Looking for Room',
        'rent': 1000,
      },
      {
        'title': 'Spacious room available in student area',
        'description': 'Large bedroom available in a 4-bedroom house near university. Perfect for students.',
        'type': 'Offering Room',
        'rent': 750,
      },
    ];
  }
} 