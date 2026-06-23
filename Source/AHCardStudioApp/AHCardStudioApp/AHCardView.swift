//
//  AHCardView.swift
//  AHCardStudioApp
//
//  Created by Alvin HEIB on 23/06/2026.
//

import SwiftUI

struct AHCardView: View {
    var card: AHCard
    
    var body: some View {
        // GeometryReader reads the size allocated to this card view by its parent layout
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width * 1.357 // Maintains standard playing card aspect ratio
            
            if card.isVisible {
                RoundedRectangle(cornerRadius: width * 0.15) // Corner radius scales with card size
                    .fill(.white)
                    .strokeBorder(.black, lineWidth: max(1, width * 0.015)) // Border scales nicely
                    .frame(width: width, height: height)
                    .overlay(
                        ZStack {
                            // Top Left Corner
                            VStack {
                                HStack {
                                    Text("\(card)")
                                        .font(.system(size: width * 0.18, weight: .semibold))
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding([.top, .leading], width * 0.08)
                            
                            // Middle (Center)
                            Text("\(card)")
                                .font(.system(size: width * 0.25, weight: .bold))
                            
                            // Bottom Right Corner
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("\(card)")
                                        .font(.system(size: width * 0.18, weight: .semibold))
                                        .rotationEffect(.degrees(180))
                                }
                            }
                            .padding([.bottom, .trailing], width * 0.08)
                        }
                    )
            } else {
                RoundedRectangle(cornerRadius: width * 0.15)
                    .fill(.blue)
                    .strokeBorder(.black, lineWidth: max(1, width * 0.015))
                    .frame(width: width, height: height)
            }
        }
        // This ensures the view layout engine knows this view expects a 1:1.357 frame profile
        .aspectRatio(1/1.357, contentMode: .fit)
    }
}

