const updateSeen = () => {
  if (document.querySelector('.icon-library')) {
    const addIcons = document.querySelectorAll('.icon-library')
    addIcons.forEach((icon) => {
      icon.addEventListener('click', (event) => {
        const target = event.currentTarget
        const movieTmdbId = target.dataset.movieid;
        const currentPath = window.location.pathname;

        if (target.classList.contains('i-active')) {
          $.ajax({
            type: "POST",
            url: '/removeseen',
            data: { movieId: movieTmdbId, currentPath: currentPath }
          });
          target.dataset.originalTitle = "J'ai déjà vu ce film";
          target.classList.remove('i-active');
        } else {
          $.ajax({
            type: "POST",
            url: '/addseen',
            data: { movieId: movieTmdbId, currentPath: currentPath }
          });
          target.classList.add('i-active');
          target.dataset.originalTitle = "Retirer de Ma Vidéothèque";
        }
      });
    });
  }
}

export { updateSeen };
