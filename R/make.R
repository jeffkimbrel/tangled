#' Make all possible kmers of length n
#'
#' @param n Length of kmers (3-6)
#'
#' @returns A character vector of all possible kmers of length n
#' @export

make_kmers <- function(n) {
  # n must be between 3 and 6
  if (n < 3 | n > 6) {
    stop("n must be between 3 and 6")
  }

  bases <- c("A", "C", "G", "T")

  kmers <- bases

  for (i in 2:n) {
    kmers <- as.vector(outer(kmers, bases, paste0))
  }

  return(kmers)
}




#' Create the tangledDB database
#'
#' This function does not take any inputs. It creates the tangledDB database
#' that is also included as a dataset in the package.
#'
#' @returns
#' @export

make_tangledDB = function() {
  make_kmers(6) |>
    tibble::enframe(name = NULL, value = "hexamer") |>
    dplyr::rowwise() |>
    dplyr::mutate(AA = bioseq::seq_translate(bioseq::as_dna(hexamer),
                                             codon_frame = 1),
                  tetramer = substr(hexamer,1,4),
                  pentamer = substr(hexamer,1,5),
                  AA1 = substr(AA,1,1),
                  AA2 = substr(AA,2,2),
                  TuN = bioseq::seq_translate(bioseq::as_dna(hexamer),
                                              codon_frame = 2),
                  PuN = bioseq::seq_translate(bioseq::as_dna(hexamer),
                                              codon_frame = 3)) |>
    dplyr::ungroup()
}

