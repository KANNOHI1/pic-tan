(function (root, factory) {
  const api = factory();
  if (typeof module !== 'undefined' && module.exports) {
    module.exports = api;
  }
  if (root) {
    root.PicTanUiState = api;
  }
})(typeof globalThis !== 'undefined' ? globalThis : this, function () {
  function getNextCardRevealState(tapStage) {
    if (tapStage === 0) {
      return {
        nextStage: 1,
        showEn: true,
        showJa: false,
        showRatings: false,
        hintText: 'もういちど →',
        consumeTap: true,
      };
    }

    if (tapStage === 1) {
      return {
        nextStage: 2,
        showEn: true,
        showJa: true,
        showRatings: true,
        hintText: '',
        consumeTap: true,
      };
    }

    return {
      nextStage: 2,
      showEn: true,
      showJa: true,
      showRatings: true,
      hintText: '',
      consumeTap: false,
    };
  }

  function getScreenTransitionMode(currentId, nextId) {
    return currentId && currentId !== nextId ? 'swap' : 'enter';
  }

  return {
    getNextCardRevealState,
    getScreenTransitionMode,
  };
});
