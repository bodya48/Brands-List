//
//  ContentView.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    //var carName: String = ""
    //@State var showAlert: Bool = false
    
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.viewState {
                case .emptyList:
                    LoadingView()
                case .content(let manufacturers):
                    List {
                        ForEach(manufacturers.indices, id: \.self) { index in
                            let manufacturer = manufacturers[index]
                            
                            NavigationLink {
                                //DetailView(selectedManufacturer: manufacturer, mainViewModel: viewModel)
                                DetailView(selectedManufacturer: manufacturer) { selectedModel in
                                    viewModel.selected(manufacturer: manufacturer, model: selectedModel)
                                }
                            } label: {
                                ListItemView(name: manufacturer.brand)
                            }
                            .listRowBackground(index % 2 == 0 ? Constants.colorEven : Constants.colorOdd)
                            
                            if viewModel.shouldDisplayActivityRow(for: manufacturer) {
                                LastRowShimmerView()
                                    .onAppear { Task { await viewModel.loadContent() } }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                case .error(let error):
                    ErrorView(description: error)
                }
            }
            .navigationTitle("Manufacturers")
            .alert(isPresented: $viewModel.showAlert) { Alert(title: Text(viewModel.alertMessage)) }
        }
        .onAppear { Task { await viewModel.loadContent() } }
    }
        
}

#Preview {
    NavigationStack {
        let viewModel = MainViewModel(networkService: NetworkService())
        MainView(viewModel: viewModel)
    }
}
