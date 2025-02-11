// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerOrderRepositoryHash() =>
    r'dfb5806424c106c552bb7d71a5542f8d789fad79';

/// See also [customerOrderRepository].
@ProviderFor(customerOrderRepository)
final customerOrderRepositoryProvider =
    AutoDisposeProvider<CustomerOrderRepository>.internal(
  customerOrderRepository,
  name: r'customerOrderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerOrderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomerOrderRepositoryRef
    = AutoDisposeProviderRef<CustomerOrderRepository>;
String _$customerOrderStreamHash() =>
    r'72edc95e3651c1379aacac6f3a4648691e7982a4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [customerOrderStream].
@ProviderFor(customerOrderStream)
const customerOrderStreamProvider = CustomerOrderStreamFamily();

/// See also [customerOrderStream].
class CustomerOrderStreamFamily extends Family<AsyncValue<CustomerOrder>> {
  /// See also [customerOrderStream].
  const CustomerOrderStreamFamily();

  /// See also [customerOrderStream].
  CustomerOrderStreamProvider call(
    String orderId,
  ) {
    return CustomerOrderStreamProvider(
      orderId,
    );
  }

  @override
  CustomerOrderStreamProvider getProviderOverride(
    covariant CustomerOrderStreamProvider provider,
  ) {
    return call(
      provider.orderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customerOrderStreamProvider';
}

/// See also [customerOrderStream].
class CustomerOrderStreamProvider
    extends AutoDisposeStreamProvider<CustomerOrder> {
  /// See also [customerOrderStream].
  CustomerOrderStreamProvider(
    String orderId,
  ) : this._internal(
          (ref) => customerOrderStream(
            ref as CustomerOrderStreamRef,
            orderId,
          ),
          from: customerOrderStreamProvider,
          name: r'customerOrderStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerOrderStreamHash,
          dependencies: CustomerOrderStreamFamily._dependencies,
          allTransitiveDependencies:
              CustomerOrderStreamFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  CustomerOrderStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    Stream<CustomerOrder> Function(CustomerOrderStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomerOrderStreamProvider._internal(
        (ref) => create(ref as CustomerOrderStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<CustomerOrder> createElement() {
    return _CustomerOrderStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerOrderStreamProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomerOrderStreamRef on AutoDisposeStreamProviderRef<CustomerOrder> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _CustomerOrderStreamProviderElement
    extends AutoDisposeStreamProviderElement<CustomerOrder>
    with CustomerOrderStreamRef {
  _CustomerOrderStreamProviderElement(super.provider);

  @override
  String get orderId => (origin as CustomerOrderStreamProvider).orderId;
}

String _$customerOrdersStreamHash() =>
    r'fa697caf5fc091d4f9518a5ebd9f87c372c55f8f';

/// See also [customerOrdersStream].
@ProviderFor(customerOrdersStream)
const customerOrdersStreamProvider = CustomerOrdersStreamFamily();

/// See also [customerOrdersStream].
class CustomerOrdersStreamFamily
    extends Family<AsyncValue<List<CustomerOrder>>> {
  /// See also [customerOrdersStream].
  const CustomerOrdersStreamFamily();

  /// See also [customerOrdersStream].
  CustomerOrdersStreamProvider call(
    String userId,
  ) {
    return CustomerOrdersStreamProvider(
      userId,
    );
  }

  @override
  CustomerOrdersStreamProvider getProviderOverride(
    covariant CustomerOrdersStreamProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customerOrdersStreamProvider';
}

/// See also [customerOrdersStream].
class CustomerOrdersStreamProvider
    extends AutoDisposeStreamProvider<List<CustomerOrder>> {
  /// See also [customerOrdersStream].
  CustomerOrdersStreamProvider(
    String userId,
  ) : this._internal(
          (ref) => customerOrdersStream(
            ref as CustomerOrdersStreamRef,
            userId,
          ),
          from: customerOrdersStreamProvider,
          name: r'customerOrdersStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerOrdersStreamHash,
          dependencies: CustomerOrdersStreamFamily._dependencies,
          allTransitiveDependencies:
              CustomerOrdersStreamFamily._allTransitiveDependencies,
          userId: userId,
        );

  CustomerOrdersStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<CustomerOrder>> Function(CustomerOrdersStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomerOrdersStreamProvider._internal(
        (ref) => create(ref as CustomerOrdersStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CustomerOrder>> createElement() {
    return _CustomerOrdersStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerOrdersStreamProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomerOrdersStreamRef
    on AutoDisposeStreamProviderRef<List<CustomerOrder>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _CustomerOrdersStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<CustomerOrder>>
    with CustomerOrdersStreamRef {
  _CustomerOrdersStreamProviderElement(super.provider);

  @override
  String get userId => (origin as CustomerOrdersStreamProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
