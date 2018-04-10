function encodeRequest(){
    inp = document.getElementById("inp");
    msg = inp.value

    var e = document.getElementById("e").value;
    var n = document.getElementById("n").value
    
    var xhr = new XMLHttpRequest();      
    xhr.open('GET', '../encode/' + e + '/' + n + '/' + msg, false);
    xhr.send();
    
    out = document.getElementById("out");
    out.innerHTML = xhr.responseText
}

function decodeRequest(){
    inp = document.getElementById("inp");
    msg = inp.value

    var d = document.getElementById("d").value;
    var n = document.getElementById("n").value
    
    var xhr = new XMLHttpRequest();      
    xhr.open('GET', '../decode/' + d + '/' + n + '/' + msg, false);
    xhr.send();
    
    out = document.getElementById("out");
    out.innerHTML = xhr.responseText
}

// get two last primes
function getPrimes(max) {
    var sieve = [], i, j, primes = [];
    for (i = 2; i <= max; ++i) {
	if (!sieve[i]) {
	    primes.push(i);
            for (j = i << 1; j <= max; j += i) sieve[j] = true; 
        }
    }
    return primes.slice(-2);
}

function rand(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

function egcd(a, b) {
    if (a == 0)
        return b;

    while (b != 0) {
        if (a > b)
            a = a - b;
        else
            b = b - a;
    }

    return a;
}

function myE(tot) {
    for (n = 2; n < tot - 1; n++){
	if (egcd(n, tot) == 1) return n
    }
}

function myD(e, n, phi) {
    for (d = 1; d < n; n++){
	if ((d * e) % phi == 1) return d;
    }
}

function toFixed(x) {
  if (Math.abs(x) < 1.0) {
    var e = parseInt(x.toString().split('e-')[1]);
    if (e) {
        x *= Math.pow(10,e-1);
        x = '0.' + (new Array(e)).join('0') + x.toString().substring(2);
    }
  } else {
    var e = parseInt(x.toString().split('+')[1]);
    if (e > 20) {
        e -= 20;
        x /= Math.pow(10,e);
        x += (new Array(e+1)).join('0');
    }
  }
  return x;
}


function rsa_keys(){
    var from = parseInt(document.getElementById("from").value)
    var to = parseInt(document.getElementById("to").value)
    var start = performance.now();
    var ps = getPrimes(rand(from, to));
    var p1 = ps[0]
    document.getElementById("p1").value = p1
    var p2 = ps[1]    
    document.getElementById("p2").value = p2
    var tot = (p1 - 1) * (p2 - 1)
    document.getElementById("tot").value = tot
    var e = myE(tot);
    document.getElementById("e").value = e
    var n = p1 * p2;
    document.getElementById("n").value = n
    //var d = myD(e, n, tot);
    //document.getElementById("d").value = d;
    var end = performance.now();
    document.getElementById("t").innerHTML =
	(end - start).toPrecision(3);
}
