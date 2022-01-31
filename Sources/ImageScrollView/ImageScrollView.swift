//
//  ImageScrollView.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI

public struct ImageScrollView: View {
   var images : [String] = []
    public init(images:[String]){
        self.images = images
    }
   public var body: some View {
        VStack{
            GeometryReader { proxy in
                TabView{
                    ForEach(images, id: \.self) { item in
                        Image(item)
                            .resizable()
                            .scaledToFit()
                            .tag(item.hash)
                        
                    }
                }.tabViewStyle(PageTabViewStyle())
                .frame(width: proxy.size.width, height: proxy.size.height / 3)
                .background (Color(.black).opacity(50).ignoresSafeArea())
            }
        }.background (Color(.black).opacity(50).ignoresSafeArea())
        .frame(maxWidth:.infinity,maxHeight: .infinity)
    }
}

