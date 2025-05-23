import 'perfume.dart';

// Perfume Service Class - Handles all perfume data operations (Singleton Pattern)
class PerfumeService {
  // Private constructor for Singleton pattern
  PerfumeService._privateConstructor();

  // Single instance
  static final PerfumeService _instance = PerfumeService._privateConstructor();

  // Factory constructor returns the same instance
  factory PerfumeService() => _instance;

  // Private list to store perfumes
  final List<Perfume> _perfumes = [];

  // Initialize with sample data
  void _initializeSampleData() {
    if (_perfumes.isEmpty) {
      _perfumes.addAll([
        Perfume(
          id: '1',
          name: 'Sauvage',
          brand: 'Dior',
          price: 89.99,
          description: 'A fresh and spicy fragrance with bergamot and pepper.',
          imageUrl:
              'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTb2EwxPF_DI6FQ0gh9wXr1bhaUZFZqtW60rjOIKBms4isQBjQH8cGDM-g4g-k99suYbKY-mT3zhyD0uYo6ZpJ40N5KDqr8MC1X3irCwkMGC_4dnfT-EMTp',
          category: 'Fresh',
          notes: ['Bergamot', 'Pepper', 'Ambroxan'],
          rating: 4.5,
          reviewCount: 1250,
          isInStock: true,
        ),
        Perfume(
          id: '2',
          name: 'Bleu de Chanel',
          brand: 'Chanel',
          price: 125.00,
          description: 'An aromatic-woody fragrance that embodies freedom.',
          imageUrl:
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSM-KcFPCODujFhvNZ44-IAlm7JDFIMACaVy46iAbAxC2DB7jWnn9hkmUuD0vKyFAMJ6-jluhLonw9EITYZxv0zWEY1cr-7FVFE21E4Nnn5WCfZQCAXPFYy',
          category: 'Woody',
          notes: ['Citrus', 'Cedar', 'Sandalwood'],
          rating: 4.7,
          reviewCount: 980,
          isInStock: true,
        ),
        Perfume(
          id: '3',
          name: 'La Vie Est Belle',
          brand: 'Lancôme',
          price: 95.50,
          description: 'A sweet and floral fragrance celebrating happiness.',
          imageUrl:
              'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTZVRybN7Qd_SdZXQw_m4OkMeA4hFkDO_Oo-XxVahMGnNKY-aOokXlWvuqvAutdelpmXHhkuRZR66D0Y4ZW73_17sLd3cVZb5qNMOXwei7vnlX09_4AnSUMj88',
          category: 'Floral',
          notes: ['Iris', 'Praline', 'Vanilla'],
          rating: 4.3,
          reviewCount: 1500,
          isInStock: true,
        ),
        Perfume(
          id: '4',
          name: 'Acqua di Gio',
          brand: 'Giorgio Armani',
          price: 76.99,
          description: 'A marine fragrance inspired by the Mediterranean.',
          imageUrl:
              'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTCCfyKwuB0cPsvKYriH4OfzyoKiP3RsZF0kIOo3oZCFcWY3QskKRqo2ZSrfO6AM054aAP6V_Tdsa7EBdFAeXCPuMhziIOtvFuRoG_bFb--UeKID3jnF6DueWs',
          category: 'Fresh',
          notes: ['Marine Notes', 'Bergamot', 'Cedar'],
          rating: 4.4,
          reviewCount: 2100,
          isInStock: true,
        ),
        Perfume(
          id: '5',
          name: 'Black Opium',
          brand: 'Yves Saint Laurent',
          price: 108.00,
          description: 'A modern take on oriental fragrance with coffee notes.',
          imageUrl:
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTKpDTUEIyW5HfSHjKe2iczCoMl3BHnywWySc-eT7og12kS1hsgzX2ofFyuZUWu27pWODcm8yNl83iZVUQk3m7FvEBrtDFjMKuF9TLlcQ6pm2D9RlspYAqrZr52',
          category: 'Oriental',
          notes: ['Coffee', 'Vanilla', 'White Flowers'],
          rating: 4.6,
          reviewCount: 890,
          isInStock: false,
        ),
        Perfume(
          id: '6',
          name: 'Light Blue',
          brand: 'Dolce & Gabbana',
          price: 69.99,
          description: 'A fresh Mediterranean breeze in a bottle.',
          imageUrl:
              'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRvL3fon439vkWbP7FjwSV3cWvAMMFq37MM0f8ktvzG14GRItEAmzL2EKKjckgLSlEY5_0tGDUJqtyei9DTJPA45wJSpCgFO9r-mqyVz0Ihra42NBgL1o8IKtY',
          category: 'Citrus',
          notes: ['Sicilian Lemon', 'Apple', 'Cedar'],
          rating: 4.2,
          reviewCount: 1200,
          isInStock: true,
        ),
        Perfume(
          id: '7',
          name: 'Spicebomb',
          brand: 'Viktor & Rolf',
          price: 92.50,
          description: 'An explosive spicy fragrance for the modern man.',
          imageUrl:
              'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQq-ApCzMvRG5qnpWzgdJyTph9O3lX1hGHfPvaQfmXiOLSFhJ86ClmT4UtPDaiKPu8WVC7x6s8iEy55ejkqshtJ6eVSusfrCoCFJm8m88brqz98O6_s7mp2XA',
          category: 'Spicy',
          notes: ['Chili', 'Saffron', 'Tobacco'],
          rating: 4.1,
          reviewCount: 650,
          isInStock: true,
        ),
        Perfume(
          id: '8',
          name: 'Flower Bomb',
          brand: 'Viktor & Rolf',
          price: 118.00,
          description: 'A floral explosion of cattleya orchid and jasmine.',
          imageUrl:
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSBKe-I2vk4wuFOE9rn9YNQlR7u3L4-Fp-YUyZNZrnM4YrEx8cPFTWIqOLVR561FVinIoG3UV_0kWb3Qdz6H3O02DEb4go9xL0AVxBxxOV6uBW82h0LmHhX',
          category: 'Floral',
          notes: ['Orchid', 'Jasmine', 'Rose'],
          rating: 4.5,
          reviewCount: 1100,
          isInStock: true,
        ),
      ]);
    }
  }

