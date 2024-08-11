// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/utils/Context.sol

// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: ZDAPP/PNP/PNPController3.sol

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/IERC20/IERC20.sol";

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant NOT_ENTERED = 1;
    uint256 private constant ENTERED = 2;

    uint256 private _status;

    /**
     * @dev Unauthorized reentrant call.
     */
    error ReentrancyGuardReentrantCall();

    constructor() {
        _status = NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be NOT_ENTERED
        if (_status == ENTERED) {
            revert ReentrancyGuardReentrantCall();
        }

        // Any calls to nonReentrant after this point will fail
        _status = ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == ENTERED;
    }
}

interface IERC20 {
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function mint(uint256 amount) external returns (uint256);

    function destroy(uint256 amount) external returns (uint256);

    function getPrice() external view returns (uint256);
}

interface IAONFT {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) external view returns (address);

    function queryUserTokenIds(address account)
        external
        view
        returns (uint256[] memory);

    function mintNft(address to) external returns (uint256);
}

struct FlightNoInfo {
    string flightNo; // Flight number
    uint256 date; // Flight date
    uint256 plannedTakeoffTime; // Planned takeoff actual
    uint256 plannedlandingTime; // Planned landing actual
    uint256 actualTakeoffTime; // Actual takeoff actual
    uint256 actualLandingTime; // Actual landing actual
}

interface IFlightNoInfo {
    function getFlightNoInfo(string memory flightNo, uint256 date)
        external
        view
        returns (FlightNoInfo memory);
}

