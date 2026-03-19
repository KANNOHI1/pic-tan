/**
 * ピクたん Web Preview — Town-centric redesign
 * 2026-03-19: Full rewrite based on redesign spec
 *
 * Serve from REPO ROOT:
 *   python -m http.server 8000
 *   → http://localhost:8000/apps/web/
 */

// ── Constants ────────────────────────────────────────────────────────

const CONTENT_BASE = '/packages/content/data/ja-JP';

const PARTNERS = {
  rabbit:  { name: 'ルル',  emoji: '🐰', intro: 'よ、よろしくね……だもん！', personality: 'shy' },
  cat:     { name: 'チャイ', emoji: '🐱', intro: 'まあ、よろしく。悪くないにゃ。', personality: 'cool' },
  dog:     { name: 'ポチ',  emoji: '🐶', intro: 'やったー！ともだちだよ！', personality: 'energetic' },
  penguin: { name: 'ペペ',  emoji: '🐧', intro: 'よろしくお願いするであります！', personality: 'serious' },
  bird:    { name: 'ソラ',  emoji: '🐦', intro: 'みてみて〜！なかよくしようさ〜！', personality: 'free' },
};

const THEME_INVITES = {
  animals:       'きょうはもりのなかまにあいにいこう！',
  fruits:        'おいしそうなくだものをさがしにいこう！',
  colors:        'きれいないろをさがしにいこう！',
  g7_flags:      'とおくのくにのはたをさがしにいこう！',
  g20_flags:     'せかいのはたをあつめにいこう！',
  eurozone_flags:'ヨーロッパのはたをさがしにいこう！',
};

const THEMES = [
  { id: 'animals',        nameJA: 'どうぶつ',    path: `${CONTENT_BASE}/animals.json` },
  { id: 'fruits',         nameJA: 'くだもの',    path: `${CONTENT_BASE}/fruits.json` },
  { id: 'colors',         nameJA: 'いろ',        path: `${CONTENT_BASE}/colors.json` },
  { id: 'g7_flags',       nameJA: 'G7こっき',    path: `${CONTENT_BASE}/g7_flags.json` },
  { id: 'g20_flags',      nameJA: 'G20こっき',   path: `${CONTENT_BASE}/g20_flags.json` },
  { id: 'eurozone_flags', nameJA: 'ユーロこっき', path: `${CONTENT_BASE}/eurozone_flags.json` },
];

const SESSION_SIZE = 8;
const FRIENDSHIP_THRESHOLD = 10; // まちへの引っ越し条件

// ── LocalStorage helpers ─────────────────────────────────────────────

const ls = {
  get: (k, def = null) => { try { return JSON.parse(localStorage.getItem(k) ?? 'null') ?? def; } catch { return def; } },
  set: (k, v) => localStorage.setItem(k, JSON.stringify(v)),
};

function getPartner()      { return ls.get('pictan_partner'); }
function setPartner(id)    { ls.set('pictan_partner', id); }
function getFriendships()  { return ls.get('pictan_friendships', {}); }
function setFriendships(f) { ls.set('pictan_friendships', f); }
function getNextReview()   { return ls.get('pictan_next_review', {}); }
function setNextReview(r)  { ls.set('pictan_next_review', r); }
function getStreak()       { return ls.get('pictan_streak', { count: 0, date: '' }); }
function setStreak(s)      { ls.set('pictan_streak', s); }

function todayStr() { return new Date().toISOString().slice(0, 10); }
function addDays(dateStr, n) {
  const d = new Date(dateStr);
  d.setDate(d.getDate() + n);
  return d.toISOString().slice(0, 10);
}

function updateStreak() {
  const today = todayStr();
  const s = getStreak();
  const yesterday = addDays(today, -1);
  let count;
  if (s.date === today)      count = s.count;
  else if (s.date === yesterday) count = s.count + 1;
  else                       count = 1;
  setStreak({ count, date: today });
  return count;
}

// ── Friendship helpers ───────────────────────────────────────────────

function addFriendship(cardId, isReview, knew) {
  const f = getFriendships();
  const prev = f[cardId] || 0;
  const delta = isReview ? (knew ? 3 : 1) : (knew ? 2 : 1);
  f[cardId] = prev + delta;
  setFriendships(f);
  return { prev, next: f[cardId] };
}

function getResidents() {
  const f = getFriendships();
  return Object.entries(f)
    .filter(([, v]) => v >= FRIENDSHIP_THRESHOLD)
    .map(([id, v]) => ({ id, friendship: v }));
}

// ── Spaced repetition ────────────────────────────────────────────────

