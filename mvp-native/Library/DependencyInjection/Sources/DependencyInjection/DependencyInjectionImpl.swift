//
//  DependencyInjectionImpl.swift
//  
//
//  Created by samuelsong on 2022/6/19.
//

import Foundation

final class ServiceImpl: ServiceAPI {
    private parent: ServiceAPI?

    init(_ parent: ServiceAPI? = nil) {
        self.parent = parent
    }

    func registerService<T>(_ type: T.Type, _ builder: @escaping (_ service: ServiceAPI) -> T) {
    }

    func getService<T>(_ type: T.Type) -> T {
        fatalError("Not yet")
    }
}
