document.addEventListener('DOMContentLoaded', loadWindow, false)

let ws
let createWs = function (){
  ws = new WebSocket("ws://localhost:8080/ws")
  console.log("initialized websocket")

  ws.onopen = function(evt) {
  console.log(evt.type)
  console.log("connected");
  }

  ws.onclose = function() {
    console.log("closed websocket")
    ws.send("close")
    ws.close()
  }

  ws.onmessage = function(evt) {  
    const data = JSON.parse(evt.data)
    switch (true){
      case ("board" in data):      
        displayGrid(data.board)
       // console.log(data.board)
        break      
    }   
  }
}



function displayGrid(arry){
   arry.forEach((value, idx) => {   
    //console.log((Math.floor(idx/8)).toString() + (idx % 8).toString()) 
     let e = document.getElementById(((Math.floor(idx/8)).toString() + (idx % 8).toString()) )
    
       value === '0' ? e.style.display = "none" : e.style.display = "inline"
       value === '0' ? console.log(1) : console.log(0)
   })
}

function mode (btnID) {
    ws.send(btnID)
}

function loadWindow (){
  Array.from(document.getElementsByTagName('button')).forEach(function (value, i, col) {
    col[i].onclick = function (e) { mode(e.target.id) }
  })

  //  setTimeout(function() {
 //   ws.send(2)
 // }, 1000);
 
  createWs()
}