function updateReviewDate(cardId, knew) {
  const r = getNextReview();
  const today = todayStr();
  if (knew) {
    const cur = r[cardId];
    if (!cur || cur <= today)     r[cardId] = addDays(today, 1);
    else if (cur <= addDays(today, 1)) r[cardId] = addDays(today, 3);
    else                           r[cardId] = addDays(today, 7);
  } else {
    r[cardId] = today; // review next session
  }
  setNextReview(r);
}

function formatReviewDate(dateStr) {
  const today = todayStr();
  const tom   = addDays(today, 1);
  if (dateStr === today || dateStr < today) return 'つぎのセッション';
  if (dateStr === tom)  return 'あした';
  const days = Math.round((new Date(dateStr) - new Date(today)) / 86400000);
  return `${days}日後`;
}

// ── Session builder ──────────────────────────────────────────────────

function buildSession(allCards) {
  const reviews = getNextReview();
  const today = todayStr();
  const due    = allCards.filter(c => reviews[c.id] && reviews[c.id] <= today);
  const fresh  = allCards.filter(c => !reviews[c.id]);
  const seen   = allCards.filter(c => reviews[c.id] && reviews[c.id] > today);

  const session = [];
  session.push(...due.slice(0, 3));
  session.push(...fresh.slice(0, SESSION_SIZE - session.length));
  if (session.length < SESSION_SIZE) session.push(...seen.slice(0, SESSION_SIZE - session.length));

  // Shuffle lightly
  for (let i = session.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [session[i], session[j]] = [session[j], session[i]];
  }
  return session.slice(0, SESSION_SIZE);
}

// ── Town level ───────────────────────────────────────────────────────

function getTownImageLevel(residentCount) {
  if (residentCount === 0) return 1;
  return Math.min(residentCount + 1, 12);
}

function townImagePath(level) {
  const n = String(level).padStart(2, '0');
  return `/apps/web/assets/town/town_level_${n}.png`;
}

// ── Image helpers ────────────────────────────────────────────────────

function cardImageHTML(card, themeId) {
  const src = `/apps/web/assets/${themeId}/${card.id}.png`;
  return `<img src="${src}" alt="${card.wordEN}"
    onerror="this.style.display='none';this.nextElementSibling.style.display='inline'">` +
    `<span class="card-emoji" style="display:none">${card.emoji}</span>`;
}

// ── Theme selection ──────────────────────────────────────────────────

function pickTodaysTheme() {
  // Rotate by day: animals → fruits → colors → animals...
  const idx = new Date().getDay() % 3;
  return THEMES[idx];
}

// ── State ────────────────────────────────────────────────────────────

const state = {
  partner:      null, // partner id
  theme:        null, // theme object
  cards:        [],   // all cards for theme
  session:      [],   // current session cards
  pos:          0,    // current card index
  tapStage:     0,    // 0=image, 1=english, 2=japanese+rating
  sessionLog:   [],   // { card, knew, isReview }
  lastAnimal:   null, // most recent card in session
};

// ── Screen routing ───────────────────────────────────────────────────

function showScreen(id) {
  ['partnerScreen', 'homeScreen', 'playScreen', 'completeScreen'].forEach(s => {
    const el = document.getElementById(s);
    if (el) el.hidden = (s !== id);
  });
}

// ── Screen 1: Partner selection ──────────────────────────────────────

function initPartnerScreen() {
  const list = document.getElementById('partnerList');
  list.innerHTML = '';

  Object.entries(PARTNERS).forEach(([id, p]) => {
    const card = document.createElement('div');
    card.className = 'partner-card';
    card.setAttribute('role', 'option');
    card.setAttribute('aria-selected', 'false');
    card.dataset.id = id;
    card.innerHTML = `
      <span class="partner-emoji">${p.emoji}</span>
      <span class="partner-name">${p.name}</span>
    `;
    card.addEventListener('click', () => selectPartner(id));
    list.appendChild(card);
  });

  document.getElementById('partnerDecideBtn').addEventListener('click', decidePartner);
}

function selectPartner(id) {
  // Update cards
  document.querySelectorAll('.partner-card').forEach(c => {
    const selected = c.dataset.id === id;
    c.classList.toggle('selected', selected);
    c.setAttribute('aria-selected', String(selected));
  });

  // Show bubble
  const p = PARTNERS[id];
  const bubbleWrap = document.getElementById('partnerBubbleWrap');
  const bubble = document.getElementById('partnerBubble');
  bubble.textContent = `${p.emoji} 「${p.intro}」`;
  bubbleWrap.hidden = false;

  // Enable button
  const btn = document.getElementById('partnerDecideBtn');
  btn.disabled = false;
  btn.dataset.selected = id;
}

