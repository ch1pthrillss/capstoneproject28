// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IoTDataManager {
    struct IoTData {
        string deviceId;
        string data;
        uint timestamp;
    }

    mapping(string => IoTData) private dataRecords;

    event DataAdded(string deviceId, string data, uint timestamp);

    function addData(string memory deviceId, string memory data) public {
        dataRecords[deviceId] = IoTData(deviceId, data, block.timestamp);
        emit DataAdded(deviceId, data, block.timestamp);
    }

    function getData(string memory deviceId) public view returns (string memory data, uint timestamp) {
        IoTData memory record = dataRecords[deviceId];
        return (record.data, record.timestamp);
    }
}
