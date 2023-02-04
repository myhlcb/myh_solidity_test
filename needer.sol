pragma solidity ^0.4.0;
// 众筹项目
// 区块链上保存众筹发起者列表
// 每个众筹发起者要记录众筹数目,已众筹数目,捐赠人数,每一笔捐赠的数目和地址
// 众筹发起人地址;0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
contract needTest{
    struct sender{
        address sendAddress;
        uint val;
    }
    struct needer{
        address needAddress;
        uint goal;
        uint allQuantity;
        uint allSenderNum;
        mapping(uint=>sender) sendList;
    }
     uint neederId;
     mapping(uint=>needer) needList;
    // // 获取众筹列表
    // function getNeederList() view public returns(mapping){
    //     return needList;
    // }
    // // 获取众筹详情
    function getNeederById(uint _needId) view public returns(address,uint,uint,uint){
        return (needList[_needId].needAddress,
        needList[_needId].goal,
        needList[_needId].allQuantity,
        needList[_needId].allSenderNum);
    }
    // 获取address余额
    function getQuantity(address _address)view public returns(uint){
        return _address.balance;
    }
    // 发起众筹
    function newNeed(address _needAddress,uint _goal) public{
        neederId++;
        needList[neederId] = needer(_needAddress,_goal,0,0);
    }
    // 众筹
    function contribute(address _address, uint _needId) payable{
        needer storage _needer = needList[_needId];
        _needer.allQuantity += msg.value;
        _needer.allSenderNum++;
        _needer.sendList[_needer.allSenderNum] = sender(_address,msg.value);
    }
    // 是否完成
    function isCompleted(uint _needId){
        needer storage _needer = needList[_needId];
        // 众筹的钱够了,则从合约打到众筹发起人账户;
        if(_needer.allQuantity > _needer.goal){
            _needer.needAddress.transfer(_needer.allQuantity);
        }
    }
}
