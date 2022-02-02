//
//  CustomImagesPicker.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI
import Photos

public struct CustomImagesPicker: View {
    
    @Binding var selected : [SelectedImages]
    @State var grid : [[Images]] = []
    @Binding var show : Bool
    @State var disabled = false
    var isIO = false
    
    public init(selecteds:Binding<[SelectedImages]>,show:Binding<Bool>){
        self._selected = selecteds
        self._show = show
    }
    
    public var body: some View{
        
        GeometryReader{_ in
            VStack{
                
                if !self.grid.isEmpty{
                    HStack{
                        Text("Pick a Image")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20){
                            
                            ForEach(self.grid,id: \.self){i in
                                
                                HStack{
                                    
                                    ForEach(i,id: \.self){j in
                                        
                                        Card(selected: self.$selected, data: j)
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Select")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: UIScreen.main.bounds.width / 2)
                    }
                    .background(Color.red.opacity((self.selected.count != 0) ? 1 : 0.5))
                    .clipShape(Capsule())
                    .padding(.bottom)
                    .disabled((self.selected.count != 0) ? false : true)
                    
                }
                else{
                    
                    if self.disabled{
                        
                        Text("Enable Storage Access In Settings !!!")
                    }
                    if self.grid.count == 0{
                        
                        Indicator()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 1.5,alignment: .center)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 0.1))
            .padding()
        }
        .background(Color.white.opacity(100).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            
                            self.show.toggle()
                            
                        })
        .onAppear {
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                if status == .authorized{
                    
                    self.getAllImages()
                    self.disabled = false
                }
                else{
                    
                    print("not authorized")
                    self.disabled = true
                }
            }
        }
    }
    
    func getAllImages(){
        
        let opt = PHFetchOptions()
        opt.includeHiddenAssets = false
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {
            
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            
            // New Method For Generating Grid Without Refreshing....
            
            for i in stride(from: 0, to: req.count, by: 3){
                
                var iteration : [Images] = []
                
                for j in i..<i+3{
                    
                    if j < req.count{
                        
                        PHCachingImageManager.default().requestImage(for: req[j], targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options) { (image, _) in
                            
                            let data1 = Images(image: image!, selected: false, asset: req[j])
                            
                            iteration.append(data1)
                            
                        }
                    }
                }
                
                self.grid.append(iteration)
            }
            
        }
    }
}





