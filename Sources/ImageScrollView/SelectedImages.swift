//
//  SelectedImages.swift
//  UAImagesPicker
//
//  Created by Usama Ali on 31/01/2022.
//

import SwiftUI
import Photos
public struct Images: Hashable {
    
    public var image : UIImage
    public var selected : Bool
    public var asset : PHAsset
}

public struct SelectedImages: Hashable{
    
    public var asset : PHAsset
    public var image : UIImage
}
