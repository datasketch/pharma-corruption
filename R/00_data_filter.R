#' @export
data_filter <- function(data, dic, var_inputs) {
  if (is.null(data)) return()
  if (is.null(dic)) return()
  df <- data
  if (is.null(var_inputs)) return()
  if (!is.list(var_inputs)) return()
  tem_ls <-
    seq_along(var_inputs) |>
    purrr::map(function(.x) {
      if (!is.null(var_inputs[[.x]])) {
        name_var <- names(var_inputs)[.x]
        info_var <- dic |>
          dplyr::filter(id %in% name_var)
        filter_var <- var_inputs[[.x]]
        if (info_var$ftype == "Date") {
          df <<- filter_dates(df, range_date = filter_var, by = info_var$label)
        } else {
          df <<- df |>
            dplyr::filter(!!dplyr::sym(info_var$label) %in% filter_var)
        }
      }
    })
  rm(tem_ls)
  df
}