  // Get all perfumes
  List<Perfume> getAllPerfumes() {
    _initializeSampleData();
    return List.unmodifiable(_perfumes);
  }

  // Get perfume by ID
  Perfume? getPerfumeById(String id) {
    _initializeSampleData();
    try {
      return _perfumes.firstWhere((perfume) => perfume.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get perfumes by category
  List<Perfume> getPerfumesByCategory(String category) {
    _initializeSampleData();
    return _perfumes
        .where(
          (perfume) => perfume.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }

  // Get perfumes by brand
  List<Perfume> getPerfumesByBrand(String brand) {
    _initializeSampleData();
    return _perfumes
        .where((perfume) => perfume.brand.toLowerCase() == brand.toLowerCase())
        .toList();
  }

  // Search perfumes by name or brand
  List<Perfume> searchPerfumes(String query) {
    _initializeSampleData();
    if (query.isEmpty) return getAllPerfumes();

    final lowercaseQuery = query.toLowerCase();
    return _perfumes.where((perfume) {
      return perfume.name.toLowerCase().contains(lowercaseQuery) ||
          perfume.brand.toLowerCase().contains(lowercaseQuery) ||
          perfume.description.toLowerCase().contains(lowercaseQuery) ||
          perfume.notes.any(
            (note) => note.toLowerCase().contains(lowercaseQuery),
          );
    }).toList();
  }

  // Get featured perfumes (top rated or on sale)
  List<Perfume> getFeaturedPerfumes() {
    _initializeSampleData();
    return _perfumes
        .where((perfume) => perfume.rating >= 4.3 || perfume.isOnSale())
        .take(5)
        .toList();
  }

  // Get perfumes on sale
  List<Perfume> getOnSalePerfumes() {
    _initializeSampleData();
    return _perfumes.where((perfume) => perfume.isOnSale()).toList();
  }

  // Get in-stock perfumes only
  List<Perfume> getInStockPerfumes() {
    _initializeSampleData();
    return _perfumes.where((perfume) => perfume.isInStock).toList();
  }

  // Get unique categories
  List<String> getCategories() {
    _initializeSampleData();
    return _perfumes.map((perfume) => perfume.category).toSet().toList();
  }

  // Get unique brands
  List<String> getBrands() {
    _initializeSampleData();
    return _perfumes.map((perfume) => perfume.brand).toSet().toList();
  }

  // Sort perfumes by different criteria
  List<Perfume> sortPerfumes(List<Perfume> perfumes, SortOption sortOption) {
    final sortedList = List<Perfume>.from(perfumes);

    switch (sortOption) {
      case SortOption.priceAscending:
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDescending:
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.ratingDescending:
        sortedList.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.nameAscending:
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.brandAscending:
        sortedList.sort((a, b) => a.brand.compareTo(b.brand));
        break;
    }

    return sortedList;
  }

  // Filter perfumes by price range
  List<Perfume> filterByPriceRange(
    List<Perfume> perfumes,
    double minPrice,
    double maxPrice,
  ) {
    return perfumes
        .where(
          (perfume) => perfume.price >= minPrice && perfume.price <= maxPrice,
        )
        .toList();
  }
}

// Enum for sorting options
enum SortOption {
  priceAscending,
  priceDescending,
  ratingDescending,
  nameAscending,
  brandAscending,
}

// Extension to get display name for sort options
extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.priceAscending:
        return 'Price: Low to High';
      case SortOption.priceDescending:
        return 'Price: High to Low';
      case SortOption.ratingDescending:
        return 'Highest Rated';
      case SortOption.nameAscending:
        return 'Name: A to Z';
      case SortOption.brandAscending:
        return 'Brand: A to Z';
    }
  }
}
