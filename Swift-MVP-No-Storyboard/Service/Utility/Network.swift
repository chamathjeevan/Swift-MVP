//
//  Network.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-11.
//
import Foundation
import Apollo

final class Network {
        static let shared = Network()
        private lazy var networkTransport: HTTPNetworkTransport = {

        let transport = HTTPNetworkTransport(url: URL(string: "https://api.github.com/graphql")!)
        transport.delegate = self

        return transport
    }()

    private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}

extension Network: HTTPNetworkTransportPreflightDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        return true
    }

    func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["Authorization"] = "Bearer 6337f481fd6cb24b7efe7315e1c32d0b0238a17f"

        request.allHTTPHeaderFields = headers
    }
}
