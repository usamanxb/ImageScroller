//
//  SelectedImages.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI
import Photos
struct Images: Hashable {
    
    var image : UIImage
    var selected : Bool
    var asset : PHAsset
}

struct SelectedImages: Hashable{
    
    var asset : PHAsset
    var image : UIImage
}
