const addToList = (iconList, movieTmdbId, listId, currentPath) => {
  $.ajax({
    type: "POST",
    url: '/addtolist',
    data: { movieId: movieTmdbId, listId: listId, currentPath: currentPath }
  });
  iconList.classList.add('i-active');
}

const changeList = (movieTmdbId, listId, listItemId, currentPath) => {
  $.ajax({
    type: "PATCH",
    url: `/watchlist_items/${parseInt(listItemId, 10)}`,
    data: { movieId: movieTmdbId, listId: listId, currentPath: currentPath }
  });
}

const updateList = () => {
  if (document.querySelector('.icon-list')) {
    const listNames = document.querySelectorAll('.dropdown-item-list');
    const currentPath = window.location.pathname;

    listNames.forEach((list) => {
      list.addEventListener('click', (event) => {
        const target = event.currentTarget;
        const movieTmdbId = target.dataset.movieid;
        const listId = target.dataset.listId;
        const listItemId = target.dataset.listItemId;
        const iconList = document.querySelector(`[data-icon-movie-id='${movieTmdbId}']`);

        if (iconList.classList.contains('i-active')) {
          changeList(movieTmdbId, listId, listItemId, currentPath);
        } else {
          addToList(iconList, movieTmdbId, listId, currentPath);
        }
      });
    });
  }
}

export { updateList, addToList, changeList };