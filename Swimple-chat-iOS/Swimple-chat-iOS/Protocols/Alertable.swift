//
//  Alertable.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

protocol Alerable: AnyObject
{
    func alert(title: String, message: String)
}
