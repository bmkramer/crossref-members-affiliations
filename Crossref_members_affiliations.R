#this script uses the Crossref API to get information on the presence of affiliation information 
#in metadata of current journal articles of Crossref members (n=12238 as of Feb 28, 2019) 
#Crossref REST API information: https://github.com/CrossRef/rest-api-doc

#general idea: 
#for the number of member IDs, loop through the results per member (using row=1&offset=x)
#for each member, retrieve:
# offset number
# member ID
# member name
# number of current DOIs
# % of current DOIs with affiliation, 
# number of current journal articles 
# % of current journal articles with affiliation info
#NB Current = current year and two full years preceding

#install packages
install.packages("rjson")
install.packages("httpcache")
require(rjson)
require(httpcache)

#define function to accommodate NULL results
naIfNull <- function(cell){
  if(is.null(cell)) {
    return(NA)
  } else {
    return(cell)
  }
}

#define function to get data from Crossref API and construct vector with relevant variables;
#this vector will become a row in the final dataframe to be produced;
#define n_character as character for doi to be included as such in the vector;
#employ naIfNull function because not all values are always present in OADOI output.
getData <- function(offset){
  n_character <- as.character(offset + 1)
  #enter your email address in the line below (replace your@email.com)
  #this helps Crossref contact you if something is wrong and gives access to dedicated servers for API requests
  url <- paste("https://api.crossref.org/members?rows=1&offset=",offset,"&mailto=your@email.com",sep="")
  raw_data <- GET(url)
  rd <- httr::content(raw_data)
  result <- c(
    n_character,
    naIfNull(rd$message$items[[1]]$id),
    naIfNull(rd$message$items[[1]]$'primary-name'),
    naIfNull(rd$message$items[[1]]$counts$`current-dois`),
    naIfNull(rd$message$items[[1]]$coverage$`affiliations-current`),
    naIfNull(rd$message$items[[1]]$`counts-type`$current$`journal-article`),
    naIfNull(rd$message$items[[1]]$`coverage-type`$current$`journal-article`$affiliations)
  )
  return(result)
}

#retrieve total number of members at sampling date
#enter your email address in the line below (replace your@email.com)
#this helps Crossref contact you if something is wrong and gives access to dedicated servers for API requests
url <- paste("https://api.crossref.org/members?rows=0&mailto=your@email.com")
raw_data <- GET(url)
rd <- httr::content(raw_data)
members_total <- rd$message$`total-results`

#create empty dataframe with 7 columns and number of rows set by members_total
df <- data.frame(matrix(nrow = members_total, ncol = 7))
#set column names of dataframe
colnames(df) = c(
  "n", 
  "member_id", 
  "member_name", 
  "current_DOIs", 
  "current_DOIs_affiliation", 
  "current_journal_articles", 
  "current_journal_articles_affiliation"
  )

#fill dataframe df (from 2nd row onwards) with API results
#either manually set values for loop, or use members_total as upper limit
#escape errors to jump any rows giving a 404 in API call
for (i in 12001:12238){
#for (i in 1:members_total){
  tryCatch({
    df[i, ] <- getData(i-1)
  }, error=function(e){})
}

#write results to csv
write.csv(df, file="Crossref_members_affiliations.csv", row.names=FALSE)


#------------------------------------------------------------------------------------------------
#alternative using lapply, eiher setting members_total as upper limit or setting upper limit manually 


my.list <- lapply(1:100, getData)
#my.list <- lapply(1:members_total, getData)

#convert list to dataframe, add column names
df <-as.data.frame(do.call(rbind, my.list), stringsAsFactors = FALSE) 
colnames(df) = c(
  "n", 
  "member_id", 
  "member_name", 
  "current_DOIs", 
  "current_DOIs_affiliation", 
  "current_journal_articles", 
  "current_journal_articles_affiliation"
)

#write results to csv
write.csv(df, file="Crossref_members_affiliations.csv", row.names=FALSE)

#------------------------------------------------------------------------------------------------
