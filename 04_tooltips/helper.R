## Some helper functions to simplify our app


#' Return the numeric categorical variables 
#'
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
get_numeric_variables <- function(df){
  varClass <- sapply(df, class)
  
  numericVars <- names(varClass[varClass %in% c("numeric", "integer")])
  return(numericVars)
}


#' Return a list of categories given a data.frame
#'
#' @param df 
#'
#' @return named list with each entry listing all categories within a variable in the df
#' @export
#'
#' @examples
get_category_variables <- function(df) {
  
  ## get variable classes
  varClass <- sapply(df, class)
  
  ## grab characters - they may be categorical, or unique ids
  characterVars <- names(varClass[varClass %in% c("character", "factor")])
  
  #remove those character variables that aren't 
  char_list <- sapply(characterVars, function(x){
    size_vec <- length(df[[x]])
    cate_vec <- length(unique(df[[x]]))
    ##This is a bit o a kludge - don't want to return categories which 
    ##have levels bigger than nrow(df)/2
    if(cate_vec > (size_vec/2)){
      out <- NULL
    } else{
      out <- as.character(unique(df[[x]]))
    }
    return(out)
  })
  
  ##remove null values from list
  char_list <- char_list[lapply(char_list,length)!=0]

  return(char_list)
  
}


#' Title
#'
#' @param hover 
#' @param point 
#'
#' @return
#' @export
#'
#' @examples
return_well_panel <- function(hover, point){
  left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
  top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
  
  # calculate distance from left and bottom side of the picture in pixels
  left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
  top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
  
  style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                  "left:", left_px + 2, "px; top:", top_px + 2, "px;")
  
  output_string <- ''
  
  point2 <- as.list(point)
  
  for(i in 1:length(point2)){
    output_string <- paste0(output_string, "<b>", names(point2[i]), "</b>: ", as.character(point2[i]), "<br>")
  }
  
  # actual tooltip created as wellPanel
  return(list(output_string=output_string, style=style))
  
}