//
//  MainDatabase.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import RealmSwift

protocol NewsDatabaseInterface {
  func saveModel(_ model: NewsArticle)
  func clearCache()
  func getSavedModels() -> [NewsArticle]
}

class NewsDatabase: NewsDatabaseInterface {

  func saveModel(_ article: NewsArticle) {
    do {
      let realm = try Realm()
      try realm.write {
        realm.add(NewsArticleDatabaseModel(article: article))
      }
    } catch {
      print("Could not persist News Article")
    }
  }

  func getSavedModels() -> [NewsArticle] {
    do {
      let realm = try Realm()
      let objects = realm.objects(NewsArticleDatabaseModel.self)
      return objects.compactMap { $0.article() }
    } catch {
      return []
    }
  }

  func clearCache() {
    do {
      let realm = try Realm()
      let objects = realm.objects(NewsArticleDatabaseModel.self)
      try realm.write {
        realm.delete(objects)
      }
    } catch {
      return
    }
  }

}



