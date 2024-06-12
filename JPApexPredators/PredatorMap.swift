//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Ishaan Das on 12/06/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var position :MapCameraPosition
    @State var satellite = false
    
    var body: some View {
        GeometryReader { geo in
            Map(position: $position){
                ForEach(predators.apexPredators) { predator in
                    Annotation(predator.name, coordinate: predator.location) {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: geo.size.height/8)
                            .shadow(color: .white.opacity(0.5), radius: 3)
                            .scaleEffect(x: -1)
                    }
                    .annotationTitles(.hidden)
                }
            }
            .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
            .overlay(alignment: .bottomTrailing){
                Button{
                    satellite.toggle()
                } label: {
                    Image(systemName: satellite ? "globe.americas.fill" : "globe.americas" )
                        .font(.largeTitle)
                        .imageScale(.large)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 5)
                        .padding()
                }
            }
            .toolbarBackground(.automatic)
        }
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().allApexPredators[2].location, distance: 1000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}
