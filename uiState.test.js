const test = require('node:test');
const assert = require('node:assert/strict');

const {
  getNextCardRevealState,
  getScreenTransitionMode,
} = require('./uiState.js');

test('first card tap reveals only English and updates the hint', () => {
  assert.deepEqual(getNextCardRevealState(0), {
    nextStage: 1,
    showEn: true,
    showJa: false,
    showRatings: false,
    hintText: 'もういちど →',
    consumeTap: true,
  });
});

test('second card tap reveals Japanese and ratings', () => {
  assert.deepEqual(getNextCardRevealState(1), {
    nextStage: 2,
    showEn: true,
    showJa: true,
    showRatings: true,
    hintText: '',
    consumeTap: true,
  });
});

test('card stays on rating state after second tap', () => {
  assert.deepEqual(getNextCardRevealState(2), {
    nextStage: 2,
    showEn: true,
    showJa: true,
    showRatings: true,
    hintText: '',
    consumeTap: false,
  });
});

test('screen transitions use swap mode only when changing visible screens', () => {
  assert.equal(getScreenTransitionMode('homeScreen', 'playScreen'), 'swap');
  assert.equal(getScreenTransitionMode('playScreen', 'playScreen'), 'enter');
  assert.equal(getScreenTransitionMode(null, 'partnerScreen'), 'enter');
});
