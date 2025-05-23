import 'perfume.dart';

// Cart Item Class - Represents an item in the shopping cart
class CartItem {
  final Perfume _perfume;
  int _quantity;

  // Constructor
  CartItem({required Perfume perfume, int quantity = 1})
    : _perfume = perfume,
      _quantity = quantity;

  // Getters
  Perfume get perfume => _perfume;
  int get quantity => _quantity;
  double get totalPrice => _perfume.price * _quantity;
  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  // Methods to modify quantity
  void increaseQuantity() {
    _quantity++;
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }
  }

  void setQuantity(int newQuantity) {
    if (newQuantity > 0) {
      _quantity = newQuantity;
    }
  }

  // Create copy with new quantity
  CartItem copyWith({int? quantity}) {
    return CartItem(perfume: _perfume, quantity: quantity ?? _quantity);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other._perfume.id == _perfume.id;
  }

  @override
  int get hashCode => _perfume.id.hashCode;
}

// Shopping Cart Class - Manages all cart operations
class ShoppingCart {
  final List<CartItem> _items = [];

  // Getters
  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.length;
  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.08; // 8% tax
  double get shipping => subtotal > 50 ? 0.0 : 5.99; // Free shipping over $50
  double get total => subtotal + tax + shipping;

  // Formatted getters
  String get formattedSubtotal => '\$${subtotal.toStringAsFixed(2)}';
  String get formattedTax => '\$${tax.toStringAsFixed(2)}';
  String get formattedShipping =>
      shipping == 0 ? 'FREE' : '\$${shipping.toStringAsFixed(2)}';
  String get formattedTotal => '\$${total.toStringAsFixed(2)}';

  // Check if cart is empty
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  // Add item to cart
  void addItem(Perfume perfume, {int quantity = 1}) {
    // Check if item already exists in cart
    final existingItemIndex = _items.indexWhere(
      (item) => item.perfume.id == perfume.id,
    );

    if (existingItemIndex >= 0) {
      // Item exists, increase quantity
      _items[existingItemIndex].setQuantity(
        _items[existingItemIndex].quantity + quantity,
      );
    } else {
      // New item, add to cart
      _items.add(CartItem(perfume: perfume, quantity: quantity));
    }
  }

  // Remove item from cart
  void removeItem(String perfumeId) {
    _items.removeWhere((item) => item.perfume.id == perfumeId);
  }

  // Update item quantity
  void updateItemQuantity(String perfumeId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(perfumeId);
      return;
    }

    final itemIndex = _items.indexWhere((item) => item.perfume.id == perfumeId);

    if (itemIndex >= 0) {
      _items[itemIndex].setQuantity(newQuantity);
    }
  }

  // Increase item quantity by 1
  void increaseItemQuantity(String perfumeId) {
    final itemIndex = _items.indexWhere((item) => item.perfume.id == perfumeId);

    if (itemIndex >= 0) {
      _items[itemIndex].increaseQuantity();
    }
  }

  // Decrease item quantity by 1
  void decreaseItemQuantity(String perfumeId) {
    final itemIndex = _items.indexWhere((item) => item.perfume.id == perfumeId);

    if (itemIndex >= 0) {
      if (_items[itemIndex].quantity == 1) {
        removeItem(perfumeId);
      } else {
        _items[itemIndex].decreaseQuantity();
      }
    }
  }

  // Check if perfume is in cart
  bool containsPerfume(String perfumeId) {
    return _items.any((item) => item.perfume.id == perfumeId);
  }

  // Get quantity of specific perfume in cart
  int getPerfumeQuantity(String perfumeId) {
    final item = _items.firstWhere(
      (item) => item.perfume.id == perfumeId,
      orElse:
          () => CartItem(
            perfume: Perfume(
              id: '',
              name: '',
              brand: '',
              price: 0,
              description: '',
              imageUrl: '',
              category: '',
              notes: [],
            ),
            quantity: 0,
          ),
    );
    return item.quantity;
  }

  // Clear all items from cart
  void clearCart() {
    _items.clear();
  }

  // Get cart summary
  Map<String, dynamic> getCartSummary() {
    return {
      'itemCount': itemCount,
      'totalQuantity': totalQuantity,
      'subtotal': subtotal,
      'tax': tax,
      'shipping': shipping,
      'total': total,
    };
  }
}
