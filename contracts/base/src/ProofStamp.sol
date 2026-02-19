// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title ProofStamp Contract
/// @author solidworkssa
/// @notice Decentralized document verification and timestamping.
contract ProofStamp {
    string public constant VERSION = "1.0.0";


    struct Proof {
        bytes32 documentHash;
        address owner;
        uint256 timestamp;
        string metadataURI;
    }
    
    mapping(bytes32 => Proof) public proofs;
    
    event ProofCreated(bytes32 indexed documentHash, address indexed owner, uint256 timestamp);
    
    function stamp(bytes32 _documentHash, string memory _metadataURI) external {
        require(proofs[_documentHash].timestamp == 0, "Proof already exists");
        proofs[_documentHash] = Proof({
            documentHash: _documentHash,
            owner: msg.sender,
            timestamp: block.timestamp,
            metadataURI: _metadataURI
        });
        emit ProofCreated(_documentHash, msg.sender, block.timestamp);
    }
    
    function verify(bytes32 _documentHash) external view returns (bool, address, uint256, string memory) {
        Proof memory p = proofs[_documentHash];
        return (p.timestamp != 0, p.owner, p.timestamp, p.metadataURI);
    }

}