function decidePartner() {
  const id = document.getElementById('partnerDecideBtn').dataset.selected;
  if (!id) return;
  setPartner(id);
  state.partner = id;
  initHomeScreen();
  showScreen('homeScreen');
}

// ── Screen 2: Home ───────────────────────────────────────────────────

async function initHomeScreen() {
  const partnerId = state.partner || getPartner();
  const p = PARTNERS[partnerId];
  const theme = pickTodaysTheme();
  state.theme = theme;

  // Town image
  const residents = getResidents();
  const level = getTownImageLevel(residents.length);
  const townImg = document.getElementById('townImage');
  townImg.src = townImagePath(level);
  townImg.onerror = () => { townImg.style.display = 'none'; };

  // Partner in town
  document.getElementById('partnerInTown').textContent = p.emoji;

  // Bubble
  document.getElementById('homeBubble').textContent =
    `${p.emoji} 「${THEME_INVITES[theme.id] || 'きょうも一緒にいこうね！'}」`;

  // Streak
  const streak = getStreak();
  const streakWrap = document.getElementById('streakWrap');
  if (streak.count >= 2) {
    const icon = streak.count >= 7 ? '🔥' : streak.count >= 3 ? '🌟' : '✨';
    document.getElementById('streakBadge').textContent = `${icon} ${streak.count}日れんぞく！`;
    streakWrap.hidden = false;
  } else {
    streakWrap.hidden = true;
  }

  // Load cards
  try {
    const res  = await fetch(theme.path);
    const data = await res.json();
    state.cards = data;
  } catch (e) {
    console.error('カード読み込み失敗', e);
    state.cards = [];
  }

  document.getElementById('goBtn').onclick = startSession;
  document.getElementById('parentBtn').onclick = openParentPanel;
}

// ── Session start ─────────────────────────────────────────────────────

function startSession() {
  if (!state.cards.length) return;

  const reviews = getNextReview();
  const today = todayStr();
  state.session = buildSession(state.cards);
  state.pos = 0;
  state.tapStage = 0;
  state.sessionLog = [];

  renderProgressDots();
  renderCard();
  showScreen('playScreen');
}

// ── Screen 3: Card study ─────────────────────────────────────────────

function renderProgressDots() {
  const wrap = document.getElementById('playProgress');
  wrap.innerHTML = '';
  state.session.forEach((_, i) => {
    const dot = document.createElement('div');
    dot.className = 'progress-dot' +
      (i < state.pos ? ' done' : i === state.pos ? ' current' : '');
    wrap.appendChild(dot);
  });
}

function renderCard() {
  const card = state.session[state.pos];
  if (!card) return;

  state.tapStage = 0;
  state.lastAnimal = card;

  // Image
  const imageWrap = document.getElementById('cardImageWrap');
  imageWrap.innerHTML = cardImageHTML(card, state.theme.id);

  // Hide text
  document.getElementById('cardWordEn').hidden = true;
  document.getElementById('cardWordJa').hidden = true;
  document.getElementById('ratingWrap').hidden = true;
  document.getElementById('tapHint').textContent = 'こたえは？';
  document.getElementById('tapHint').hidden = false;

  // Tap handler
  const studyCard = document.getElementById('studyCard');
  studyCard.onclick = handleCardTap;
  studyCard.onkeydown = e => { if (e.key === 'Enter' || e.key === ' ') handleCardTap(); };
}

function handleCardTap() {
  const card = state.session[state.pos];
  state.tapStage++;

  if (state.tapStage === 1) {
    // Show English and Japanese simultaneously
    const en = document.getElementById('cardWordEn');
    en.textContent = card.wordEN;
    en.hidden = false;

    const ja = document.getElementById('cardWordJa');
    ja.textContent = card.wordJA;
    ja.hidden = false;

    document.getElementById('tapHint').hidden = true;
    document.getElementById('ratingWrap').hidden = false;

    // Disable card tap
    document.getElementById('studyCard').onclick = null;

    // Rating handlers
    document.querySelectorAll('.btn-rating').forEach(btn => {
      btn.onclick = () => handleRating(btn.dataset.rating === 'knew');
    });
  }
  // stage2+ は評価ボタンが処理する
}

function handleRating(knew) {
  const card = state.session[state.pos];
  const reviews = getNextReview();
  const isReview = !!(reviews[card.id] && reviews[card.id] <= todayStr());

  // Update friendship
  addFriendship(card.id, isReview, knew);
  // Update spaced repetition
  updateReviewDate(card.id, knew);

  // Log
  state.sessionLog.push({ card, knew, isReview });

  // Next
  state.pos++;
  renderProgressDots();

  if (state.pos >= state.session.length) {
    showCompleteScreen();
  } else {
    renderCard();
  }
}

