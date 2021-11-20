//
//  CustomSecureField.swift
//  Instagram-clone
//
//  Created by Kunatip Satsomnuk on 7/11/2564 BE.
//

import SwiftUI

struct CustomSecureField: View {
    let placeholder: Text
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                    .padding(.leading, 16)
            }
            
            VStack {
                SecureField("", text: $text)
                Divider()
                 .frame(height: 1)
                 .padding(.horizontal, 32)
                 .background(Color.gray)
            }
            .padding()
        }
        .frame(width: 380, height: 50)
    }
}
