import 'package:flutter/material.dart';
import '../models/post.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  PostType? _selectedType;
  String? _selectedLocation;
  double? _maxBudget;
  List<String> _selectedLifestyleTags = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _locations = [
    'Downtown',
    'University District',
    'Suburbs',
    'City Center',
    'West Side',
    'East Side',
  ];

  final List<String> _lifestyleTags = [
    'professional',
    'student',
    'clean',
    'pet friendly',
    'smoker',
    'night owl',
    'early riser',
    'remote worker',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            child: Column(
              children: [
                // Search Header
                _buildSearchHeader(),
                
                // Content
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Active Filters
                        if (_hasActiveFilters()) _buildActiveFilters(),
                        
                        // Results
                        Expanded(
                          child: _getFilteredPosts().isEmpty
                              ? _buildEmptyState()
                              : _buildResultsList(),
                        ),
                      ],
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

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Title and Filter Button
          Row(
            children: [
              const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.tune_rounded, color: Colors.white),
                  onPressed: _showFilterDialog,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search posts, locations, or keywords...',
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF6366F1)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onChanged: (value) => _performSearch(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Active Filters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearAllFilters,
                child: const Text(
                  'Clear All',
                  style: TextStyle(color: Color(0xFF6366F1)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (_selectedType != null)
                _buildFilterChip(
                  _getPostTypeText(_selectedType!),
                  () {
                    setState(() {
                      _selectedType = null;
                    });
                    _performSearch();
                  },
                ),
              if (_selectedLocation != null)
                _buildFilterChip(
                  _selectedLocation!,
                  () {
                    setState(() {
                      _selectedLocation = null;
                    });
                    _performSearch();
                  },
                ),
              if (_maxBudget != null)
                _buildFilterChip(
                  '\$${_maxBudget!.toInt()}/month',
                  () {
                    setState(() {
                      _maxBudget = null;
                    });
                    _performSearch();
                  },
                ),
              ..._selectedLifestyleTags.map((tag) => _buildFilterChip(
                tag,
                () {
                  setState(() {
                    _selectedLifestyleTags.remove(tag);
                  });
                  _performSearch();
                },
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDeleted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDeleted,
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 16,
            ),
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Color(0xFF6366F1),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No posts found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search criteria',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getFilteredPosts().length,
      itemBuilder: (context, index) {
        final post = _getFilteredPosts()[index];
        return PostCard(post: post);
      },
    );
  }

  bool _hasActiveFilters() {
    return _selectedType != null ||
        _selectedLocation != null ||
        _maxBudget != null ||
        _selectedLifestyleTags.isNotEmpty;
  }

  void _performSearch() {
    setState(() {
      // This would trigger a rebuild with filtered results
    });
  }

  void _clearAllFilters() {
    setState(() {
      _selectedType = null;
      _selectedLocation = null;
      _maxBudget = null;
      _selectedLifestyleTags.clear();
    });
    _performSearch();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterSheet(),
    );
  }

  Widget _buildFilterSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Post Type
              _buildFilterSection(
                'Post Type',
                Wrap(
                  spacing: 8,
                  children: PostType.values.map((type) => ChoiceChip(
                    label: Text(_getPostTypeText(type)),
                    selected: _selectedType == type,
                    onSelected: (selected) {
                      setState(() {
                        _selectedType = selected ? type : null;
                      });
                    },
                    selectedColor: const Color(0xFF6366F1),
                    checkmarkColor: Colors.white,
                  )).toList(),
                ),
              ),

              // Location
              _buildFilterSection(
                'Location',
                DropdownButtonFormField<String>(
                  value: _selectedLocation,
                  hint: const Text('Select location'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: _locations.map((location) => DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLocation = value;
                    });
                  },
                ),
              ),

              // Budget
              _buildFilterSection(
                'Max Budget',
                Column(
                  children: [
                    Slider(
                      value: _maxBudget ?? 2000,
                      min: 500,
                      max: 3000,
                      divisions: 25,
                      activeColor: const Color(0xFF6366F1),
                      label: '\$${(_maxBudget ?? 2000).toInt()}/month',
                      onChanged: (value) {
                        setState(() {
                          _maxBudget = value;
                        });
                      },
                    ),
                    Text(
                      '\$${(_maxBudget ?? 2000).toInt()}/month',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6366F1),
                      ),
                    ),
                  ],
                ),
              ),

              // Lifestyle Tags
              _buildFilterSection(
                'Lifestyle',
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _lifestyleTags.map((tag) => FilterChip(
                    label: Text(tag),
                    selected: _selectedLifestyleTags.contains(tag),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedLifestyleTags.add(tag);
                        } else {
                          _selectedLifestyleTags.remove(tag);
                        }
                      });
                    },
                    selectedColor: const Color(0xFF6366F1),
                    checkmarkColor: Colors.white,
                  )).toList(),
                ),
              ),

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _clearAllFilters();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF6366F1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: Color(0xFF6366F1)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _performSearch();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        content,
        const SizedBox(height: 24),
      ],
    );
  }

  List<Post> _getFilteredPosts() {
    List<Post> posts = _getDemoPosts();

    // Filter by search text
    if (_searchController.text.isNotEmpty) {
      posts = posts.where((post) =>
        post.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        post.description.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        post.addressOrLocation.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    // Filter by post type
    if (_selectedType != null) {
      posts = posts.where((post) => post.type == _selectedType).toList();
    }

    // Filter by location
    if (_selectedLocation != null) {
      posts = posts.where((post) => 
        post.addressOrLocation.toLowerCase().contains(_selectedLocation!.toLowerCase())
      ).toList();
    }

    // Filter by budget
    if (_maxBudget != null) {
      posts = posts.where((post) => post.rentOrBudget <= _maxBudget!).toList();
    }

    // Filter by lifestyle tags
    if (_selectedLifestyleTags.isNotEmpty) {
      posts = posts.where((post) =>
        _selectedLifestyleTags.any((tag) => post.householdLifestyle.contains(tag))
      ).toList();
    }

    return posts;
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
      Post(
        id: '4',
        type: PostType.offeringRoom,
        title: 'Cozy studio in West Side',
        description: 'Beautiful studio apartment available for rent. Perfect for professionals. Near public transport.',
        rentOrBudget: 1200,
        addressOrLocation: 'West Side',
        leaseType: '12 months',
        householdLifestyle: ['professional', 'clean', 'remote worker'],
        photoUrls: [],
        userProfileId: 'user4',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Post(
        id: '5',
        type: PostType.lookingForRoom,
        title: 'Student looking for room in University District',
        description: 'Graduate student looking for a room near campus. Budget is flexible. Prefer quiet environment.',
        rentOrBudget: 800,
        addressOrLocation: 'University District',
        leaseType: '9 months',
        householdLifestyle: ['student', 'quiet', 'early riser'],
        photoUrls: [],
        userProfileId: 'user5',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
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