// ── Screen 4: Complete ───────────────────────────────────────────────

function showCompleteScreen() {
  updateStreak();

  const partnerId = state.partner || getPartner();
  const p = PARTNERS[partnerId];
  const lastCard = state.lastAnimal;

  // Animations
  document.getElementById('completePartner').textContent = p.emoji;
  document.getElementById('completeAnimal').textContent = lastCard?.emoji || '🌟';

  // Message
  const name = lastCard?.wordJA || 'みんな';
  document.getElementById('completeMsg').textContent =
    `${p.name}と${name}がなかよしになったよ！`;

  // Friendship meter
  const f = getFriendships();
  const friendship = lastCard ? (f[lastCard.id] || 0) : 0;
  const meter = document.getElementById('friendshipMeter');
  meter.innerHTML = '';
  const total = Math.min(friendship, 15);
  for (let i = 0; i < total; i++) {
    const heart = document.createElement('span');
    heart.textContent = '♡';
    heart.style.color = 'var(--pink)';
    meter.appendChild(heart);
  }

  // Move-in check
  const moveIn = document.getElementById('moveInNotice');
  if (lastCard && friendship >= FRIENDSHIP_THRESHOLD && friendship - (state.sessionLog.at(-1)?.knew ? 2 : 1) < FRIENDSHIP_THRESHOLD) {
    document.getElementById('moveInText').textContent =
      `${lastCard.wordJA}がまちに引っ越してきた！`;
    moveIn.hidden = false;
  } else {
    moveIn.hidden = true;
  }

  document.getElementById('nextDayBtn').onclick = () => {
    initHomeScreen();
    showScreen('homeScreen');
  };

  showScreen('completeScreen');
}

// ── Parent panel ─────────────────────────────────────────────────────

function openParentPanel() {
  renderParentPanel();
  document.getElementById('parentPanel').hidden = false;
  document.getElementById('parentCloseBtn').onclick = closeParentPanel;
  document.getElementById('parentBackdrop').onclick = closeParentPanel;
}

function closeParentPanel() {
  document.getElementById('parentPanel').hidden = true;
}

function renderParentPanel() {
  // Today's words
  const todayEl = document.getElementById('todayWords');
  if (state.sessionLog.length) {
    todayEl.innerHTML = state.sessionLog
      .map(({ card }) => `<span class="word-tag">${card.wordJA} / ${card.wordEN}</span>`)
      .join('');
  } else {
    todayEl.innerHTML = '<span style="color:var(--muted);font-size:0.9rem">まだれんしゅうしていないよ</span>';
  }

  // Review schedule
  const r = getNextReview();
  const f = getFriendships();
  const schedEl = document.getElementById('reviewSchedule');
  const cards = state.session.slice(0, state.pos);
  if (cards.length) {
    schedEl.innerHTML = cards.map(card => {
      const when = r[card.id] ? formatReviewDate(r[card.id]) : 'つぎのセッション';
      return `<div class="review-item">
        <span>${card.wordJA} / ${card.wordEN}</span>
        <span class="review-when">${when}</span>
      </div>`;
    }).join('');
  } else {
    schedEl.innerHTML = '<span style="color:var(--muted);font-size:0.9rem">データなし</span>';
  }

  // Residents
  const residents = getResidents();
  const resEl = document.getElementById('residentList');
  if (residents.length) {
    // Find card data for resident IDs
    const allF = getFriendships();
    resEl.innerHTML = residents.map(({ id, friendship }) => {
      // Find card from theme
      const card = state.cards.find(c => c.id === id);
      const label = card ? `${card.emoji} ${card.wordJA}` : id;
      const hearts = '♡'.repeat(Math.min(Math.floor(friendship / 5), 5));
      return `<div class="resident-item">
        <span>${label}</span>
        <span class="resident-hearts">${hearts}</span>
      </div>`;
    }).join('');
  } else {
    resEl.innerHTML = '<span class="resident-empty">まだじゅうみんがいないよ。なかよし度10でひっこしてくるよ！</span>';
  }
}

// ── Init ─────────────────────────────────────────────────────────────

async function init() {
  const savedPartner = getPartner();

  if (savedPartner && PARTNERS[savedPartner]) {
    state.partner = savedPartner;
    await initHomeScreen();
    showScreen('homeScreen');
  } else {
    initPartnerScreen();
    showScreen('partnerScreen');
  }
}

init();
