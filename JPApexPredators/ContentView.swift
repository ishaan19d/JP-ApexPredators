//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Ishaan Das on 10/06/24.
//

import SwiftUI

struct ContentView: View {
    
    let predators = Predators()
    
    @State var searchText: String = ""
    @State var isAlphabetical = false
    @State var currentSelection = PredatorType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(byAlpha: isAlphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                }label : {
                    HStack{
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading){
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Text(predator.type.rawValue.capitalized)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .animation(.default, value: currentSelection)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isAlphabetical.toggle()
                    } label: {
                        Image(systemName: isAlphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: isAlphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
