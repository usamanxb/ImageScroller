//
//  Card.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI
import Photos

struct Card : View {
    
    @State var data : Images
    @Binding var selected : [SelectedImages]
    
    var body: some View{
        
        ZStack{
            
            Image(uiImage: self.data.image)
                .resizable()
            
            if self.data.selected{
                
                ZStack{
                    
                    Color.black.opacity(0.5)
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
            
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
        .onTapGesture {
            
            
            if !self.data.selected{
                
                
                self.data.selected = true
                
                // Extracting Orginal Size of Image from Asset
                
                DispatchQueue.global(qos: .background).async {
                    
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    
                    // You can give your own Image size by replacing .init() to CGSize....
                    
                    PHCachingImageManager.default().requestImage(for: self.data.asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                        
                        self.selected.append(SelectedImages(asset: self.data.asset, image: image!))
                    }
                }
                
            }
            else{
                
                for i in 0..<self.selected.count{
                    
                    if self.selected[i].asset == self.data.asset{
                        
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                    
                }
            }
        }
        
    }
}
