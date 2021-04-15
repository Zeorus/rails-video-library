const updateWatchList = () => {
  if (document.querySelector('.icon-list')) {
    const addIcons = document.querySelectorAll('.icon-list')
    addIcons.forEach((icon) => {
      icon.addEventListener('click', (event) => {
        const target = event.currentTarget
        const movieTmdbId = target.dataset.movieid;
        const currentPath = window.location.pathname;

        if (target.classList.contains('i-active')) {
          $.ajax({
            type: "POST",
            url: '/removewatchlist',
            data: { movieId: movieTmdbId, currentPath: currentPath }
          });
          target.dataset.originalTitle = "Ajouter à Ma Liste";
          target.classList.remove('i-active');
        } else {
          $.ajax({
            type: "POST",
            url: '/addwatchlist',
            data: { movieId: movieTmdbId, currentPath: currentPath }
          });
          target.classList.add('i-active');
          target.dataset.originalTitle = "Retirer de Ma Liste";
        }
      });
    });
  }
}

export { updateWatchList };