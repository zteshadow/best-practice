
public protocol ServiceAPI {
    func registerService<T>(_ type: T.Type, _ builder: @escaping (_ service: ServiceAPI) -> T)
    func getService<T>(_ type: T.Type) -> T
}

public final class Service: ServiceAPI {
    private let parent: ServiceAPI?
    private let impl: ServiceImpl

    init(_ parent: ServiceAPI? = nil) {
        self.parent = parent
        impl = ServiceImpl(parent)
    }

    func registerService<T>(_ type: T.Type, _ builder: @escaping (_ service: ServiceAPI) -> T) {
        impl.registerService(type, builder)
    }

    func getService<T>(_ type: T.Type) -> T {
        return impl.getService(type)
    }
}
