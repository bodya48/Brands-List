//
//  DetailViewModel.swift
//  TestCompany
//
//  Created by bod on 10/30/24.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    
    @Published var viewState: DetailViewState = .emptyList
    
    private let networkService: NetworkServiceProtocol
    
    private var modelTypes: [ModelType] = []
    private var isLoading = false
    private var currentPage = 0
    private var totalPageCount = 0
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Load content
    
    func loadContent(for manufacturer: Manufacturer) async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let result = try await networkService.fetchModels(manufacturerId: manufacturer.brandId, page: currentPage)
            
            var tempArray: [ModelType] = []
            result.wkda.forEach {
                tempArray.append(ModelType(modelType: $0.value, modelTypeId: $0.key))
            }
            modelTypes.append(contentsOf: tempArray)
            modelTypes.sort {
                $0.modelType.localizedStandardCompare($1.modelType) == .orderedAscending
            }
            
            currentPage += 1
            totalPageCount = result.totalPageCount
            isLoading = false
            viewState = .content(modelTypes)
        } catch {
            isLoading = false
            viewState = .error(error.localizedDescription)
        }
    }
    
    func shouldDisplayActivityRow(for modelType: ModelType) -> Bool {
        if modelTypes.last?.modelTypeId == modelType.modelTypeId && currentPage < totalPageCount {
            return true
        }
        return false
    }
}

// MARK: - View State

enum DetailViewState: Equatable {
    case emptyList
    case content([ModelType])
    case error(String)
    
    static func == (lhs: DetailViewState, rhs: DetailViewState) -> Bool {
        switch (lhs, rhs) {
        case (.emptyList, .emptyList):
            return true
        case (.content(_), .content(_)):
            return true
        case (.error(_), .error(_)):
            return true
        default:
            return false
        }
    }
}
