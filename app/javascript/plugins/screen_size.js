const tileNumberCalculator = (windowSize) => {
  if (windowSize <= 560) {
    return 1;
  } else if (windowSize > 560 && windowSize <= 750) {
    return 2;
  } else if (windowSize > 750 && windowSize <= 875) {
    return 3;
  } else if (windowSize > 875 && windowSize <= 1000) {
    return 4;
  } else if (windowSize > 1000 && windowSize <= 1200) {
    return 5;
  } else if (windowSize > 1200 && windowSize <= 1500) {
    return 6;
  } else {
    return 7
  }
}

const loadCarrousel = (tileNumber) => {
  $.ajax({
    type: "POST",
    url: '/loadcarrousel',
    data: { y: tileNumber }
  });
}

const checkScreenSize = () => {
  if (window.location.pathname == "/") {
    const carrouselContainer = document.getElementById('page-container')

    if (carrouselContainer.dataset.load == "false") {
      const tileNumber = tileNumberCalculator($(window).width());
      loadCarrousel(tileNumber);
    }

    window.addEventListener('resize', (event) => {
      const tileNumber = tileNumberCalculator($(window).width());
      if (window.location.search != `?y=${tileNumber}`) {
        loadCarrousel(tileNumber);
      }
    })
  }
}


export { checkScreenSize };