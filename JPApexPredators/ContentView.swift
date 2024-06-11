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
    
    var filteredDinos: [ApexPredator] {
        if searchText.isEmpty {
            return predators.apexPredators
        }
        else{
            return predators.apexPredators.filter { predator in
                predator.name.localizedStandardContains(searchText)
            }
        }
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
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
