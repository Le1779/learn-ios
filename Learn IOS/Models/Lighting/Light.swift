//
//  Light.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/21.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import Foundation

protocol Light {
    
    func setLightListener(listener: LightListener)
    
    func analysisResponse(response: String)
}

protocol LightListener {
    
}
