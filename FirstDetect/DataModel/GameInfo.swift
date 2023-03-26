//
//  GameInfo.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

class GameInfo{
    static var id : String = ""
    static var target : String = ""
    init(){
    }
    
    func update(id: String, target: String){
        GameInfo.id = id
        GameInfo.target = target
    }
}
