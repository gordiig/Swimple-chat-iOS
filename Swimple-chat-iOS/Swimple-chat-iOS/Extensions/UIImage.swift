//
//  UIImage.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 11/12/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit


extension UIImage
{
    func toBase64() -> String?
    {
        let data = self.jpegData(compressionQuality: 0.8)
        let str64 = data?.base64EncodedString()
        return str64
    }
    
    static func toBase64(_ image: UIImage) -> String?
    {
        let data = image.jpegData(compressionQuality: 0.8)
        let str64 = data?.base64EncodedString()
        return str64
    }
    
    static func fromBase64(_ str: String) -> UIImage?
    {
        guard let data = Data(base64Encoded: str) else { return nil }
        let img = UIImage(data: data)
        return img
    }
}
