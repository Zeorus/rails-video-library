import { updateDropdown } from "./update_dropdown";
import axios from "axios";
import swal from 'sweetalert';

const addToList = async (movieTmdbId, listId, currentPath) => {
  const signedIn = "true";
  const token = document.querySelector('[name=csrf-token]').content;
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
  await axios.post('/addtolist', {movieId: movieTmdbId, listId: listId, currentPath: currentPath})
  updateDropdown(movieTmdbId, signedIn, currentPath);
  swal({text: "Le film a été ajouté à la liste", icon: "success"});
}

const changeList = async (movieTmdbId, listId, listItemId, currentPath) => {
  const signedIn = "true";
  const token = document.querySelector('[name=csrf-token]').content;
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
  await axios.patch(`/watchlist_items/${parseInt(listItemId, 10)}`, {movieId: movieTmdbId, listId: listId, currentPath: currentPath})
  updateDropdown(movieTmdbId, signedIn, currentPath);
  swal({text: "Le film a été changé de liste", icon: "success"}).then(() => {
    if (currentPath == '/lists') document.location.reload();
  });
}

const removeFromList = async (movieTmdbId, watchlistItemId, currentPath) => {
  const signedIn = "true";
  const token = document.querySelector('[name=csrf-token]').content;
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
  await axios.delete(`/watchlist_items/${parseInt(watchlistItemId, 10)}`, {currentPath: currentPath})
  updateDropdown(movieTmdbId, signedIn, currentPath);
  swal({text: "Le film a été retiré de la liste", icon: "success"}).then(() => {
    if (currentPath == '/lists') document.location.reload();
  });
}

const updateList = () => {
  if (document.querySelector('.icon-list')) {
    const listNames = document.querySelectorAll('.dropdown-item-list');
    const removeLinks = document.querySelectorAll('.remove-list-link');
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
          addToList(movieTmdbId, listId, currentPath);
        }
      });
    });

    removeLinks.forEach((link) => {
      link.addEventListener('click', (event) => {
        const target = event.currentTarget;
        const watchlistItemId = target.dataset.watchlistItemId;
        const movieTmdbId = target.dataset.movieid;
        removeFromList(movieTmdbId, watchlistItemId, currentPath);
      });
    });
  }
}

export { updateList, addToList, changeList, removeFromList };
