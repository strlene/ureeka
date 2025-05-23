// Perfume Model Class - Represents a perfume product
class Perfume {
  // Private properties (Encapsulation)
  final String _id;
  final String _name;
  final String _brand;
  final double _price;
  final String _description;
  final String _imageUrl;
  final String _category;
  final List<String> _notes;
  final double _rating;
  final int _reviewCount;
  final bool _isInStock;

  // Constructor with required and optional parameters
  Perfume({
    required String id,
    required String name,
    required String brand,
    required double price,
    required String description,
    required String imageUrl,
    required String category,
    required List<String> notes,
    double rating = 0.0,
    int reviewCount = 0,
    bool isInStock = true,
  }) : _id = id,
       _name = name,
       _brand = brand,
       _price = price,
       _description = description,
       _imageUrl = imageUrl,
       _category = category,
       _notes = notes,
       _rating = rating,
       _reviewCount = reviewCount,
       _isInStock = isInStock;

  // Getters (Encapsulation - controlled access to private properties)
  String get id => _id;
  String get name => _name;
  String get brand => _brand;
  double get price => _price;
  String get description => _description;
  String get imageUrl => _imageUrl;
  String get category => _category;
  List<String> get notes => List.unmodifiable(_notes); // Return immutable copy
  double get rating => _rating;
  int get reviewCount => _reviewCount;
  bool get isInStock => _isInStock;

  // Computed properties
  String get fullName => '$_brand $_name';
  String get formattedPrice => '\$${_price.toStringAsFixed(2)}';
  String get notesString => _notes.join(', ');

  // Method to check if perfume is on sale (Business logic)
  bool isOnSale() {
    return _price < 50.0; // Example: perfumes under $50 are on sale
  }

  // Method to get discount percentage
  double getDiscountPercentage(double originalPrice) {
    if (originalPrice <= _price) return 0.0;
    return ((originalPrice - _price) / originalPrice) * 100;
  }

  // Method to create a copy with modified properties (Immutability pattern)
  Perfume copyWith({
    String? id,
    String? name,
    String? brand,
    double? price,
    String? description,
    String? imageUrl,
    String? category,
    List<String>? notes,
    double? rating,
    int? reviewCount,
    bool? isInStock,
  }) {
    return Perfume(
      id: id ?? _id,
      name: name ?? _name,
      brand: brand ?? _brand,
      price: price ?? _price,
      description: description ?? _description,
      imageUrl: imageUrl ?? _imageUrl,
      category: category ?? _category,
      notes: notes ?? _notes,
      rating: rating ?? _rating,
      reviewCount: reviewCount ?? _reviewCount,
      isInStock: isInStock ?? _isInStock,
    );
  }

  // Convert to Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'brand': _brand,
      'price': _price,
      'description': _description,
      'imageUrl': _imageUrl,
      'category': _category,
      'notes': _notes,
      'rating': _rating,
      'reviewCount': _reviewCount,
      'isInStock': _isInStock,
    };
  }

  // Create from Map (Factory constructor)
  factory Perfume.fromMap(Map<String, dynamic> map) {
    return Perfume(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      notes: List<String>.from(map['notes'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      isInStock: map['isInStock'] ?? true,
    );
  }

  // String representation for debugging
  @override
  String toString() {
    return 'Perfume(id: $_id, name: $_name, brand: $_brand, price: $_price)';
  }

  // Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Perfume && other._id == _id;
  }

  @override
  int get hashCode => _id.hashCode;
}

// Enum for Perfume Categories (Better type safety)
enum PerfumeCategory { floral, woody, fresh, oriental, citrus, spicy }

// Extension to get string representation of enum
extension PerfumeCategoryExtension on PerfumeCategory {
  String get displayName {
    switch (this) {
      case PerfumeCategory.floral:
        return 'Floral';
      case PerfumeCategory.woody:
        return 'Woody';
      case PerfumeCategory.fresh:
        return 'Fresh';
      case PerfumeCategory.oriental:
        return 'Oriental';
      case PerfumeCategory.citrus:
        return 'Citrus';
      case PerfumeCategory.spicy:
        return 'Spicy';
    }
  }
}
