//
//  GameInfo.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

class GameInfo{
    static var id : String = ""
    init(){
    }
    
    func update(id: String){
        GameInfo.id = id
    }
}
