function log(mssg) {
    if (typeof(console) != 'undefined' &&
        typeof(console.log) == 'function') {
        console.log(mssg);
    }
}