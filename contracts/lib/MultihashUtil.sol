/*

  Copyright 2017 Loopring Project Ltd (Loopring Foundation).

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/
pragma solidity 0.4.24;
pragma experimental "v0.5.0";
pragma experimental "ABIEncoderV2";

import "./BytesUtil.sol";


/// @title Utility Functions for Multihash signature verificaiton
/// @author Daniel Wang - <daniel@loopring.org>
/// For more information:
///   - https://github.com/saurfang/ipfs-multihash-on-solidity
///   - https://github.com/multiformats/multihash
///   - https://github.com/multiformats/js-multihash
library MultihashUtil {

    enum HashAlgorithm { Ethereum, EIP712 }

    string public constant SIG_PREFIX = "\x19Ethereum Signed Message:\n32";

    function verifySignature(
        address signer,
        bytes32 plaintext,
        bytes   multihash
        )
        internal
        pure
        returns (bool)
    {
        require(multihash.length >= 2, "invalid multihash format");
        uint8 algorithm = uint8(multihash[0]);
        uint8 size = uint8(multihash[1]);
        require(multihash.length == (2 + size), "bad multihash size");

        if (algorithm == uint8(HashAlgorithm.Ethereum)) {
            require(signer != 0x0, "invalid signer address");
            require(size == 65, "bad Ethereum multihash size");
            return signer == ecrecover(
                keccak256(
                    abi.encodePacked(
                        SIG_PREFIX,
                        plaintext
                    )
                ),
                uint8(multihash[2]),
                BytesUtil.bytesToBytes32(multihash, 3),
                BytesUtil.bytesToBytes32(multihash, 3 + 32)
            );
        } else {
            return false;
        }
    }
}
