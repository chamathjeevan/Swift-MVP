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
        headers["Authorization"] = "Bearer e2132ebf4a3ec3c7c549502436c0e96a1c62f8ea"

        request.allHTTPHeaderFields = headers
    }
}
