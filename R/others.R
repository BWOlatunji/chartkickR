
# load the jsonlite package
library(jsonlite)

# define the JSON data as a string
json_data <- "[[174.0, 80.0, 1], [176.5, 82.3, 2], [180.3, 73.6, 3], [167.6, 74.1, 6], [188.0, 85.9, 2]]"

# convert the JSON data to a data frame
df <- fromJSON(json_data)

# print the data frame
df


df_list <- list(data = apply(df, 1, list) |> lapply(unname))
df_list$data[[1]]

df_penguins <- palmerpenguins::penguins

df_p_list <- list(data = apply(df_penguins, 1, list) |> lapply(unname))
df_p_list$data[[1]]


# Install and load the jsonlite and tibble packages if not already installed
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite")
}

if (!requireNamespace("tibble", quietly = TRUE)) {
  install.packages("tibble")
}

# Load the required packages
library(jsonlite)
library(tibble)

# Your array of arrays in JavaScript
js_array <- '[[174.0, 80.0, 1], [176.5, 82.3, 2], [180.3, 73.6, 3], [167.6, 74.1, 6], [188.0, 85.9, 2]]'

# Convert the JavaScript array to a list of lists in R
list_of_lists <- fromJSON(js_array)

# Convert the list of lists to a tibble
my_tibble <- as_tibble(list_of_lists)

# Print the resulting tibble
print(my_tibble)

# Convert the tibble back to a data frame
my_data_frame <- as.data.frame(my_tibble)

# Remove column names
colnames(my_data_frame) <- NULL

# Convert the data frame to a JSON-like array
json_array <- toJSON(my_data_frame, array = TRUE)

# Print the resulting JSON-like array
cat(json_array)


penguins_count <- palmerpenguins::penguins |> count(species,island)
# Remove column names
colnames(penguins_count) <- NULL

# Convert the data frame to a JSON-like array
p_json_array <- toJSON(penguins_count, array = TRUE)

# Print the resulting JSON-like array
cat(p_json_array)


my_process_data <- function(df, x, y, group_by, size) {
  # & !is.null(x_col) & !is.null(y_col)
  if(!is.null(group_by)){
    df <- dplyr::select(df,
                        x = {{ x }} ,
                        y = {{ y }},
                        group = {{ group_by }})

    data_items <- lapply(split(df, df$group), function(sub_df) {
      name <- unique(sub_df$group)
      data <- setNames(as.list(sub_df$y), sub_df$x)
      list(name = name, data = data)
    }) |> unname()

  }

  return(data_items)
}
pr_data <- my_process_data(penguins, x = bill_length_mm,
                           y = bill_depth_mm,
                           group_by = species,
                           size=NULL)


# if(!is.null(size=size)){
#   group <- NULL
#   df <- dplyr::select(df,
#                       x = {{ x_col }} ,
#                       y = {{ y_col }},
#                       {{ size }})
#   # Remove column names
#   colnames(df) <- NULL
#
#   # Convert the data frame to a JSON-like array
#   p_json_array <- toJSON(penguins_count, array = TRUE)
# }
#
# if(group <- NULL){
#   # x     <- NULL
#   # y     <- NULL
#
#   data_items <- apply(df, 1, as.list)  |>  lapply(unname)
#
# }

