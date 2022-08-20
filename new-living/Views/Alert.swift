//
//  AlertSuccess.swift
//  new-living
//
//  Created by Cezary Maćkowski on 26/06/2022.
//

import SwiftUI

struct Alert: View {
    @Binding var message: String
    @Binding var image: String
    @Binding var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .padding()
                    
            Text("\(message)")
                 .foregroundColor(.white)
                    
            Spacer()
        }.background(color)
    }
}

