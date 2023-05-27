import 'package:mdx_dicontainer/mdx_dicontainer.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

/// Generate Mock with 'dart run build_runner build'
@GenerateNiceMocks([MockSpec<ServiceTest>()])
import './mdx_dicontainer_test.mocks.dart';

// ignore: unreachable_from_main
abstract class ServiceTestProtocol {}

// ignore: unreachable_from_main
class ServiceTest implements ServiceTestProtocol {}

void main() {
  late MDXDIContainer resolverDI;

  group('MDXDIContainer', () {
    setUp(() {
      resolverDI = MDXDIContainer.I;
    });

    test('.instance should be the same instance of resolverDI', () {
      //assert
      expect(resolverDI, MDXDIContainer.instance);
    });

    test('.I should be the same instance of resolverDI', () {
      //assert
      expect(resolverDI, MDXDIContainer.I);
    });
  });

  group('Factory', () {
    setUp(() {
      resolverDI = MDXDIContainer.I;
    });

    void registerFactory() {
      resolverDI.registerFactory<ServiceTestProtocol>(() => MockServiceTest());
    }

    test('should return a instance of MockServiceTest', () {
      // act
      registerFactory();
      final ServiceTestProtocol factory = resolverDI();
      // assert
      expect(factory, isA<MockServiceTest>());
      expect(factory, isA<ServiceTestProtocol>());
    });

    test('should factoryA be a diferent instance of B', () {
      // act
      registerFactory();
      final ServiceTestProtocol factoryA = resolverDI();
      final ServiceTestProtocol factoryB = resolverDI();
      // assert
      expect(factoryA, isNot(factoryB));
    });
  });

  group('Singleton', () {
    void registerSingleton() {
      resolverDI
          .registerSingleton<ServiceTestProtocol>(() => MockServiceTest());
    }

    test('showld resturn a instance of MockServiceTest', () {
      // act
      registerSingleton();
      final ServiceTestProtocol factory = resolverDI();
      // assert
      expect(factory, isA<MockServiceTest>());
      expect(factory, isA<ServiceTestProtocol>());
    });

    test('should factoryA be a same instance of B', () {
      // act
      registerSingleton();
      final ServiceTestProtocol factoryA = resolverDI();
      final ServiceTestProtocol factoryB = resolverDI();
      // assert
      expect(factoryA, factoryB);
    });

    group('Invalidate', () {
      test('should factoryA be a diferent instance of B', () {
        // act
        registerSingleton();
        final ServiceTestProtocol factoryA = resolverDI();
        resolverDI.invalidate();
        final ServiceTestProtocol factoryB = resolverDI();
        // assert
        expect(factoryA, isNot(factoryB));
      });
    });
  });

  group('LazySingleton', () {
    void registerLazySingleton() {
      resolverDI
          .registerLazySingleton<ServiceTestProtocol>(() => MockServiceTest());
    }

    test('showld resturn a instance of MockServiceTest', () {
      // act
      registerLazySingleton();
      final ServiceTestProtocol factory = resolverDI();
      // assert
      expect(factory, isA<MockServiceTest>());
      expect(factory, isA<ServiceTestProtocol>());
    });

    test('should factoryA be a same instance of B', () {
      // act
      registerLazySingleton();
      final ServiceTestProtocol factoryA = resolverDI();
      final ServiceTestProtocol factoryB = resolverDI();
      // assert
      expect(factoryA, factoryB);
    });

    group('Invalidate', () {
      test('should factoryA be a diferent instance of B', () {
        // act
        registerLazySingleton();
        final ServiceTestProtocol factoryA = resolverDI();
        resolverDI.invalidate();
        final ServiceTestProtocol factoryB = resolverDI();
        // assert
        expect(factoryA, isNot(factoryB));
      });
    });
  });
}
