import { buildMovieDropdown, addDropdownLinks } from "./update_dropdown";

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

  if (iconList != null) addDropdownLinks(movieId);
}

const displayMovieCard = async (movie) => {
  const moviesContainer = document.getElementById('display-movies-container');
  const signedIn = moviesContainer.dataset.signedin;
  const movieDropdown = await buildMovieDropdown(movie.id, signedIn);
  const movieCard  = `<div class="movie-card">
                        <div class="img-card-container movie-link" id="movie-${movie.id}" data-movieid="${movie.id}">
                          <img src="https://image.tmdb.org/t/p/w500${movie.poster_path}">
                        </div>
                        <div class="content-card-container">
                          <h6 class="movie-title">${movie.title}</h6>
                          <div class="d-flex">
                            <div class="movie-date">${convertDate(movie.release_date)}</div>
                            <div class="movie-user-actions">
                              <div class="dropdown" id="movie-dropdown-${movie.id}">
                                ${movieDropdown}
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
