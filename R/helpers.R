#' Substitution Matrix
#'
#' @param matrix A character string specifying the substitution matrix to use.
#'
#' @returns A tibble with the substitution matrix.
#' @export

substitution_matrix <- function(matrix = "BLOSUM62") {
  matrix <- toupper(matrix)

  matrix_choices <- c("BLOSUM62", "BLOSUM80", "BLOSUM45", "BLOSUM45", "PAM30", "PAM70", "PAM250")

  if (!matrix %in% matrix_choices) {
    stop(glue::glue("Please choose one of the following matrices: {paste(matrix_choices, collapse = ', ')}"), .call = FALSE)
  }

  data(list = matrix, package = "pwalign")
  m <- base::get(matrix)

  tibble::tibble(
    AA1 = colnames(m)[col(m)],
    AA2 = rownames(m)[row(m)],
    matrix = c(m)
  ) |>
    dplyr::filter(AA1 %in% canonical_AAs & AA2 %in% canonical_AAs) |>
    dplyr::rename(!!matrix := matrix)
}


check_AA <- function(AA) {
  if (!AA %in% tangled::canonical_AAs) {
    stop(glue::glue("Amino acid '{AA}' not found in canonical_AAs"), call. = FALSE)
  }

  return(TRUE)
}
