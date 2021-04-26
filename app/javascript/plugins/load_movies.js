import { addToList, changeList } from "./update_list";
import axios from "axios";

const convertDate = (inputDate) => {
  const newDate = new Date(inputDate);
  let day = newDate.getDate();
  let month = newDate.getMonth()+1;

  if ((String(day)).length == 1) {
    day = '0' + day;
  }
  if ((String(month)).length == 1) {
    month = '0' + month;
  }

  return [day, month, newDate.getFullYear()].join('/');
}

const addMovieLinks = (movieId) => {
  const movie = document.getElementById(`movie-${movieId}`);
  const iconList = document.getElementById(`listDropdown-${movieId}`);

  movie.addEventListener('click', (event) => {
    const movieTmdbId = event.currentTarget.dataset.movieid;
    $.ajax({
      type: "POST",
      url: '/findorcreatejs',
      data: { movieId: movieTmdbId }
    });
  });

  if (iconList != null) {
    const listNames = document.querySelectorAll(`.dropdown-item-list-${movieId}`);
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

const displayUserLists = (userLists, movieId) => {
  let lists = ``;
  userLists.user_lists.forEach((list) => {
    lists += `<span class="dropdown-item link dropdown-item-list dropdown-item-list-${movieId}" data-list-id="${list.id}" data-movieid="${movieId}">
                ${list.name}
              </span>`;
  });
  return lists
}

const displayUsericonList = async (movie, signedIn) => {
  if (signedIn == "true") {
    const resultsItems = await watchlistItemRequest(movie.id);
    const resultsLists = await listsRequest();

    const lists = (resultsLists) => {
      if (resultsLists.user_lists) {
        return displayUserLists(resultsLists, movie.id);
      } else {
        return "";
      }
    }

    const listNameRequest = async (listId) => {
      const token = document.querySelector('[name=csrf-token]').content;
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
      const response = await axios.post('/listname', {listId: listId})
      return response.data;
    }

    if (resultsItems.watchlist_item != null) {
      const listName = await listNameRequest(resultsItems.watchlist_item.list_id);
      return `<i class="fas fa-plus icon-list dropdown-toggle i-active" id="listDropdown-${movie.id}" data-icon-movie-id="${movie.id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
              <div class="dropdown-menu dropdown-menu-list" aria-labelledby="listDropdown-${movie.id}">
                <div class="header-list">Actuelle : ${listName.list_name}</div>
                <hr class="dropdown-divider">
                <span class="header-list">Changer de liste :</span>
                ${lists(resultsLists)}
                <hr class="dropdown-divider">
                <span class="dropdown-item link dropdown-item-list" data-toggle="modal" data-target="#list">
                  Créer une nouvelle liste
                </span>
                <hr class="dropdown-divider">
                <a class="dropdown-item link dropdown-item-list" rel="nofollow" data-method="delete" href="/watchlist_items/${resultsItems.watchlist_item.id}?refresh=false">Retirer de la liste</a>
              </div>`;
    } else {
      return `<i class="fas fa-plus icon-list dropdown-toggle" data-movieid="${movie.id}" id="listDropdown-${movie.id}" data-icon-movie-id="${movie.id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
              <div class="dropdown-menu dropdown-menu-list" aria-labelledby="listDropdown-${movie.id}">
                <span class="header-list">Ajouter à une liste :</span>  
                ${lists(resultsLists)}
                <hr class="dropdown-divider">
                <span class="dropdown-item link dropdown-item-list" data-toggle="modal" data-target="#list">
                  Créer une nouvelle liste
                </span>
              </div>`;
    }
  } else {
    return "";
  }
}

const displayMovieCard = async (movie) => {
  const moviesContainer = document.getElementById('display-movies-container');
  const signedIn = moviesContainer.dataset.signedin;
  const iconList = await displayUsericonList(movie, signedIn);
  const movieCard  = `<div class="movie-card">
                        <div class="img-card-container movie-link" id="movie-${movie.id}" data-movieid="${movie.id}">
                          <img src="https://image.tmdb.org/t/p/w500${movie.poster_path}">
                        </div>
                        <div class="content-card-container">
                          <h6 class="movie-title">${movie.title}</h6>
                          <div class="d-flex">
                            <div class="movie-date">${convertDate(movie.release_date)}</div>
                            <div class="movie-user-actions">
                              <div class="dropdown dropup">
                                ${iconList}
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>`;
  moviesContainer.insertAdjacentHTML("beforeend", movieCard);
  addMovieLinks(movie.id);
}

const fetchingMovies = (pageNumber) => {
  if (document.getElementById('display-movies-container')) {
    const tmdbApiKey = document.getElementById('display-movies-container').dataset.tmdb;;
    const search = document.getElementById('display-movies-container').dataset.search;
    const url = `https://api.themoviedb.org/3/discover/movie?api_key=${tmdbApiKey}491f&language=fr&${search}&page=${pageNumber}`;

    fetch(url)
    .then(response => response.json())
    .then((data) => {
      data.results.forEach((movie) => {
        displayMovieCard(movie);
      });
    });
  }
}

const infiniteScroll = () => {
  if (document.getElementById('display-movies-container')) {
    let pageNumber = 3
    window.addEventListener('scroll', (event) => {
      if (Math.ceil($(window).scrollTop() + $(window).height()) >= $(document).height()) {
        fetchingMovies(pageNumber);
        pageNumber += 1
      }
    });
  }
}

export { infiniteScroll };
