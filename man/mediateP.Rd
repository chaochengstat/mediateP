\name{mediate}
\alias{mediate}
%- R functions for calculating the point and interval estimates for the NIE, TE and MP, based on the product method.
\title{
Mediation analysis based on the product method
}
\description{
R function for calculating the point and interval estimates for the NIE, TE and MP, based on the product method.
}
\usage{
mediate(data, outcome, mediator, exposure, binary.outcome,
        binary.mediator, covariate.outcome, covariate.mediator,
        x0, x1, c.outcome, c.mediator, boot, R)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{(Required) The name of the dataset.}
  \item{outcome}{(Required) Name of the outcome variable, which should be either a continuous or binary datatype.}
  \item{mediator}{(Required) Name of the mediator variable, which should be either a continuous or binary datatype.}
  \item{exposure}{(Required) Name of the exposure variable, which should be either a continuous or binary datatype.}
  \item{binary.outcome}{(Required) If the outcome is binary, set to 1. If the outcome is continuous, set to 0.}
  \item{binary.mediator}{(Required) If the mediator is binary, set to 1. If the mediator is continuous, set to 0.}
  \item{covariate.outcome}{A vector of names showing the confounding variables used in the outcome model. The default value is NULL, which represents no confounding variables.  We only accepted continuous and binary confounding variables, if one confounding variable is categorical, please set it to a series of binary variables in advance.}
  \item{covariate.mediator}{A vector of names showing the confounding variables used in the mediator model. The default value is NULL, which represents no confounding variables. We only accepted continuous and binary confounding variables, if one confounding variable is categorical, please set it to a series of binary variables in advance.}
  \item{x0}{The baseline exposure level (i.e., $x^*$). The default value is 0.}
  \item{x1}{The new exposure level (i.e., $x$). The default value is 1.}
  \item{c.outcome}{A vector of numbers representing the conditional level of the confounding variables in the outcome model. The default value is a vector of 0.}
  \item{c.mediator}{A vector of numbers representing the conditional level of the confounding variables in the mediator model. The default value is a vector of 0.}
  \item{boot}{If a percentile bootstrap confidence interval needed to be added, set to 1. Otherwise, set to 0. The default value is 0.}
  \item{R}{(Required if using bootstrap approach) The number of replications when apply the percentile bootstrap method to calculate the confidence interval. The default value is 2,000.}
}

\author{
Chao Cheng (c.cheng@yale.edu)
}

\references{Chao Cheng, Donna Spiegelman, and Fan Li. (2020+) An empirical evaluation of the product method for estimation and inference in mediation analysis.}

\examples{
## Generate a data set including two confounders (C1 and C2), one binary
## mediator (M), one binary exposure (X), and one binary outcome (Y)
C1=rnorm(2000)>0
C2=rnorm(2000)
X = rnorm(2000)
M= as.numeric(runif(2000)< 1/(1+exp(0-0.9*X+0.1*C1)))
Y= as.numeric(runif(2000)< 1/(1+exp(-(-2+0.5*X+0.5*M+0.2*C1+0.2*C2))))
mydata=as.data.frame(cbind(Y,M,X,C1,C2))

## mediation analysis for X in change from 0 to 1. In the outcome model, we
## adjusted for C1 and C2. In the mediator model, we only adjusted for C1. We
## calculated the NIE, TE and MP for exposure in change from 0 to 1,
## conditional on C1=0 and C2=1.
result=mediate(data=mydata, outcome="Y", mediator="M", exposure="X",
                 binary.outcome=1, binary.mediator=1,
                 covariate.outcome=c("C1","C2"),
                 covariate.mediator=c("C1"),
                 x0=0, x1=1, c.outcome=c(0,1), c.mediator=c(0),
                 boot=0, R=2000)

print(result)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
