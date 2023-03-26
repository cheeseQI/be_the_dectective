//
//  imageFromString.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/26/23.
//

import Foundation
import SwiftUI

func imageFromString(base64string: String) -> Image {
//    print(base64string)
    guard let imgData = Data(base64Encoded: base64string, options: .ignoreUnknownCharacters),
          let uiImage = UIImage(data: imgData)
    else { return Image("error") }
    return Image(uiImage: uiImage)
}
