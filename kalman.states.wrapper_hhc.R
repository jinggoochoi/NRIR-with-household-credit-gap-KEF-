##------------------------------------------------------------------------------##
## File:        kalman.states.wrapper.R
##
## Description: This is a wrapper function for kalman.states.R that specifies
##              inputs based on the estimation stage.
##------------------------------------------------------------------------------##
kalman.states.wrapper_hhc <- function(parameters, y.data, x.data, stage = NA,
                                  lambda.g=NA, lambda.z=NA, xi.00=NA, P.00=NA){

    if (stage == 1) {
        out <- unpack.parameters.stage1_modified_hhc(parameters, y.data, x.data,
                                        xi.00, P.00)
    } else if (stage == 2) {
        out <- unpack.parameters.stage2_modified_hhc(parameters, y.data, x.data,
                                        lambda.g, xi.00, P.00)
    } else if (stage == 3) {
        out <- unpack.parameters.stage3_modified_hhc(parameters, y.data, x.data,
                                        lambda.g, lambda.z, xi.00, P.00)
    } else {
        stop('You need to enter a stage number in kalman.states.wrapper.')
    }

  for (n in names(out)) {
      eval(parse(text=paste0(n, "<-out$", n)))
  }
  T <- dim(y.data)[1]
  states <- kalman.states(xi.00, P.00, F, Q, A, H, R, cons, y.data, x.data)
  return(states)
}
