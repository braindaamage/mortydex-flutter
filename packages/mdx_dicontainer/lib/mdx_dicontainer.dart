library mdx_dicontainer;

part 'mdx_dicontainer_imp.dart';

abstract class MDXDIContainer {
  static final _instance = _MDXDIContainerImplementation();

  static MDXDIContainer get instance => _instance;

  static MDXDIContainer get I => _instance;

  Service call<Service extends Object>();
  Service resolve<Service extends Object>();

  void registerFactory<Service extends Object>(FactoryCreator<Service> creator);
  void registerLazySingleton<Service extends Object>(
    FactoryCreator<Service> creator,
  );
  void registerSingleton<Service extends Object>(
    FactoryCreator<Service> creator,
  );

  void invalidate();
}
