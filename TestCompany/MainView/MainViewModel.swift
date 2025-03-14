//
//  MainViewModel.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    
    @Published var viewState: MainViewState = .emptyList
    
    @Published var showAlert: Bool = false
    var alertMessage: String = ""
    
    private let selectedManufacturer = PassthroughSubject<String, Never>()
    private let selectedModel = PassthroughSubject<String, Never>()
    
    private let networkService: NetworkServiceProtocol
    
    private var manufacturers: [Manufacturer] = []
    private var isLoading = false
    private var currentPage = 0
    private var totalPageCount = 0
    
    private var cancellables = [AnyCancellable]()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.addSubscribers()
    }
    
    // MARK: - Load content
    
    func loadContent() async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let result = try await networkService.fetchManufacturers(page: currentPage)
            
            var tempArray: [Manufacturer] = []
            result.wkda.forEach {
                tempArray.append(Manufacturer(brand: $0.value, brandId: $0.key))
            }
            
            manufacturers.append(contentsOf: tempArray)
            manufacturers.sort {
                $0.brand.localizedStandardCompare($1.brand) == .orderedAscending
            }
            
            currentPage += 1
            totalPageCount = result.totalPageCount
            isLoading = false
            viewState = .content(manufacturers)
        } catch {
            isLoading = false
            viewState = .error(error.localizedDescription)
        }
    }
    
    func retryFetchingContent() async {
        await loadContent()
    }
    
    func refreshContent() async {
        manufacturers = []
        isLoading = false
        currentPage = 0
        totalPageCount = 0
        await loadContent()
    }
    
    func shouldDisplayActivityRow(for manufacturer: Manufacturer) -> Bool {
        if manufacturers.last?.brandId == manufacturer.brandId && currentPage < totalPageCount {
            return true
        }
        return false
    }
    
    // MARK: - Handle user pick
    
    func selected(manufacturer: Manufacturer, model: ModelType) {
        selectedManufacturer.send(manufacturer.brand)
        selectedModel.send(model.modelType)
    }
    
    private func addSubscribers() {
        selectedManufacturer
            .combineLatest(selectedModel)
            .sink { [weak self] (brand, model) in
                self?.alertMessage = "Car selected:\n\(brand) \(model)"
                self?.showAlert = true
            }
            .store(in: &cancellables)
    }
}

// MARK: - View State

enum MainViewState: Equatable {
    case emptyList
    case content([Manufacturer])
    case error(String)
    
    static func == (lhs: MainViewState, rhs: MainViewState) -> Bool {
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