contract AOInsurance is Ownable, ReentrancyGuard {
    event BindRecommender(address indexed account, address indexed recommender);
    event BuyInsurance(
        address indexed account,
        string flightNo,
        uint256 date,
        uint256 policyAmount
    );
    event Compensation(
        address indexed account,
        uint256 tokenId,
        string flightNo,
        uint256 date,
        uint256 compensationAmount
    );

    IAONFT public AON;
    IERC20 public USDT;
    IFlightNoInfo public FLI;
    address public prizePool;

    struct InsurancePolicy {
        uint256 tokenId; // nft tokenId
        string flightNo; // Flight number
        uint256 date; // index of the voted proposal
        uint256 policyAmount; // Policy amount
        uint256 policyStatus; //Policy status:0-Not effective，1-Paid compensation，2-No compensation required
    }

    mapping(uint256 => InsurancePolicy) public inssrancePolicys;
    mapping(string => mapping(uint256 => uint256)) public flightNoInsurancePHR; //flightNo-- date --InsurancePHR
    mapping(address => uint256) public myPoints;

    uint256 public perFlightNoInsurancePHRLimit = 500;

    uint256 public insurancePrice = 20 * 10**18;
    uint256 public insuranceAmountLimit = 1;
    uint256[] public compensationRate = [2, 3];
    uint256[] public delayTime = [30 minutes, 2 hours];
    uint256[] public premiumDistribution = [5, 10, 15];

    address public fundAddress = 0x57f00454FF7ba629F53Ce0521EeD59e14f46D446;
    address private deadAddress = 0x000000000000000000000000000000000000dEaD;

    uint256 private constant MAX = ~uint256(0);

    constructor(
        address _AON,
        address _USDT,
        address _prizePool
    ) {
        AON = IAONFT(_AON);
        USDT = IERC20(_USDT);
        prizePool = _prizePool;
    }

    function updateAON(address aon) external onlyOwner {
        AON = IAONFT(aon);
    }

    function updateUSDT(address usdt) external onlyOwner {
        USDT = IERC20(usdt);
    }

    function updateFlightNoInfo(address fli) external onlyOwner {
        FLI = IFlightNoInfo(fli);
    }

    function updatePrizePool(address pool) external onlyOwner {
        prizePool = pool;
    }

    function updatePerFlightNoInsurancePHRLimit(uint256 limit)
        external
        onlyOwner
    {
        perFlightNoInsurancePHRLimit = limit;
    }

    function updateInsuranceAmountLimit(uint256 limit) external onlyOwner {
        insuranceAmountLimit = limit;
    }

    function updateInsurancePrice(uint256 price) external onlyOwner {
        insurancePrice = price;
    }

    function updateCompensationRate(uint256[] memory rate) external onlyOwner {
        compensationRate = rate;
    }

    function updateDelayTime(uint256[] memory times) external onlyOwner {
        delayTime = times;
    }

    function updatePremiumDistribution(uint256[] memory distribution)
        external
        onlyOwner
    {
        premiumDistribution = distribution;
    }

    function rescueToken(address token, uint256 amount) external onlyOwner {
        IERC20(token).transfer(msg.sender, amount);
    }

    function buyInsurance(
        address referrer,
        string memory flightNo,
        uint256 date,
        uint256 policyAmount
    ) public nonReentrant {
        // FlightNoInfo memory fli = FLI.getFlightNoInfo(flightNo, date);
        // require(
        //     block.timestamp + 30 days > fli.plannedTakeoffTime &&
        //         block.timestamp + 2 hours < fli.plannedTakeoffTime,
        //     "not yet at the time of purchase"
        // );
        require(
            policyAmount > 0 && policyAmount <= insuranceAmountLimit,
            "wrong eth amount"
        );
        require(
            flightNoInsurancePHR[flightNo][date] < perFlightNoInsurancePHRLimit,
            "exceed limit"
        );
        flightNoInsurancePHR[flightNo][date]++;

        uint256 value = policyAmount * insurancePrice;
        require(
            USDT.transferFrom(msg.sender, address(this), value) &&
                USDT.transfer(
                    prizePool,
                    (value * premiumDistribution[0]) / 100
                ) &&
                USDT.transfer(
                    fundAddress,
                    (value * premiumDistribution[1]) / 100
                ),
            "transfer failed"
        );
        if (referrer != address(0) && referrer != deadAddress) {
            require(
                USDT.transfer(referrer, (value * premiumDistribution[2]) / 100),
                "transfer failed"
            );
        }

        for (uint256 i = 0; i < policyAmount; i++) {
            uint256 tokenId = AON.mintNft(msg.sender);
            inssrancePolicys[tokenId] = InsurancePolicy(
                tokenId,
                flightNo,
                date,
                policyAmount,
                0
            );
        }

        myPoints[msg.sender] += value;

        emit BuyInsurance(msg.sender, flightNo, date, policyAmount);
    }

    function compensation(uint256 tokenId) public nonReentrant {
        require(AON.ownerOf(tokenId) == msg.sender, "not owner");
        require(
            inssrancePolicys[tokenId].policyStatus == 0,
            "paid compensation"
        );

        FlightNoInfo memory fli = FLI.getFlightNoInfo(
            inssrancePolicys[tokenId].flightNo,
            inssrancePolicys[tokenId].date
        );

        uint256 compensationAmount;
        uint256 i;
        for (i = 0; i < compensationRate.length; i++) {
            if (
                fli.actualTakeoffTime > fli.plannedTakeoffTime + delayTime[i] ||
                fli.actualLandingTime > fli.plannedlandingTime + delayTime[i]
            ) {
                compensationAmount =
                    inssrancePolicys[tokenId].policyAmount *
                    compensationRate[i];
            }
        }

        if (compensationAmount > 0) {
            require(
                USDT.transfer(msg.sender, compensationAmount),
                "transfer failed"
            );
            inssrancePolicys[tokenId].policyStatus = 1;
        } else {
            inssrancePolicys[tokenId].policyStatus = 2;
        }

        emit Compensation(
            msg.sender,
            tokenId,
            inssrancePolicys[tokenId].flightNo,
            inssrancePolicys[tokenId].date,
            compensationAmount
        );
    }

    function queryUserInssrancePolicyss(address user, uint256 policyStatus)
        public
        view
        returns (InsurancePolicy[] memory myInssrancePolicys)
    {
        uint256[] memory tokenIds = AON.queryUserTokenIds(user);
        uint256 count;
        uint256 i;
        for (i = 0; i < tokenIds.length; i++) {
            if (inssrancePolicys[tokenIds[i]].policyStatus == policyStatus) {
                myInssrancePolicys[count] = inssrancePolicys[tokenIds[i]];
                count++;
            }
        }
    }
}
