library mdx_dicontainer;

abstract class MDXDIContainerProtocol {
  MDXDIContainer get instance;
  Service call<Service extends Object>();
  Service resolve<Service extends Object>();
  void register<Service extends Object>({required Service instance});
}

class MDXDIContainer implements MDXDIContainerProtocol {
  static final MDXDIContainer _instance = MDXDIContainer._internal();

  @override
  MDXDIContainer get instance => _instance;

  factory MDXDIContainer() {
    return _instance;
  }

  MDXDIContainer._internal();

  final Map<String, dynamic> _services = {};

  void _register<Service extends Object>({
    required Service instance,
    required String name,
  }) {
    _services[name] = instance;
  }

  Service _resolve<Service extends Object>() => _services[Service.toString()];

  @override
  Service call<Service extends Object>() => _instance._resolve();

  @override
  Service resolve<Service extends Object>() => _instance._resolve();

  @override
  void register<Service extends Object>({required Service instance}) {
    _instance._register(instance: instance, name: Service.toString());
  }
}
