// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

//create contract
contract Todo{

//Event Create
event Create(address receipient, uint id);
event Delete(uint taskId, bool isDone);

//task structure initialise
struct Task{
  uint id;
  string taskName;
  bool isDone;
}

//create array in task structure
Task[] private tasks;

//create a mapping for store data's
mapping(uint => address) taskOwner;

//create Task
function createTask(string memory taskName, bool isDone ) external {
 uint id = tasks.length;
 tasks.push(Task(id,taskName,isDone));
 taskOwner[id] = msg.sender;
 emit Create(msg.sender,id);
}

//Delete Task
function deleteTask(uint id, bool isDone) external {
   if(taskOwner[id] == msg.sender){
    tasks[id].isDone = isDone;
  emit Delete(id,isDone);
  }
}

//get tasks
function myTask() external view returns(Task[] memory){
  Task[] memory list = new Task[](tasks.length);
  uint count = 0;
  for(uint i=0;i<tasks.length;i++){
    if(taskOwner[i] == msg.sender && tasks[i].isDone == false){
    list[count] = tasks[i];
    count++;
    }
  }

  Task[] memory myList = new Task[] (count);
  for(uint i=0;i<count;i++){
    myList[i]  = list[i];
  }
  return myList;

  }


}