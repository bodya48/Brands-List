//
//  DetailView.swift
//  TestCompany
//
//  Created by bod on 10/30/24.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = DetailViewModel()
    //private var mainViewModel: MainViewModel
    
    var selectedModelCompletion: (_ model: ModelType) -> ()
    
    let selectedManufacturer: Manufacturer
    
    init(selectedManufacturer: Manufacturer, completion: @escaping (_ model: ModelType) -> ()) {
        self.selectedManufacturer = selectedManufacturer
        //self.mainViewModel = mainViewModel
        selectedModelCompletion = completion
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .emptyList:
                LoadingView(itemsNumber: 7)
            case .content(let modelTypes):
                List {
                    ForEach(modelTypes.indices, id: \.self) { index in
                        let modelType = modelTypes[index]
                        
                        ListItemView(name: modelType.modelType)
                            .listRowBackground(index % 2 == 0 ? Constants.colorEven : Constants.colorOdd)
                            .onTapGesture {
                                selectedModelCompletion(modelType)
                                //modelSelected(modelType)
                                dismiss()
                            }
                        
                        if viewModel.shouldDisplayActivityRow(for: modelType) {
                            LastRowShimmerView()
                                .onAppear {
                                    Task { await viewModel.loadContent(for: selectedManufacturer) }
                                }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            case .error(let error):
                ErrorView(description: error)
            }
        }
        .navigationTitle("\(selectedManufacturer.brand) models")
        .task { await viewModel.loadContent(for: selectedManufacturer) }
    }
    
    private func modelSelected(_ modelType: ModelType) {
        //mainViewModel.selected(manufacturer: selectedManufacturer, model: modelType)
    }
}

#Preview {
    DetailView(selectedManufacturer: MockDataProvider.manufacturer, completion: { _ in })
               //mainViewModel: MainViewModel())
}
