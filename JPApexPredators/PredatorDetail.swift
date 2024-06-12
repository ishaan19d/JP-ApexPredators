//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Ishaan Das on 12/06/24.
//

import SwiftUI

struct PredatorDetail: View {
    let predator: ApexPredator
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.5), Gradient.Stop(color: .black, location: 1)],startPoint: .top, endPoint: .bottom)
                        }
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y:20)
                }
                
                VStack(alignment: .leading){
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    //current loc: mapkit
                    
                    Text("Appears In:")
                        .font(.title)
                    
                    ForEach(predator.movies,id: \.self) { movie in
                        Text("• " + movie)
                            .font(.subheadline)
                    }
                    
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 25)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text("• " + scene.movie)
                            .font(.title2)
                            .padding(.vertical,1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    Text("Read More:")
                        .font(.caption)
                    Link(destination: URL(string: predator.link)!) {
                        Text(predator.link)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    PredatorDetail(predator: Predators().apexPredators[7])
//        .preferredColorScheme(.dark)
}
