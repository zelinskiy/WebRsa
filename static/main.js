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

function rsa_keys(){
    var ps = getPrimes(rand(100, 1000));
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
}
