//
//  Model.swift
//  MySearchImageApp
//
//  Created by Eric on 22.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Model {
    var bigPictureURL: String
    var smallPictureURL: String
    
    init?(json: JSON) {
          guard let urlQ = json["url_q"].string,
              let urlZ = json["url_z"].string else {
                  return nil
          }
          
          self.bigPictureURL = urlZ
          self.smallPictureURL = urlQ
      }
}
