//
//  MultipleImagesGridView.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 01/02/2022.
//

import SwiftUI

public struct MultipleImagesGridView: View {
    
    @Binding var selectedImage : Image
    var internalGridImages : [[Image]] = []
    var internalGridCustomeImages : [SelectedImages] = []
    var isSelectable : Bool = false
    
    public init(grid:[Image],image : Binding<Image>,isSelectable:Bool) {
        self.internalGridImages = grid.chunked(into: 3)
        self._selectedImage = image
        self.isSelectable = isSelectable
    }
    public init(grid:[SelectedImages],image : Binding<Image>,isSelectable:Bool) {
        var images : [Image] = []
        for uiimage in grid{
            images.append(Image(uiImage: uiimage.image))
        }
        self.isSelectable = isSelectable
        self._selectedImage = image
        self.internalGridImages = images.chunked(into: 3)
    }
    public var body: some View{
        ImageCardView(selectedImage: $selectedImage, internalGridImages: internalGridImages, isSelectable: self.isSelectable)
    }
}


struct ImageCardView: View{
    
    @Binding var selectedImage : Image
    var internalGridImages : [[Image]]
    @State var selected : [[Int]] = []
    var isSelectable : Bool
    
    var body: some View
    {
        VStack{
            if !self.internalGridImages.isEmpty{
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15){
                        ForEach(self.internalGridImages.indices, id:\.self) { idx in
                            HStack{
                                ForEach(self.internalGridImages[idx].indices, id:\.self) { index in
                                    ZStack(alignment: .topTrailing){
                                        internalGridImages[idx][index]
                                            .resizable()
                                            //.scaledToFit()
                                            .onTapGesture {
                                                selectedImage = internalGridImages[idx][index]
                                            }
                                        if isSelectable{
                                            Button(action: {
                                                if selected[idx][index] == 1{
                                                    selected[idx][index] = 0
                                                }
                                                else {
                                                    selected[idx][index] = 1
                                                }
                                            }){
                                                HStack() {
                                                    if selected.count > 0{
                                                        if selected[idx][index] == 0 {
                                                            Image(systemName: "circle")
                                                                .frame(width: 30, height: 20)
                                                                .scaledToFill()
                                                                //.resizable()
                                                                .foregroundColor(.white)
                                                        }
                                                        else {
                                                            Image(systemName: "checkmark")
                                                                .frame(width: 20, height: 20)
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                }
                                                .padding(10)
                                                .background(Color.black)
                                                .opacity(0.5)
                                                .frame(width: 30, height: 30)
                                            }
                                            .cornerRadius(15)
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
        .onAppear(){
            for (index,a) in internalGridImages.enumerated(){
                var array : [Int] = []
                for _ in a{
                    array.append(0)
                }
                selected.insert(array, at: index)
            }
        }
    }
}

protocol GridViewDelegates {
    func onTapped()-> Image
}
