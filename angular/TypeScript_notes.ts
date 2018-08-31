// TypeScript_notes.ts

// Variable types: string, number, Boolean, null(undefined), any, void
// var, let, const

const MyName: string = "Marko";

// type unions
let names: string | string[];

// flow control
for (let i = 1; i < 10; i++) {
    console.log(i);
}

let i = 0;
while (i < 10) {
    console.log(i++);
}

let arr: number[] = [1, 2, 4 ,5];
for (let value of arr) {
    console.log(value);
}

//// function
// optional param2
function myFunc(param1: string, param2?: number): string {
    return 'abc';
}
// variable list of args
function myfunc(...args:any[]) {
    for(let arg of args) {
        console.log(typeof(arg));
    }
}
// passing function as arg
obj.asyncMethod(param1, param2, function(err, results){
    // do things
});
function(param){
    return def;
}
(param) => {return def;}
param => def;
