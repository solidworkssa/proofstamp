// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DocumentRegistry {
    struct Document {
        bytes32 documentHash;
        address submitter;
        uint256 timestamp;
        string metadata;
        bool exists;
    }

    mapping(bytes32 => Document) public documents;
    mapping(address => bytes32[]) public userDocuments;

    event DocumentRegistered(
        bytes32 indexed documentHash,
        address indexed submitter,
        uint256 timestamp,
        string metadata
    );

    error DocumentAlreadyExists();
    error DocumentNotFound();
    error InvalidHash();

    function registerDocument(
        bytes32 _documentHash,
        string memory _metadata
    ) external returns (bool) {
        if (_documentHash == bytes32(0)) revert InvalidHash();
        if (documents[_documentHash].exists) revert DocumentAlreadyExists();

        documents[_documentHash] = Document({
            documentHash: _documentHash,
            submitter: msg.sender,
            timestamp: block.timestamp,
            metadata: _metadata,
            exists: true
        });

        userDocuments[msg.sender].push(_documentHash);

        emit DocumentRegistered(_documentHash, msg.sender, block.timestamp, _metadata);

        return true;
    }

    function verifyDocument(bytes32 _documentHash) external view returns (
        bool exists,
        address submitter,
        uint256 timestamp,
        string memory metadata
    ) {
        Document storage doc = documents[_documentHash];
        return (
            doc.exists,
            doc.submitter,
            doc.timestamp,
            doc.metadata
        );
    }

    function getUserDocuments(address _user) external view returns (bytes32[] memory) {
        return userDocuments[_user];
    }

    function getDocumentCount(address _user) external view returns (uint256) {
        return userDocuments[_user].length;
    }
}
