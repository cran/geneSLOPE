#' identify_clump
#'
#' Enable interactive selection of snps in plot.
#' Return clump number.
#'
#' @title identify_clump
#' @param x appropiate class object
#' @param ... other arguments
#'
#' @rdname identify_clump
#' @export identify_clump
identify_clump <- function(x, ...){
  UseMethod("identify_clump")
}


#' Identify clump number in clumpingResult class plot
#'
#' @param x clumpingResult class object
#' @param ... Further arguments to be passed to or from other methods. They are ignored in this function.
#'
#' @export
#'
identify_clump.clumpingResult <- function(x, ...) {
  plot.data <- create_clumping_plot_data(x)

  granice <- aggregate(x$X_info[,3], list(x$X_info[,1]), max)
  granice_max <- cumsum(granice$x)
  granice$x <- c(0,head(cumsum(granice$x),-1))

  a <- plot.data$snp
  b <- plot.data$val

  downViewport("panel.4-4-4-4")
  tmp = as.numeric(grid.locator(unit = "npc"))
  tmp.n <- as.numeric(tmp)*c(max(granice_max)+1, 1.1*max(plot.data$val))
  diff.a <- (a-tmp.n[1])^2
  diff.b <- (b-tmp.n[2])^2
  upViewport(n = 0)
  paste("Selected SNP is in clump",
        plot.data$clump[which.min(diff.a/max(diff.a) + diff.b/max(diff.b))])
}

#' Identify clump number in selectionResult class plot
#'
#' @param x selectionResult class object
#' @param ... Further arguments to be passed to or from other methods. They are ignored in this function.
#'
#' @export
identify_clump.selectionResult <- function(x, ...) {
  plot.data <- create_slope_plot_data(x)

  granice <- aggregate(x$X_info[,3], list(x$X_info[,1]), max)
  granice_max <- cumsum(granice$x)
  granice$x <- c(0,head(cumsum(granice$x),-1))

  a <- plot.data$snp
  b <- plot.data$val

  downViewport("panel.3-4-3-4")
  tmp = as.numeric(grid.locator(unit = "npc"))
  tmp.n <- as.numeric(tmp)*c(max(granice_max)+1, 1.1*max(plot.data$val))
  diff.a <- (a-tmp.n[1])^2
  diff.b <- (b-tmp.n[2])^2
  upViewport(n = 0)
  paste("Selected SNP is in clump",
        plot.data$clump[which.min((a-tmp.n[1])^2 + (b-tmp.n[2])^2)])
}
