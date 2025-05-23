import 'package:flutter/material.dart';
import '../../models/perfume.dart';

// Product Card Component - Reusable widget to display perfume information
class ProductCard extends StatelessWidget {
  final Perfume perfume;
  final Function(Perfume) onAddToCart;
  final double? width;
  final bool showSaleBadge;
  final VoidCallback? onTap;

  // Constructor with required and optional parameters
  const ProductCard({
    Key? key,
    required this.perfume,
    required this.onAddToCart,
    this.width,
    this.showSaleBadge = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: 12, bottom: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap ?? () => _showProductDetails(context),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImageSection(context), _buildInfoSection(context)],
          ),
        ),
      ),
    );
  }

  // Build image section with badges
  Widget _buildImageSection(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      child: Stack(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[200],
              child:
                  perfume.imageUrl.isNotEmpty
                      ? Image.network(
                        perfume.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage();
                        },
                      )
                      : _buildPlaceholderImage(),
            ),
          ),

          // Sale badge
          if (showSaleBadge && perfume.isOnSale())
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'SALE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Stock badge
          if (!perfume.isInStock)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'OUT OF STOCK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Favorite button
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey[600],
                  size: 20,
                ),
                onPressed: () {
                  // Add to favorites functionality
                  _addToFavorites(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build placeholder image
  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 40, color: Colors.grey[500]),
          SizedBox(height: 4),
          Text(
            perfume.brand,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            perfume.name,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Build info section
  Widget _buildInfoSection(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand and name
            Text(
              perfume.brand,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              perfume.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 4),

            // Rating
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < perfume.rating.floor()
                        ? Icons.star
                        : (index < perfume.rating)
                        ? Icons.star_half
                        : Icons.star_border,
                    color: Colors.amber[600],
                    size: 16,
                  );
                }),
                SizedBox(width: 4),
                Text(
                  '(${perfume.reviewCount})',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),

            SizedBox(height: 8),

            // Price and add to cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  perfume.formattedPrice,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
                _buildAddToCartButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build add to cart button
  Widget _buildAddToCartButton(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: FloatingActionButton(
        mini: true,
        backgroundColor:
            perfume.isInStock ? Colors.purple[700] : Colors.grey[400],
        onPressed: perfume.isInStock ? () => onAddToCart(perfume) : null,
        child: Icon(Icons.add_shopping_cart, size: 16, color: Colors.white),
        heroTag: 'add_to_cart_${perfume.id}', // Unique hero tag
      ),
    );
  }

  // Show product details
  void _showProductDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.8,
            maxChildSize: 0.95,
            minChildSize: 0.6,
            builder:
                (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Handle bar
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),

                        // Product image
                        Container(
                          height: 200,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[200],
                          ),
                          child:
                              perfume.imageUrl.isNotEmpty
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      perfume.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return _buildPlaceholderImage();
                                      },
                                    ),
                                  )
                                  : _buildPlaceholderImage(),
                        ),

                        SizedBox(height: 16),

                        // Product details
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Brand and name
                              Text(
                                perfume.brand,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                perfume.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),

                              SizedBox(height: 8),

                              // Rating and reviews
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index < perfume.rating.floor()
                                          ? Icons.star
                                          : (index < perfume.rating)
                                          ? Icons.star_half
                                          : Icons.star_border,
                                      color: Colors.amber[600],
                                      size: 20,
                                    );
                                  }),
                                  SizedBox(width: 8),
                                  Text(
                                    '${perfume.rating} (${perfume.reviewCount} reviews)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16),

                              // Price
                              Text(
                                perfume.formattedPrice,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[700],
                                ),
                              ),

                              SizedBox(height: 16),

                              // Description
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                perfume.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),

                              SizedBox(height: 16),

                              // Notes
                              Text(
                                'Notes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    perfume.notes.map((note) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.purple[50],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Colors.purple[200]!,
                                          ),
                                        ),
                                        child: Text(
                                          note,
                                          style: TextStyle(
                                            color: Colors.purple[700],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),

                              SizedBox(height: 24),

                              // Add to cart button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed:
                                      perfume.isInStock
                                          ? () {
                                            onAddToCart(perfume);
                                            Navigator.pop(context);
                                          }
                                          : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    perfume.isInStock
                                        ? 'Add to Cart'
                                        : 'Out of Stock',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  // Add to favorites
  void _addToFavorites(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${perfume.name} added to favorites'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.pink[600],
      ),
    );
  }
}
