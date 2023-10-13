//
//  MainViewModel.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation
import Combine

class MainViewModel {
    // public
    var cancellables: Set<AnyCancellable> = []
    
    @Published var arrowButtonAction: ArrowButtonImageState = .down
    
    weak var showDetailPageByIndex: PassthroughSubject<Int, Never>?
    
    typealias RequestResponseClosure = () async throws -> CriminalData
    
    // private
    @Published private(set) var loadingState: LoadingState<Error>
        
    private(set) var criminals: [CriminalItem] = []
        
    private let responseService: EndpointResponseServiceProtocol
    
    private let connectionManager: ConnectionManager
    
    init(responseService: EndpointResponseServiceProtocol, connectionManager: ConnectionManager) {
        self.responseService = responseService
        self.connectionManager = connectionManager
        
        self.loadingState = .idle
    }
    
    func requestResponse() async throws -> CriminalData {
        return try await responseService.decodeData(from: FBIWantedEndpoints.getList)
    }
    
    @MainActor
    func requestFBIWanted(response: RequestResponseClosure) async {
        do {
            loadingState = .loading
            
            guard connectionManager.isConnected() else {
                loadingState = .noInternet
                return
            }
        let response: CriminalData = try await response()
            
            criminals = response.items ?? []
            loadingState = .loaded
        } catch {
            loadingState = .failed(error)
        }
    }
}
