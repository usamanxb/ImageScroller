//
//  ZoomableImageView.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI

public struct ZoomableImageView: View {
    
    var selectedImages : [Image] = []
    @State private var offset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(images : [Any]){
        if let image = images as? [SelectedImages]{
            selectedImages = image.map({ Image(uiImage: $0.image) })
        }
        else if let image = images as? [Image] {
            self.selectedImages = image
        }
        else if let image = images as? [String]{
            selectedImages = image.map({Image($0)})
        }
    }
    
    public var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    
                    
                    ImageScrollView(images:selectedImages)
                        .onTapGesture {
                            print("sd")
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: 667)
                .ignoresSafeArea()
                .background(Color.black)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
            )
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName:"arrow.left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            Text(" Back")
                .foregroundColor(.black)
        }
    }
    }
}
