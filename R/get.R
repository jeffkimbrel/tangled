#' Title
#'
#' @param diAA di-amino acid to search for in tangledDB
#' @param type type of return value, either "df" for a data frame or "vec" for a vector of unique TuNs
#'
#' @export

get_TuNs <- function(diAA, type = "df") {
  if (!diAA %in% tangled::tangledDB$diAA) {
    stop(paste0("diAA '", diAA, "' not found in tangledDB"), call. = FALSE)
  }

  # stop if type isn't "df" or "vec"
  if (!type %in% c("df", "vec")) {
    stop("type must be either 'df' or 'vec'", call. = FALSE)
  }

  df <- tangled::tangledDB |>
    dplyr::filter(diAA == bioseq::aa(!!diAA)) |>
    dplyr::mutate(tetramer = substr(hexamer, 2, 5)) |>
    dplyr::select(hexamer, diAA, AA0, AA3, tetramer, TOL) |>
    tidyr::nest(hexamers = c(hexamer, tetramer)) |>
    dplyr::arrange(TOL)

  vec <- df |>
    dplyr::select(TOL) |>
    dplyr::distinct() |>
    dplyr::pull(TOL) |>
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

get_PuNs <- function(diAA, type = "df") {
  if (!diAA %in% tangled::tangledDB$diAA) {
    stop(paste0("diAA '", diAA, "' not found in tangledDB"), call. = FALSE)
  }

  # stop if type isn't "df" or "vec"
  if (!type %in% c("df", "vec")) {
    stop("type must be either 'df' or 'vec'", call. = FALSE)
  }

  df <- tangled::tangledDB |>
    dplyr::filter(diAA == bioseq::aa(!!diAA)) |>
    dplyr::mutate(pentamer = substr(hexamer, 1, 5)) |>
    dplyr::select(hexamer, diAA, AA0, AA3, pentamer, POL) |>
    tidyr::nest(hexamers = c(hexamer, pentamer)) |>
    dplyr::arrange(POL)


  vec <- df |>
    dplyr::select(POL) |>
    dplyr::distinct() |>
    dplyr::pull(POL) |>
    as.vector() |>
    sort()

  if (type == "df") {
    return(df)
  } else if (type == "vec") {
    return(vec)
  }
}

get_TOLs <- function(A, type = "df") {
  check_AA(A)

  if (!type %in% c("df", "vec")) {
    stop("type must be either 'df' or 'vec'", call. = FALSE)
  }

  df <- tangled::tangledDB |>
    dplyr::filter(AA0 == bioseq::aa(A)) |>
    dplyr::mutate(tetramer = substr(hexamer, 1, 4)) |>
    dplyr::select(A = AA0, TOL, tetramer) |>
    dplyr::distinct() |>
    tidyr::nest(tetramers = tetramer) |>
    dplyr::arrange(TOL)

  vec <- df |>
    dplyr::distinct(TOL) |>
    dplyr::mutate(TOL = as.character(TOL)) |>
    dplyr::pull(TOL) |>
    sort()

  if (type == "df") {
    return(df)
  } else if (type == "vec") {
    return(vec)
  }
}


get_POLs <- function(A, type = "df") {
  check_AA(A)

  if (!type %in% c("df", "vec")) {
    stop("type must be either 'df' or 'vec'", call. = FALSE)
  }

  df <- tangled::tangledDB |>
    dplyr::filter(AA0 == bioseq::aa(A)) |>
    dplyr::mutate(pentamer = substr(hexamer, 1, 5)) |>
    dplyr::select(A = AA0, POL, pentamer) |>
    dplyr::distinct() |>
    tidyr::nest(pentamers = pentamer) |>
    dplyr::arrange(POL)

  vec <- df |>
    dplyr::distinct(POL) |>
    dplyr::mutate(POL = as.character(POL)) |>
    dplyr::pull(POL) |>
    sort()

  if (type == "df") {
    return(df)
  } else if (type == "vec") {
    return(vec)
  }
}

#' Get Subsequence
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

  subseq <- subseq_list |>
    unlist() |>
    tibble::enframe(name = "POS", value = "diAA")

  if (ends) {
    left <- paste0("X", substr(seq, 1, 1))
    right <- paste0(substr(seq, nchar(seq), nchar(seq)), "X")

    e <- tibble::tibble(POS = c(0, n), diAA = c(left, right))

    subseq <- rbind(subseq, e) |>
      dplyr::arrange(POS)
  }

  return(subseq)
}
