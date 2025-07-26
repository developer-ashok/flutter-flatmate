import 'package:flutter/material.dart';
import '../models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF6366F1),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: CustomScrollView(
              slivers: [
                // Custom App Bar
                SliverAppBar(
                  expandedHeight: 120,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      'Flatmate Finder',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF6366F1),
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Notifications coming soon!'),
                              backgroundColor: const Color(0xFF6366F1),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // Content
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome Section
                          _buildWelcomeSection(),
                          const SizedBox(height: 32),

                          // Quick Actions
                          _buildQuickActions(),
                          const SizedBox(height: 32),

                          // Recent Posts Header
                          _buildPostsHeader(),
                          const SizedBox(height: 20),

                          // Posts List
                          ..._getDemoPosts().map((post) => PostCard(post: post)),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Find your perfect flatmate today',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.add_circle_rounded,
                title: 'Create Post',
                subtitle: 'Share your listing',
                color: const Color(0xFF6366F1),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Create Post feature coming soon!'),
                      backgroundColor: const Color(0xFF6366F1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.search_rounded,
                title: 'Search',
                subtitle: 'Find roommates',
                color: const Color(0xFF8B5CF6),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Search feature coming soon!'),
                      backgroundColor: const Color(0xFF8B5CF6),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Posts',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${_getDemoPosts().length} posts',
            style: const TextStyle(
              color: Color(0xFF6366F1),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  List<Post> _getDemoPosts() {
    return [
      Post(
        id: '1',
        type: PostType.lookingForRoom,
        title: 'Looking for roommates in Downtown',
        description: 'Professional working in tech, looking for 2-3 roommates to share a 3-bedroom apartment. Budget: \$800-1200/month.',
        rentOrBudget: 1000,
        addressOrLocation: 'Downtown, City Center',
        leaseType: '12 months',
        householdLifestyle: ['professional', 'clean', 'early riser'],
        photoUrls: [],
        userProfileId: 'user1',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: '2',
        type: PostType.offeringRoom,
        title: 'Spacious room available in student area',
        description: 'Large bedroom available in a 4-bedroom house near university. Perfect for students. Utilities included.',
        rentOrBudget: 750,
        addressOrLocation: 'University District',
        leaseType: '6 months',
        householdLifestyle: ['student', 'pet friendly', 'night owl'],
        photoUrls: [],
        userProfileId: 'user2',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Post(
        id: '3',
        type: PostType.teamUp,
        title: 'Looking for apartment hunting partner',
        description: 'Want to find a 2-bedroom apartment together? I\'m flexible on location and budget. Let\'s team up!',
        rentOrBudget: 1500,
        addressOrLocation: 'Any area',
        leaseType: 'Flexible',
        householdLifestyle: ['flexible', 'clean', 'professional'],
        photoUrls: [],
        userProfileId: 'user3',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with type badge and price
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getPostTypeGradient(widget.post.type)[0],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getPostTypeText(widget.post.type),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${widget.post.rentOrBudget.toInt()}/month',
                      style: const TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.post.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Location and time
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        widget.post.addressOrLocation,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        _getTimeAgo(widget.post.createdAt),
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Lifestyle tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.post.householdLifestyle.take(3).map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6366F1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Contact feature coming soon!'),
                                backgroundColor: const Color(0xFF6366F1),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                          icon: const Icon(Icons.message_outlined),
                          label: const Text('Contact'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6366F1),
                            side: const BorderSide(color: Color(0xFF6366F1)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_isLiked ? 'Post saved!' : 'Post unsaved'),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                          icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
                          label: Text(_isLiked ? 'Saved' : 'Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLiked ? const Color(0xFF10B981) : const Color(0xFF6366F1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Color> _getPostTypeGradient(PostType type) {
    switch (type) {
      case PostType.lookingForRoom:
        return [const Color(0xFF3B82F6)];
      case PostType.offeringRoom:
        return [const Color(0xFF10B981)];
      case PostType.teamUp:
        return [const Color(0xFFF59E0B)];
    }
  }

  String _getPostTypeText(PostType type) {
    switch (type) {
      case PostType.lookingForRoom:
        return 'Looking for Room';
      case PostType.offeringRoom:
        return 'Offering Room';
      case PostType.teamUp:
        return 'Team Up';
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
} 