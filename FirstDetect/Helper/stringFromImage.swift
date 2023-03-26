//
//  stringFromImage.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/26/23.
//

import Foundation
import UIKit

func stringFromImage(_ imagePic: UIImage) -> String {
    let picImageData: Data = imagePic.jpegData(compressionQuality: 0.5)!
    let picBase64 = picImageData.base64EncodedString()
    return picBase64
}
