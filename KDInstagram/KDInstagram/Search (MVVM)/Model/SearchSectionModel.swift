//
//  SectionModel.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/16/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct SearchSectionModel {
  var header: String
  var items: [Item]
}

extension SearchSectionModel: SectionModelType {
  typealias Item = Post

   init(original: SearchSectionModel, items: [Item]) {
    self = original
    self.items = items
  }
}



