import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro_ecommerce/src/features/wishlist/data/wishlist_repository.dart';
import 'package:pro_ecommerce/src/features/wishlist/domain/wishlist_item.dart';

class MockWishlistRepository extends Mock implements WishlistRepository {}

void main() {
  group('WishlistRepository', () {
    late MockWishlistRepository mockWishlistRepository;

    setUp(() {
      mockWishlistRepository = MockWishlistRepository();
    });

    test('addWishlistItem adds an item to the wishlist', () async {
      await mockWishlistRepository.addWishlistItem(userId: '1', productId: '1');
      verify(mockWishlistRepository.addWishlistItem(
              userId: '1', productId: '1'))
          .called(1);
    });

    test('removeWishlistItem removes an item from the wishlist', () async {
      await mockWishlistRepository.removeWishlistItem(
          userId: '1', productId: '1');
      verify(mockWishlistRepository.removeWishlistItem(
              userId: '1', productId: '1'))
          .called(1);
    });

    test('watchUserWishlist returns a stream of wishlist items', () {
      final wishlistItems = [
        WishlistItem(
            id: '1', productId: '1', userId: '1', addedAt: DateTime.now()),
      ];
      when(mockWishlistRepository.watchUserWishlist('1'))
          .thenAnswer((_) => Stream.value(wishlistItems));

      final result = mockWishlistRepository.watchUserWishlist('1');
      expect(result, emits(wishlistItems));
    });
  });
}
