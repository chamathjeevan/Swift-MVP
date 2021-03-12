//
//  Network.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-11.
//
import Foundation
import Apollo
import ApolloSQLite

final class Network {
    static let shared = Network()
    private lazy var networkTransport: HTTPNetworkTransport = {
        
        let transport = HTTPNetworkTransport(url: URL(string: "https://api.github.com/graphql")!)
        transport.delegate = self
        
        return transport
    }()
    var cacheUrl:URL!
    let cache:SQLiteNormalizedCache!
    let configuration = URLSessionConfiguration.default
    let store:ApolloStore!
    private init() {
        let applicationSupportPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!
        let dbPath = applicationSupportPath + "/com.apollochamath.cache"
        
        if !FileManager.default.fileExists(atPath: dbPath) {
            try? FileManager.default.createDirectory(atPath: dbPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        let url = URL(fileURLWithPath: dbPath)
        cacheUrl =  url.appendingPathComponent("apollogithubdata.sqlite3")
        cache = try? SQLiteNormalizedCache(fileURL: cacheUrl)
        configuration.timeoutIntervalForRequest = 10
        store = ApolloStore(cache: cache ?? InMemoryNormalizedCache())
    }
    private(set) lazy var apollo = ApolloClient(networkTransport: networkTransport, store: store)
}

extension Network: HTTPNetworkTransportPreflightDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        return true
    }
    
    func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["Authorization"] = "Bearer 4e179620b5f9de5b80717e8390ca1194a0cfa420"
        
        request.allHTTPHeaderFields = headers
    }
}
