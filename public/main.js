/* eslint-disable no-undef */
const startUrl = process.env.NWJS_START_URL || '../build/index.html';

nw.Window.open(startUrl, {}, function(win) {});