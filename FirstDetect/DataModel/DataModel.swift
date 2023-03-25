//
//  DataModel.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation


class DataModel: ObservableObject{
    static let shared = DataModel()
    @Published var record : [Chat]
    
    init(){
        record = [Chat]()
    }
    
    func send(chat: Chat){
        
    }
    
    func recv(chat: Chat){
        
    }
    
}
