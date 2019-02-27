//
//  RealmManager.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 2/26/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    
    
    //MARK: Methods
    func printFilePath() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "No path found.")
    }
    
}
