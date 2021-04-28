import { changeList, addToList, removeFromList } from "./update_list";
import axios from "axios";

const addDropdownLinks = (movieId) => {
  const listNames = document.querySelectorAll(`.dropdown-item-list-${movieId}`);
  const removeLink = document.getElementById(`remove-link-${movieId}`);
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

  if (removeLink != null) {
    removeLink.addEventListener('click', (event) => {
      const target = event.currentTarget;
      const watchlistItemId = target.dataset.watchlistItemId;
      const movieTmdbId = target.dataset.movieid;
      removeFromList(movieTmdbId, watchlistItemId, currentPath);
    });
  }
}

const watchlistItemRequest = async (movieId) => {
  const token = document.querySelector('[name=csrf-token]').content;
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
  const response = await axios.post('/watchlistitem', {movieId: movieId})
  return response.data;
}

const listsRequest = async () => {
  const token = document.querySelector('[name=csrf-token]').content;
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
  const response = await axios.post('/userlists')
  return response.data;
}

const buildUserLists = async (userLists, movieId) => {
  const resultsItems = await watchlistItemRequest(movieId);
  let watchlistItemId = "";
  if (resultsItems.watchlist_item != null) watchlistItemId = `data-list-item-id="${resultsItems.watchlist_item.id}"`;
  
  let listMenu = ``;
  if (userLists.user_lists.length > 0 && resultsItems.watchlist_item == null) listMenu += `<span class="header-list">Ajouter à une liste :</span>`;
  if (userLists.user_lists.length > 1 && resultsItems.watchlist_item != null) listMenu += `<hr class="dropdown-divider">
                                                     <span class="header-list">Changer de liste :</span>`;

  userLists.user_lists.forEach((list) => {
    if (resultsItems.watchlist_item != null) {
      if (list.id != resultsItems.watchlist_item.list_id) {
        listMenu += `<span class="dropdown-item link dropdown-item-list dropdown-item-list-${movieId}" data-list-id="${list.id}" data-movieid="${movieId}" ${watchlistItemId}>
                    ${list.name}
                  </span>`;
      }
    } else {
      listMenu += `<span class="dropdown-item link dropdown-item-list dropdown-item-list-${movieId}" data-list-id="${list.id}" data-movieid="${movieId}" ${watchlistItemId}>
                  ${list.name}
                  </span>`;
    }
  });
  if (userLists.user_lists.length > 0 && resultsItems.watchlist_item == null) listMenu += `<hr class="dropdown-divider">`;
  return listMenu
}

const buildMovieDropdown = async (movieId, signedIn) => {

  if (signedIn == "true") {
    const resultsItems = await watchlistItemRequest(movieId);
    const resultsLists = await listsRequest();
    
    const userlists = async (resultsLists) => {
      if (resultsLists.user_lists) {
        return await buildUserLists(resultsLists, movieId);
      } else {
        return "";
      }
    }

    const lists = await userlists(resultsLists);

    const listNameRequest = async (listId) => {
      const token = document.querySelector('[name=csrf-token]').content;
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
      const response = await axios.post('/listname', {listId: listId})
      return response.data;
    }

    if (resultsItems.watchlist_item != null) {
      const listName = await listNameRequest(resultsItems.watchlist_item.list_id);
      return `<i class="fas fa-plus icon-list dropdown-toggle i-active" id="listDropdown-${movieId}" data-icon-movie-id="${movieId}" data-toggle="dropdown" data-hover="tooltip" title="Gérer mes listes" aria-haspopup="true" aria-expanded="false"></i>
              <div class="dropdown-menu dropdown-menu-list" aria-labelledby="listDropdown-${movieId}">
                <div class="header-list">Actuelle : ${listName.list_name}</div>
                ${lists}
                <hr class="dropdown-divider">
                <span class="dropdown-item link create-list-link" data-toggle="modal" data-target="#list">
                  Créer une nouvelle liste
                </span>
                <hr class="dropdown-divider">
                <span class="dropdown-item link remove-list-link" data-watchlist-item-id="${resultsItems.watchlist_item.id}" id="remove-link-${movieId}" data-movieid="${movieId}">
                  Retirer de la liste
                </span>
              </div>`;
    } else {
      return `<i class="fas fa-plus icon-list dropdown-toggle" data-movieid="${movieId}" id="listDropdown-${movieId}" data-icon-movie-id="${movieId}" data-toggle="dropdown" data-hover="tooltip" title="Gérer mes listes" aria-haspopup="true" aria-expanded="false"></i>
              <div class="dropdown-menu dropdown-menu-list" aria-labelledby="listDropdown-${movieId}">
                ${lists}
                <span class="dropdown-item link create-list-link" data-toggle="modal" data-target="#list">
                  Créer une nouvelle liste
                </span>
              </div>`;
    }
  } else {
    return "";
  }
}

const updateDropdown = async (movieId, signedIn, currentPath) => {
  const movieDropdown = await buildMovieDropdown(movieId, signedIn);
  const iconList = document.getElementById(`movie-dropdown-${movieId}`);

  if (iconList != null) {
    iconList.innerHTML = "";
    iconList.insertAdjacentHTML("afterbegin", movieDropdown);
  }

  if (currentPath.startsWith('/movies/')) iconList.classList.add('icon-list-show');
  addDropdownLinks(movieId);
}

export { updateDropdown, buildMovieDropdown, addDropdownLinks };