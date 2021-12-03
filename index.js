var count = 0;

function increment() {
    count++;
    document.getElementById('number').innerText = count;
}

function decrement() {
    count--;
    document.getElementById('number').innerText = count;
}