const app = document.getElementById('root');

const logo = document.createElement('img');
logo.src = 'logo.png';

const container = document.getElementById('table');

const post = document.getElementById('post');
post.setAttribute('class', 'container');

app.appendChild(logo);

var request = new XMLHttpRequest();
request.open('GET', 'https://d2x9c7loby05c5.cloudfront.net/id/', true);  // add the cloudfront or api gateway url here
request.onload = function () {

count = 0;
  // Begin accessing JSON data here
  var data = JSON.parse(this.response);
  if (request.status >= 200 && request.status < 400) {
    data.forEach(list => {
        const card = document.createElement('tr');
        card.setAttribute('class', 'card');

        const th1 = document.createElement('td');
        th1.textContent = list["0"].id;
        //console.log(list["0"].id)
        console.log(data.length)
        
        const th2 = document.createElement('td');
        th2.textContent = list["0"].details.timeOccured;
        const th5 = document.createElement('td');
        th5.textContent = list["0"].details.status;


        container.appendChild(card);
        card.appendChild(th1);
        card.appendChild(th2);
        card.appendChild(th5);

        // if condition to get the last element in the api to state out the current status
        if (count === data.length - 1){
          const p1 = document.getElementById('p1');
          const p2 = document.getElementById('p2');
          p1.textContent = list["0"].details.status;
          p2.textContent = list["0"].details.timeOccured;
        }
        count++
    });
  } else {
    const errorMessage = document.createElement('marquee');
    errorMessage.textContent = `Gah, it's not working!`;
    app.appendChild(errorMessage);
  }
}

request.send();

function openDoor() {
  var xmlhttp = new XMLHttpRequest();   // new HttpRequest instance 
  var theUrl = "https://d2x9c7loby05c5.cloudfront.net/postit"; // add the cloudfront or api gateway url here
  xmlhttp.open("POST", theUrl);
  xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xmlhttp.send(JSON.stringify({ "Status": "open" }));
  const p1 = document.getElementById('p1');
  p1.textContent = "open";
}

function closeDoor() {
  var xmlhttp = new XMLHttpRequest();   // new HttpRequest instance 
  var theUrl = "https://d2x9c7loby05c5.cloudfront.net/postit"; // add the cloudfront or api gateway url here
  xmlhttp.open("POST", theUrl);
  xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xmlhttp.send(JSON.stringify({ "Status": "close" }));
  const p1 = document.getElementById('p1');
  p1.textContent = "close";
}