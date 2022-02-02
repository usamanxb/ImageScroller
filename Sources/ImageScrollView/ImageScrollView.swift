//
//  ImageScrollView.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI

public struct ImageScrollView: View {
    
    var imagesNameArray : [String] = []
    var imagesArray: [Image] = []
    @State var scale: CGFloat = 1.0
    @State var lastScaleValue: CGFloat = 1.0
    @State var isTapped = false
    
    public init(images:[String]){
        self.imagesNameArray = images
    }
    public init(images:[Image]){
        self.imagesArray = images
    }
    
    
    public var body: some View {
        VStack{
            //GeometryReader { proxy in
            Button(action: {
                
            })
            {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            .padding(.leading)
            .padding(.top)
            .frame(width: 30, height: 30, alignment: .topTrailing)
            TabView{
                
                
                
                if imagesNameArray.count > 0 {
                    ForEach(0..<imagesNameArray.count, id: \.self) { item in
                        Image(imagesNameArray[item])
                            .resizable()
                            .scaledToFit()
                            .tag(item)
                            .scaleEffect(scale)
                            .gesture(MagnificationGesture().onChanged { val in
                                let delta = val / self.lastScaleValue
                                self.lastScaleValue = val
                                var newScale = self.scale * delta
                                if newScale < 1.0
                                {
                                    newScale = 1.0
                                }
                                scale = newScale
                            }.onEnded{val in
                                lastScaleValue = 1
                            })
                            
                        
                    }
                }else {
                    ForEach(0..<imagesArray.count,id: \.self) { imageIdx in
                        imagesArray[imageIdx]
                            .resizable()
                            .scaledToFit()
                            .tag(imageIdx)
                            .scaleEffect(scale)
                            .gesture(MagnificationGesture().onChanged { val in
                                let delta = val / self.lastScaleValue
                                self.lastScaleValue = val
                                var newScale = self.scale * delta
                                if newScale < 1.0
                                {
                                    newScale = 1.0
                                }
                                scale = newScale
                            }.onEnded{val in
                                lastScaleValue = 1
                            })
                            .onTapGesture {
                                isTapped = true
                            }
//                            .fullScreenCover(isPresented: $isTapped, content: {
//                                ZoomableImageView(images: imagesArray)
//                            })
                            
                    }
                    
                }
            }.tabViewStyle(PageTabViewStyle())
            
            //                .frame(width: proxy.size.width, height: proxy.size.height / 3)
            //                .background (Color(.black).opacity(50).ignoresSafeArea())
            //            }
        }
    }
}

