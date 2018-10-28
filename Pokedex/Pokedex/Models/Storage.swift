//
//  Storage.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/28/18.
//

import Foundation

public class Storage {
    
    fileprivate init() { }
    
    enum FileType {
        case pokemon(Int)
        case species(Int)
        case evolution(Int)
        
        var fileName: String {
            switch self {
            case .pokemon(let id):
                return "Pokemon\(id).json"
            case .species(let id):
                return "Species\(id).json"
            case .evolution(let id):
                return "Evolution\(id).json"
            }
        }
    }
    
    
    
    static private let directoryPath = FileManager.SearchPathDirectory.documentDirectory
    
    // Returns URL of local disk path.
    static private var directory: URL {

        if let url = FileManager.default.urls(for: directoryPath, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    
    // Store an encodable struct to the specified directory on disk
    static func store<T: Encodable>(_ object: T, as fileType: FileType) {
        let url = directory.appendingPathComponent(fileType.fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            
            // override file
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Retrieve and convert a struct from a file on disk
    static func retrieve<T: Decodable>(_ fileType: FileType, as type: T.Type) -> T? {
        let url = directory.appendingPathComponent(fileType.fileName, isDirectory: false)
        
        // Print message if file does not exist
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File at path \(url.path) does not exist!")
        }
        
        guard let data = FileManager.default.contents(atPath: url.path) else {
            fatalError("No data at \(url.path)!")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try? decoder.decode(type, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        
    }
    
    // Returns a boolean indicating whether file exists at directory with specified file name
    static func fileExists(_ fileType: FileType) -> Bool {
        let url = directory.appendingPathComponent(fileType.fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
