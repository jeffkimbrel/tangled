#' Title
#'
#' @param AA di-amino acid to search for in tangledDB
#' @param type type of return value, either "df" for a data frame or "vec" for a vector of unique TuNs
#'
#' @export

get_TuNs = function(AA, type = "df") {

  # stop if AA not found in tangledDB$AA
  if (!AA %in% tangled::tangledDB$AA) {
    stop(paste0("AA '", AA, "' not found in tangledDB"), call. = FALSE)
  }

  # stop if type isn't "df" or "vec"
  if (!type %in% c("df", "vec")) {
    stop("type must be either 'df' or 'vec'", call. = FALSE)
  }

  df = tangled::tangledDB |>
    dplyr::filter(AA == !!AA) |>
    dplyr::select(hexamer, AA, AA1, AA2, tetramer, TuN)

  vec = df |>
    dplyr::select(TuN) |>
    dplyr::distinct() |>
    dplyr::pull(TuN) |>
    as.vector() |>
    sort()

  if (type == "df") {
    return(df)
  } else if (type == "vec") {
    return(vec)
  }
}



#' Title
#'
#' @param AA di-amino acid to search for in tangledDB
#' @param type type of return value, either "df" for a data frame or "vec" for a vector of unique PuNs
#'
#' @export

get_PuNs = function(AA, type = "df") {

  # stop if AA not found in tangledDB$AA
  if (!AA %in% tangled::tangledDB$AA) {
    stop(paste0("AA '", AA, "' not found in tangledDB"), call. = FALSE)
  }

  # stop if type isn't "df" or "vec"
  if (!type %in% c("df", "vec")) {
    stop("type must be either 'df' or 'vec'", call. = FALSE)
  }

  df = tangled::tangledDB |>
    dplyr::filter(AA == !!AA) |>
    dplyr::select(hexamer, AA, AA1, AA2, pentamer, PuN)

  vec = df |>
    dplyr::select(PuN) |>
    dplyr::distinct() |>
    dplyr::pull(PuN) |>
    as.vector() |>
    sort()

  if (type == "df") {
    return(df)
  } else if (type == "vec") {
    return(vec)
  }
}






#' Title
#'
#' @param seq amino acid sequence to get subsequences from
#' @param ends logical, if TRUE, adds the first and last amino acid with a "X" to the subsequences
#'
#' @export

get_subsequences <- function(seq, ends = TRUE) {
  n <- nchar(seq)
  subseq_list <- list()

  for (i in 1:(n - 2 + 1)) {
    subseq_list[[i]] <- substr(seq, i, i + 2 - 1)
  }

  subseq = subseq_list |>
    unlist() |>
    tibble::enframe(name = "POS", value = "AA")

  if (ends) {
    left = paste0("X", substr(seq, 1, 1))
    right = paste0(substr(seq, nchar(seq), nchar(seq)), "X")

    e = tibble::tibble(POS = c(0, n), AA = c(left, right))

    subseq = rbind(subseq, e) |>
      dplyr::arrange(POS)

  }

  return(subseq)

}
