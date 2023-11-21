#' Individual R6 Class
#' @importFrom uuid UUIDgenerate
#' @importFrom R6 R6Class
#' @export
## Define the Individual class
Individual <- R6::R6Class("Individual", #nolint
                          private = list(
                            ..unique_id = NA,
                            ..sex = NA,
                            ..age = NA,
                            ..height = NA,
                            ..weight = NA,
                            ..bmi = NA

                          ),
                          active = list(
                            # Binding to update indivual attributes
                            age = function(value) {
                              if(missing(value)) stop('Age field can not be empty')
                              if(!is.numeric(value)) stop('Age field should be in numeric format')
                              if(!(value < 110 && value > 0)) stop('Age should fall within a practical range')
                              private$..age <- value
                            },
                            sex = function(value) {
                              if(missing(value)) stop('Sex field can not be empty')
                              if(!is.character(value)) stop('Sex field should be in character format')
                              if(!(tolower(value) %in% c('male', 'female'))) stop("Unknown value. Allowed options: Male, Female. Note: case doesn't matter.")
                              private$..sex <- tolower(value)
                            },
                            height = function(value) {
                              if(missing(value)) stop('Height field can not be empty')
                              if(!is.numeric(value)) stop('Height field should be in numeric format')
                              if(!(value < 2.2 && value > 0.4)) stop('Height should fall within a practical range, measured in meters')
                              private$..height <- value
                            },
                            weight = function(value) {
                              if(missing(value)) stop('Weight field can not be empty')
                              if(!is.numeric(value)) stop('Weight field should be in numeric format')
                              if(!(value < 250 && value > 1)) stop('Weight should fall within a practical range, measured in kilograms')
                              private$..weight <- value
                            },
                            bmi = function(value) {
                              if(missing(value)) stop('BMI field can not be empty')
                              if(!is.numeric(value)) stop('BMI field should be in numeric format')
                              private$..bmi <- value
                            }
                          ),
                          public = list(
                            #' @description
                            #' Initialize the individual's registry
                            #' @param sex character value has two options: Male, Female (Case doesn't matter)
                            #' @param age numeric value. (range: [1 - 110])
                            #' @param height numeric value. (range: [0.4 - 2.2]) (meters)
                            #' @param weight numeric value. (range: [1 - 250]) (kg)
                            initialize = function(sex, age, height, weight) {
                              private$..unique_id = uuid::UUIDgenerate()
                              private$..sex = self$validate_sex(sex)
                              private$..age = self$validate_age_value(age)
                              private$..height = self$validate_height_value(height)
                              private$..weight = self$validate_weight_value(weight)
                              private$..bmi = self$calculate_bmi(weight, height)
                            },
                            print = function(...) {
                              cat("Individual: \n")
                              cat("  ID: ", private$..unique_id, "\n", sep = "")
                              cat("  Sex:  ", private$..sex, "\n", sep = "")
                              cat("  Age:  ", private$..age, "\n", sep = "")
                              cat("  Height:  ", private$..height, "\n", sep = "")
                              cat("  Weight:  ", private$..weight, "\n", sep = "")
                              cat("  BMI:  ", private$..bmi, "\n", sep = "")
                            },
                            # Method to calcualte BMI
                            calculate_bmi = function(weight, height) {
                              self$validate_weight_value(weight)
                              self$validate_height_value(height)
                              return(weight / (height^2))
                            },
                            # Method to check SEX input
                            validate_sex = function(value) {
                              if(tolower(value) %in% c('male', 'female')) return(tolower(value))
                              stop("Unknown value. Allowed options: Male, Female. Note: case doesn't matter.")
                            },
                            # Method to check HEIGHT input
                            validate_height_value = function(value) {
                              self$validate_numeric(value)
                              if(!(value < 2.2 && value > 0.4)) stop('Height should fall within a practical range, measured in meters')
                              return(value)
                            },
                            # Method to check WEIGHT input
                            validate_weight_value = function(value) {
                              self$validate_numeric(value)
                              if(!(value < 250 && value > 1)) stop('Weight should fall within a practical range, measured in kilograms')
                              return(value)
                            },
                            # Method to check AGE input
                            validate_age_value = function(value) {
                              self$validate_numeric(value)
                              if(!(value < 110 && value > 0)) stop('Age should fall within a practical range')
                              return(value)
                            },
                            # Method to validate numeric inputs
                            validate_numeric = function(value) {
                              if(!is.numeric(value)) stop('age, height and weight fields should be in a numeric format')
                              return(value)
                            },
                            # Method to get age value
                            get_age_value = function() {
                              return(private$..age)
                            },
                            # Method to print individual data
                            print_individual = function() {
                              cat(
                                sprintf(
                                  "ID: %s, \nSex: %s, \nAge: %d, \nHeight: %.2f, \nWeight: %.2f, \nBMI: %.2f\n",
                                  private$..unique_id, private$..sex, private$..age, private$..height, private$..weight, private$..bmi
                                )
                              )
                            },
                            #' @description
                            #' Get individual in df format.
                            get_individual_df = function() {
                              return(
                                data.frame(
                                  id = private$..unique_id,
                                  sex = private$..sex,
                                  age = private$..age,
                                  height = private$..height,
                                  weight = private$..weight,
                                  bmi = private$..bmi
                                )
                              )
                            }
                          )
)

#' Creates new shiny.worker object
#'
#' @return bioSample object
#' @export
#'
#' @examples
#' Individual$new('Male', 25, 1.75, 70)

