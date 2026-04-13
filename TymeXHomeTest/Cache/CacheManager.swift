//
//  CacheManager.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import Foundation

/// A utility class for managing file-based caching.
class CacheManager {
    
    static let shared = CacheManager()
    
    private let fileManager = FileManager.default
    
    /// Private initializer to enforce the singleton pattern.
        private init() {}

    /// Saves data to a file in the app's Documents directory.
    /// - Parameters:
    ///   - data: The data to save.
    ///   - fileName: The name of the file to save the data in.
    func save<T: Codable>(_ data: T, to fileName: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            let fileURL = getFileURL(for: fileName)
            try encodedData.write(to: fileURL)
            print("Data saved to file: \(fileURL)")
        } catch {
            print("Failed to save data to file \(fileName): \(error.localizedDescription)")
        }
    }

    /// Loads data from a file in the app's Documents directory.
    /// - Parameters:
    ///   - fileName: The name of the file to load the data from.
    ///   - type: The type of the data to load.
    /// - Returns: The loaded data, or `nil` if the operation fails.
    func load<T: Codable>(from fileName: String, as type: T.Type) -> T? {
        let fileURL = getFileURL(for: fileName)
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("Cache file \(fileName) does not exist.")
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            print("Data loaded from file: \(fileURL)")
            return decodedData
        } catch {
            print("Failed to load data from file \(fileName): \(error.localizedDescription)")
            return nil
        }
    }

    /// Returns the file URL for a given file name in the app's Documents directory.
    /// - Parameter fileName: The name of the file.
    /// - Returns: The URL of the file.
    private func getFileURL(for fileName: String) -> URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func clearCache() {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
            
            print("All cache files have been cleared.")
        } catch {
            print("Failed to clear cache: \(error.localizedDescription)")
        }
    }
}
