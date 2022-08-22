//
//  DictionaryValue+Encodable.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 21.08.2022.
//

import Foundation

public extension Encodable {
    
    func dataValue(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        return data
    }
    
    func dictionaryValue(encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        guard let data = self.dataValue() else {
            return nil
        }
        guard let dict = data.dictionaryValue() else {
            return nil
        }
        return dict
    }
}
