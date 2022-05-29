// Modern dapp browsers...
async function connect() {
  
if (window.ethereum) {
   web3Provider = await window.ethereum;
  try {
    // Request account access
     window.ethereum.enable();
  } catch (error) {
    // User denied account access...
    console.error("User denied account access")
  }
}
// Legacy dapp browsers...
else if (window.web3) {
   web3Provider = await window.web3.currentProvider;
}
// If no injected web3 instance is detected, fall back to Ganache
else {
  web3Provider = await new Web3.providers.HttpProvider('http://127.0.0.1:7545');
}
web3 = new Web3(web3Provider);

}

connect();



function setCookie(cname, cvalue, exdays) {
  const d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  let expires = "expires="+ d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
  let name = cname + "=";
  let decodedCookie = decodeURIComponent(document.cookie);
  let ca = decodedCookie.split(';');
  for(let i = 0; i <ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

