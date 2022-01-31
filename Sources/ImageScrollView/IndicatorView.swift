//
//  IndicatorView.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI
import Photos

struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView  {
        
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView:  UIActivityIndicatorView, context: Context) {
        
        
    }
}
