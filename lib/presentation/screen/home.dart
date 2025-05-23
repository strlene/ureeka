import 'package:flutter/material.dart';
import '../../models/perfume.dart';
import '../../models/perfume_service.dart';
import '../../models/cart.dart';
import '../component/product_cart.dart';

// Home Screen - Main screen showing featured perfumes and categories
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PerfumeService _perfumeService = PerfumeService();
  final ShoppingCart _cart = ShoppingCart();

  List<Perfume> _featuredPerfumes = [];
  List<Perfume> _onSalePerfumes = [];
  List<String> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from service
  void _loadData() {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _featuredPerfumes = _perfumeService.getFeaturedPerfumes();
        _onSalePerfumes = _perfumeService.getOnSalePerfumes();
        _categories = _perfumeService.getCategories();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingWidget() : _buildBody(),
    );
  }

  // Build app bar with search and cart icons
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Perfume Market',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.purple[700],
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            // Navigate to search would be implemented here
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                // Navigate to cart would be implemented here
              },
            ),
            if (_cart.totalQuantity > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '${_cart.totalQuantity}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Build loading widget
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
          SizedBox(height: 16),
          Text(
            'Loading perfumes...',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // Build main body
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeBanner(),
          _buildCategoriesSection(),
          _buildFeaturedSection(),
          _buildOnSaleSection(),
        ],
      ),
    );
  }

  // Build welcome banner
  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[700]!, Colors.purple[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover Your',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Perfect Fragrance',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Explore our premium collection of perfumes',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Build categories section
  Widget _buildCategoriesSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(_categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build category card
  Widget _buildCategoryCard(String category) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            // Navigate to category products
            _showCategoryProducts(category);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.purple[100]!, Colors.purple[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getCategoryIcon(category),
                  size: 32,
                  color: Colors.purple[700],
                ),
                SizedBox(height: 8),
                Text(
                  category,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Get icon for category
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'floral':
        return Icons.local_florist;
      case 'woody':
        return Icons.nature;
      case 'fresh':
        return Icons.air;
      case 'oriental':
        return Icons.star;
      case 'citrus':
        return Icons.wb_sunny;
      case 'spicy':
        return Icons.whatshot;
      default:
        return Icons.category;
    }
  }

  // Build featured section
  Widget _buildFeaturedSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Perfumes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all featured
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredPerfumes.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  perfume: _featuredPerfumes[index],
                  onAddToCart: (perfume) => _addToCart(perfume),
                  width: 200,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build on sale section
  Widget _buildOnSaleSection() {
    if (_onSalePerfumes.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer, color: Colors.orange[700], size: 24),
              SizedBox(width: 8),
              Text(
                'On Sale',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _onSalePerfumes.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  perfume: _onSalePerfumes[index],
                  onAddToCart: (perfume) => _addToCart(perfume),
                  width: 200,
                  showSaleBadge: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Add to cart method
  void _addToCart(Perfume perfume) {
    setState(() {
      _cart.addItem(perfume);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${perfume.name} added to cart'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }

  // Show category products
  void _showCategoryProducts(String category) {
    final categoryPerfumes = _perfumeService.getPerfumesByCategory(category);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder:
                (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              color: Colors.purple[700],
                            ),
                            SizedBox(width: 8),
                            Text(
                              '$category Perfumes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: categoryPerfumes.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              perfume: categoryPerfumes[index],
                              onAddToCart: (perfume) => _addToCart(perfume),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}
