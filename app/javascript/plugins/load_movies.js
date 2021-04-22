import { toggleSeen } from "./update_seen";
import { toggleWatchList } from "./update_watch_list";
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
  const listIcon = document.getElementById(`list-${movieId}`);
  const libraryIcon = document.getElementById(`library-${movieId}`);

  movie.addEventListener('click', (event) => {
    const movieTmdbId = event.currentTarget.dataset.movieid;
    $.ajax({
      type: "POST",
      url: '/findorcreatejs',
      data: { movieId: movieTmdbId }
    });
  });

  if (listIcon != null) {
    listIcon.addEventListener('click', (event) => {
      const movieTmdbId = event.currentTarget.dataset.movieid;
      const currentPath = window.location.pathname;
      toggleWatchList(event.currentTarget, movieTmdbId, currentPath);
    });
  }

  if (libraryIcon != null) {
    libraryIcon.addEventListener('click', (event) => {
      const movieTmdbId = event.currentTarget.dataset.movieid;
      const currentPath = window.location.pathname;
      toggleSeen(event.currentTarget, movieTmdbId, currentPath);
    });
  }
}

const movieStatusRequest = async (movieId) => {
  const token = document.querySelector('[name=csrf-token]').content;
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
  const response = await axios.post('/usermoviesstatus', {movieId: movieId})
  return response.data;
}

const displayUserListIcon = async (movie, signedIn) => {
  if (signedIn == "true") {
    const results = await movieStatusRequest(movie.id);
    if (results.user_watchlist) {
      return `<i class="fas fa-plus icon-list i-active" id="list-${movie.id}" title="Retirer de Ma Liste" data-toggle="tooltip" data-movieid="${movie.id}"></i>`;
    } else {
      return `<i class="fas fa-plus icon-list" id="list-${movie.id}" title="Ajouter à Ma Liste" data-toggle="tooltip" data-movieid="${movie.id}"></i>`;
    }
  } else {
    return "";
  }
}

const displayUserLibraryIcon = async (movie, signedIn) => {
  if (signedIn == "true") {
    const results = await movieStatusRequest(movie.id);
    if (results.user_seen) {
      return `<i class="fas fa-video icon-library i-active" id="library-${movie.id}" title="Retirer de Ma Vidéothèque" data-toggle="tooltip" data-movieid="${movie.id}"></i>`;
    } else {
      return `<i class="fas fa-video icon-library" id="library-${movie.id}" title="J'ai déjà vu ce film" data-toggle="tooltip" data-movieid="${movie.id}"></i>`;
    }
  } else {
    return "";
  }
}

const displayMovieCard = async (movie) => {
  const moviesContainer = document.getElementById('display-movies-container');
  const signedIn = moviesContainer.dataset.signedin;
  const listIcon = await displayUserListIcon(movie, signedIn);
  const libraryIcon = await displayUserLibraryIcon(movie, signedIn);
  const movieCard  = `<div class="movie-card">
                        <div class="img-card-container movie-link" id="movie-${movie.id}" data-movieid="${movie.id}">
                          <img src="https://image.tmdb.org/t/p/w500${movie.poster_path}">
                        </div>
                        <div class="content-card-container">
                          <h6 class="movie-title">${movie.title}</h6>
                          <div class="d-flex">
                            <div class="movie-date">${convertDate(movie.release_date)}</div>
                            <div class="movie-user-actions">
                              ${listIcon}
                              ${libraryIcon}
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
