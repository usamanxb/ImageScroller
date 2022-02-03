//
//  WebImagesGridView.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 03/02/2022.
//

import SwiftUI

public struct WebImagesGridView : View {
    
    @Binding var selectedImage : Image
    var internalGridImages : [[Image]] = []
    @State var selected : [[Int]] = []
    var isSelectable : Bool
    
    @ObservedObject var urlImageModel: UrlImageModel
    
    public init(imagesUrl : [String],image: Binding<Image>, isSelectable:Bool){
        urlImageModel = UrlImageModel(urlString: imagesUrl)
        self._selectedImage = image
        self.isSelectable = isSelectable
    }
    
    public var body: some View
    {
        VStack{
            if !(self.urlImageModel.images.isEmpty){
//                urlImageModel.$image = urlImageModel.image?.chunked(into: 3)
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15){
                        ForEach(self.urlImageModel.images.indices, id:\.self) { idx in
                            HStack{
                                ForEach(self.urlImageModel.images[idx].indices, id:\.self) { index in
                                    ZStack(alignment: .topTrailing){
                                        
                                        
                                        Image(uiImage: urlImageModel.images[idx][index] )
                                            .resizable()
                                            .scaledToFit()
                                            .onTapGesture {
                                               // selectedImage = internalGridImages[idx][index]
                                            }
                                    }
                                    .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
                                    .overlay(RoundedRectangle(cornerRadius: 1).stroke(Color.white, lineWidth: 0.5))
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: 667,alignment: .center)
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}
