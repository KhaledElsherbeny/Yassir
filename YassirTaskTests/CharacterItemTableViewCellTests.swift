//
//  CharacterItemTableViewCellTests.swift
//  YassirTaskTests
//
//  Created by Khalid on 21/10/2024.
//

import XCTest
import Combine
@testable import YassirTask

class CharacterItemTableViewCellTests: XCTestCase {
    
    var cell: CharacterItemTableViewCell!
    var mockImageDownloader: MockImageDownloader!
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: CharacterItemTableViewCell.self)
        let nib = UINib(nibName: "CharacterItemTableViewCell", bundle: bundle)
        cell = nib.instantiate(withOwner: nil, options: nil).first as? CharacterItemTableViewCell
        mockImageDownloader = MockImageDownloader()
    }

    override func tearDown() {
        cell = nil
        mockImageDownloader = nil
        super.tearDown()
    }

    // Test character labels are correctly set
    func testSetupWithCharacterData() {
        // Given
        let character = CharacterListItem(id: 1, name: "John Doe", status: .alive, species: "Human", gender: "Male", image: nil)
        
        // When
        cell.setup(with: character, imageDownloader: mockImageDownloader)
        
        // Then
        XCTAssertEqual(cell.characterNameLabel.text, "John Doe")
        XCTAssertEqual(cell.characterSpeciesLabel.text, "Human")
        XCTAssertEqual(cell.characterStatusLabel.text, "Alive")
        XCTAssertEqual(cell.characterGenderLabel.text, "Male")
    }
    
    // Test placeholder image is set when there is no image URL
    func testPlaceholderImageIsSetWhenNoImageURL() {
        // Given
        let character = CharacterListItem(id: 1, name: "John Doe", status: .alive, species: "Human", gender: "Male", image: nil)
        
        // When
        cell.setup(with: character, imageDownloader: mockImageDownloader)
        
        // Then
        XCTAssertEqual(cell.characterImageView.image, UIImage(named: "placeholder-img"))
    }
    
    // Test image downloader fetches the correct URL and updates the image
    func testImageDownloaderFetchesCorrectURL() {
        // Given
        let imageUrl = "https://example.com/image.png"
        let character = CharacterListItem(id: 1, name: "John Doe", status: .alive, species: "Human", gender: "Male", image: imageUrl)
        
        // Simulate a successful image download
        mockImageDownloader.response = .success(UIImage())
        
        // When
        cell.setup(with: character, imageDownloader: mockImageDownloader)
        
        // Then
        XCTAssertTrue(mockImageDownloader.isFetchImageCalled)
        XCTAssertEqual(mockImageDownloader.imageURL, URL(string: imageUrl))
    }
    
    // Test placeholder image is set when image download fails
    func testPlaceholderImageIsSetWhenImageDownloadFails() {
        // Given
        let imageUrl = "https://example.com/image.png"
        let character = CharacterListItem(id: 1, name: "John Doe", status: .alive, species: "Human", gender: "Male", image: imageUrl)
        
        // Simulate a failed image download
        mockImageDownloader.response = .failure(NSError(domain: "", code: 0, userInfo: nil))
        
        // When
        cell.setup(with: character, imageDownloader: mockImageDownloader)
        
        // Then
        XCTAssertEqual(cell.characterImageView.image, UIImage(named: "placeholder-img"))
    }
}

extension CharacterItemTableViewCellTests {
    // Mock class for ImageDownloadable
    class MockImageDownloader: ImageDownloadable {
        var isFetchImageCalled = false
        var imageURL: URL?
        var response: Result<UIImage, Error>?
        
        func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
            isFetchImageCalled = true
            imageURL = url
            
            // Simulate either success or failure based on the response
            if let response = response {
                completion(response)
            }
        }
    }
}
