import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pro_ecommerce/src/features/products/data/products_repository.dart';
import 'package:pro_ecommerce/src/features/products/domain/product.dart';

// Generate a MockFirestore instance
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  QueryDocumentSnapshot
])
import 'products_repository_test.mocks.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  setUpAll(() {
    // Provide a dummy value for the Product type
    provideDummy<Product>(Product(
      id: 'dummy',
      name: 'dummy',
      description: 'dummy',
      price: 0.0,
      stock: 0,
      sellerId: 'dummy',
      status: 'dummy',
      productImg: ProductImage(name: 'dummy', url: 'dummy', publicId: ''),
      productImages: [],
      expiresOn: DateTime.now(),
      metadata: {},
      category: 'dummy',
      tags: [],
    ));
  });

  group('ProductsRepository', () {
    late MockFirebaseFirestore mockFirestore;
    late ProductsRepository productsRepository;
    late MockProductsRepository mockProductsRepository;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      productsRepository = ProductsRepository(mockFirestore);
      mockProductsRepository = MockProductsRepository();
    });

    test('fetchProducts returns a list of products', () async {
      // Create a mock query snapshot
      final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockQueryDocumentSnapshot =
          MockQueryDocumentSnapshot<Map<String, dynamic>>();

      // Mock the data returned by the query
      when(mockQueryDocumentSnapshot.data()).thenReturn({
        'id': '1',
        'name': 'Product 1',
        'description': 'Description 1',
        'price': 10.0,
        'stock': 5,
        'sellerId': '1',
        'status': 'available',
        'productImg': {'name': 'image1', 'url': 'url1'},
        'category': 'Category 1',
      });

      // Mock the documents in the query snapshot
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);

      // Mock the collection reference
      final mockCollectionReference =
          MockCollectionReference<Map<String, dynamic>>();
      when(mockCollectionReference.get())
          .thenAnswer((_) async => mockQuerySnapshot);

      // Mock the withConverter method
      when(mockCollectionReference.withConverter<Product>(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      )).thenReturn(mockCollectionReference as CollectionReference<Product>);

      // Mock the Firestore instance
      when(mockFirestore.collection(any)).thenReturn(mockCollectionReference);

      // Call the fetchProducts method
      final products = await productsRepository.fetchProducts();

      // Verify the results
      expect(products.length, 1);
      expect(products[0].name, 'Product 1');
    });

    test('fetchProducts returns a list of products', () async {
      final products = [
        Product(
            id: '1',
            name: 'Product 1',
            description: 'Description 1',
            price: 10.0,
            stock: 5,
            sellerId: '1',
            status: 'available',
            productImg: ProductImage(name: 'image1', url: 'url1', publicId: ''),
            category: 'Category 1',
            tags: [],
            productImages: [],
            expiresOn: DateTime.now(),
            metadata: {}),
      ];
      when(mockProductsRepository.fetchProducts())
          .thenAnswer((_) async => products);

      final result = await mockProductsRepository.fetchProducts();
      expect(result, products);
    });

    test('getProduct returns a product', () async {
      final product = Product(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 10.0,
        stock: 5,
        sellerId: '1',
        status: 'available',
        productImg: ProductImage(name: 'image1', url: 'url1', publicId: ''),
        category: 'Category 1',
        tags: [],
        productImages: [],
        expiresOn: DateTime.now(),
        metadata: {},
      );
      when(mockProductsRepository.getProduct('1'))
          .thenAnswer((_) async => product);

      final result = await mockProductsRepository.getProduct('1');
      expect(result, product);
    });
  });
}
