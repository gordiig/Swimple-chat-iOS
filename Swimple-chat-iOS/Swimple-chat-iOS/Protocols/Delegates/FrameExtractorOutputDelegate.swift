//
//  FrameExtractorOutputDelegate.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 01/11/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit

protocol FrameExtractorOutputDelegate: AnyObject
{
    func frameExtractor(didOutputFrame frame: UIImage, base64: String?)
}
