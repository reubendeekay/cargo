/*
Given an array of integers reverse the given array in place using an index and loop rather than using the built in reverse method.
*/

const reverseArray = (arr) => {
  let index = arr.length - 1;
  let newArr = [];
  for (let i = 0; i < arr.length; i++) {
    newArr[i] = arr[index];
    index--;
  }
};
