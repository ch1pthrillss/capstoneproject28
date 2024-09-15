// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDataStorage {

    // Structure to store data
    struct DataEntry {
        string data;          // The actual data (could be a string)
        address uploader;     // Address of the user who uploaded the data
        uint256 timestamp;    // The timestamp when the data was uploaded
    }

    // Mapping to store data with a unique ID
    mapping(uint256 => DataEntry) private dataStore;

    // Event emitted when data is successfully stored
    event DataStored(uint256 dataId, address uploader, uint256 timestamp);

    // Function to store data, mapped by a unique ID
    function storeData(uint256 dataId, string memory data) public {
        require(bytes(data).length > 0, "Data cannot be empty");
        require(dataStore[dataId].timestamp == 0, "Data with this ID already exists");

        dataStore[dataId] = DataEntry({
            data: data,
            uploader: msg.sender,
            timestamp: block.timestamp
        });

        emit DataStored(dataId, msg.sender, block.timestamp);
    }

    // Function to retrieve data by its unique ID
    function retrieveData(uint256 dataId) public view returns (string memory data, address uploader, uint256 timestamp) {
        require(dataStore[dataId].timestamp != 0, "Data not found");

        DataEntry memory entry = dataStore[dataId];
        return (entry.data, entry.uploader, entry.timestamp);
    }
}
