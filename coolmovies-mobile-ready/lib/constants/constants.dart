const String fetchMoviesQuery = r"""
query AllMovies {
  allMovies {
    nodes {
      id
      imgUrl
      movieDirectorId
      userCreatorId
      title
      releaseDate
      nodeId
      userByUserCreatorId {
        id
        name
        nodeId
      }
    }
  }
}
""";

const String getCurrentUser = r"""
query {
  currentUser {
    id
    name
  }
}
""";