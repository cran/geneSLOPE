# auxiliary functions

#fast p-value computation for simple marginal linear model (lm) fit test
pValComp <- function(x, y, n, suma){
  a <- lm.fit(cbind(x,1), y)
  b <- sum(a$residuals^2)
  1 - pf((suma - b) / b * n, 1, n)
}


# Function to replace missing values with mean for that col
replace_na_with_mean <- function(x) {
  x_bar <- mean(x, na.rm = TRUE)
  x[is.na(x)] <- x_bar
  x
}

#estimate noise in linear model (lm)
estimate_noise <- function (X, y, intercept = TRUE) {
  n = nrow(X)
  if (intercept)
    X = cbind(rep(1, n), X)
  p = ncol(X)
  fit = lm.fit(X, y)
  sqrt(sum(fit$residuals^2)/(n - p))
}

#create clumping plot.data
create_clumping_plot_data <- function(x){
  plot.data <- NULL
  for(i in 1L:length(x$SNPclumps)){
    plot.data <- rbind(plot.data,
                       cbind(as.numeric(x$X_info[x$selectedSnpsNumbersScreening[x$SNPclumps[[i]]],1]),
                             as.numeric(x$X_info[x$selectedSnpsNumbersScreening[x$SNPclumps[[i]]],3]),
                             as.numeric(x$X_info[x$selectedSnpsNumbersScreening[x$SNPclumps[[i]]],4]),
                             i, -log(x$pVals[x$selectedSnpsNumbersScreening[x$SNPclumps[[i]]]])))
  }
  rownames(plot.data) <- NULL
  plot.data <- data.frame(plot.data)
  colnames(plot.data) <- c("chromosome", "snp", "bp", "clump", "val")
  plot.data <- cbind(plot.data,
                     representatives = unlist(x$SNPclumps) %in% unlist(x$SNPnumber))

  if(length(unique(plot.data$snp)) == 1 &
     length(unique(plot.data$chromosome)) == 1){ #we have one chromosome
    plot.data$snp <- plot.data$bp
  } else {
    chromosomes_limits <- aggregate(x$X_info[,3], list(x$X_info[,1]), max)
    chromosomes_limits$x <- c(0, head(cumsum(chromosomes_limits$x), -1))
    for(i in seq_along(sort(unique(plot.data$chromosome)))){
      chromosome_idx <- sort(unique(plot.data$chromosome))[i]
      plot.data$snp[plot.data$chromosome==chromosome_idx] <- chromosomes_limits$x[chromosome_idx] +
        plot.data$snp[plot.data$chromosome==chromosome_idx]
    }
  }

  plot.data$val[is.infinite(plot.data$val)] <- -log(2e-16) #R precision
  return(plot.data)
}

#create slopeResult plot.data
create_slope_plot_data <- function(x){
  plot.data <- NULL
  for(i in 1L:length(x$selectedClumps)){
    plot.data <- rbind(plot.data,
                       cbind(as.numeric(x$X_info[x$screenedSNPsNumbers[x$selectedClumps[[i]]],1]),
                             as.numeric(x$X_info[x$screenedSNPsNumbers[x$selectedClumps[[i]]],3]),
                             as.numeric(x$X_info[x$screenedSNPsNumbers[x$selectedClumps[[i]]],4]),
                             i, x$effects[i]^2/var(as.vector(x$y))))
  }
  rownames(plot.data) <- NULL
  plot.data <- data.frame(plot.data)
  colnames(plot.data) <- c("chromosome", "snp", "bp", "clump", "val")
  plot.data <- cbind(plot.data,
                     representatives = unlist(x$selectedClumps) %in% unlist(x$selectedSNPs))

  if(length(unique(plot.data$snp)) == 1 &
     length(unique(plot.data$chromosome)) == 1){ #we have one chromosome
    plot.data$snp <- plot.data$bp
  } else {
    chromosomes_limits <- aggregate(x$X_info[,3], list(x$X_info[,1]), max)
    chromosomes_limits$x <- c(0,head(cumsum(chromosomes_limits$x),-1))
    for(i in seq_along(unique(plot.data$chromosome))){
      chromosome_idx <- unique(plot.data$chromosome)[i]
      plot.data$snp[plot.data$chromosome==chromosome_idx] <- chromosomes_limits$x[i] +
        plot.data$snp[plot.data$chromosome==chromosome_idx]
    }
  }

  plot.data$val[plot.data$representatives] <- (x$effects^2/var(x$y))
  plot.data
}
