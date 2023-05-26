part of 'mdx_dicontainer.dart';

// Simple throw error if condition is true
void _throwConditional({required bool condition, required Object error}) {
  if (condition) throw error;
}

// Definition of creator functions
typedef FactoryCreator<T> = T Function();

// anstrac type of stored service
abstract class _MDXDIService<Service extends Object> {
  Service get instance;
}

// Normal singleton model
class _MDXDISingleton<Service extends Object> implements _MDXDIService {
  late Service _instance;

  _MDXDISingleton(FactoryCreator<Service> creator) {
    _instance = creator();
  }

  @override
  Service get instance => _instance;
}

// Lazy singleton model
class _MDXDILazySingleton<Service extends Object> implements _MDXDIService {
  Service? _instance;

  FactoryCreator<Service> creator;
  _MDXDILazySingleton(this.creator);

  @override
  Service get instance {
    _instance ??= creator();
    return _instance!;
  }
}

// Factory model
class _MDXDIFactory<Service extends Object> implements _MDXDIService {
  FactoryCreator<Service> creator;
  _MDXDIFactory(this.creator);

  @override
  Object get instance => creator();
}

// enum for type of stored factories
enum _MDXDIServiceType {
  factory,
  lazySingleton,
  singleton,
}

class _MDXDIContainerImplementation implements MDXDIContainer {
  final Map<String, _MDXDIService> _services = {};

  _MDXDIContainerImplementation();

  void _register<Service extends Object>({
    required FactoryCreator<Service> creator,
    required String name,
    required _MDXDIServiceType serviceType,
  }) {
    switch (serviceType) {
      case _MDXDIServiceType.factory:
        _services[name] = _MDXDIFactory(creator);
        break;
      case _MDXDIServiceType.lazySingleton:
        _services[name] = _MDXDILazySingleton(creator);
        break;
      case _MDXDIServiceType.singleton:
        _services[name] = _MDXDISingleton(creator);
        break;
      default:
    }
  }

  Service _resolve<Service extends Object>() {
    _throwConditional(
      condition: _services[Service.toString()] == null,
      error: Exception('Service don\'t found!'),
    );
    return _services[Service.toString()]!.instance as Service;
  }

  @override
  Service call<Service extends Object>() => _resolve();

  @override
  Service resolve<Service extends Object>() => _resolve();

  @override
  void registerFactory<Service extends Object>(
      FactoryCreator<Service> creator) {
    _register(
      creator: creator,
      name: Service.toString(),
      serviceType: _MDXDIServiceType.factory,
    );
  }

  @override
  void registerLazySingleton<Service extends Object>(
      FactoryCreator<Service> creator) {
    _register(
      creator: creator,
      name: Service.toString(),
      serviceType: _MDXDIServiceType.lazySingleton,
    );
  }

  @override
  void registerSingleton<Service extends Object>(
      FactoryCreator<Service> creator) {
    _register(
      creator: creator,
      name: Service.toString(),
      serviceType: _MDXDIServiceType.singleton,
    );
  }
}
