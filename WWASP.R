# update.packages(checkBuilt=TRUE, ask=FALSE)
install.packages(c("devtools", "dplyr", "mice", "googledrive"))
devtools::install_github(c("tidyverse/googlesheets4"))


library(mice)
library(googledrive)
library(googlesheets4)

#=================================================================#

# rm(list=ls()) # Removes all objects in the workspace
#=========================Working with Google Drive==

# If running R on a server (i.e. rstudio.cloud), run the following lines:
# options(httr_oob_default = T)
# drive_auth(new_user = T)

# Afterwards, find the file you want to read:
googledrive::drive_find(pattern = "WWASPdata_working_v2", # only the istems whose names match this expression are returned
                        type = "spreadsheet", # filters the file type to return
                        n_max = 10) # the max number of items to return

# It's best to use the 'id' provided in the output, case the file name changes in the future.
WWASP.meta <- googledrive::drive_get(id = "1U7VhCAi2DgeXCNRVOny4QGhORCkXfNZQUqPH8NGKfSs") # You will need to copy and paste a code in the console below
WWASP.meta

#=========================Reading Datasets==

# Read the Google sheet file into R:
baseWWASP <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta), # ID of the Google sheet file
                                        sheet = "cleandata", # selects the worksheet to be read
                                        range = "A2:E151", # filters the range of cells to be read
                                        trim_ws = T) # trim any space before and after a number/string within each cell
baseWWASP[baseWWASP == -99] <- NA

# Define the names of the levels of year
levels(baseWWASP$Yr) <- c("Yr1", "Yr2", "Yr3")
Yr <- baseWWASP$Yr
# Create year factor
fYr <- factor(baseWWASP$Yr,
              levels = c(1, 2, 3),
              labels = c("Yr1", "Yr2", "Yr3"))

# Define the names of the levels of school
levels(baseWWASP$Sch) <- c("Andress", "Burges", "Chapin", "Irvin")
Sch <- baseWWASP$Sch
# Create school factor
fSch <- factor(baseWWASP$Sch,
               levels = c(1, 2, 3, 4),
               labels = c("Andress", "Burges", "Chapin", "Irvin"))

# Define the names of the levels of condition
levels(baseWWASP$Con) <- c("Group A", "Group B", "Group C")
Con <- baseWWASP$Con
# Create condition factor
fCon <- factor(baseWWASP$Con,
               levels = c(1, 2, 3),
               labels = c("Group A", "Group B", "Group C"))

# Define the names of the levels of sex
levels(baseWWASP$Sex) <- c("Male", "Female")
Sex <- baseWWASP$Sex
# Create sex factor
fSex <- factor(baseWWASP$Sex,
               levels = c(1, 2),
               labels = c("Male", "Female"))

# Define the names of the levels of ethnicity
levels(baseWWASP$Eth) <- c("African American", "Asian American",
                           "Asian American/African American/Mixed",
                           "Black", "Black/White/Native American",
                           "Hispanic", "Hispanic/Black", "Hispanic/White",
                           "Multi ethnic", "White", "White/Asian American",
                           "White/Native American")
Eth <- baseWWASP$Eth
# Create ethnicity factor
fEth <- factor(baseWWASP$Eth,
               levels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
               labels = c("African American", "Asian American",
                          "Asian American/African American/Mixed",
                          "Black", "Black/White/Native American",
                          "Hispanic", "Hispanic/Black", "Hispanic/White",
                          "Multi ethnic", "White", "White/Asian American",
                          "White/Native American"))


preCLES <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta),
                                      sheet = "cleandata",
                                      range = "F2:AG151",
                                      trim_ws = T)
preCLES[preCLES == -99] <- NA

# Define the names of the levels of pre Autonomy
levels(preCLES$preAut1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preAut2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preAut3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preAut4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preAut5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preAut6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preAut7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create pre Autonomy factor
fpreAut1 <- factor(preCLES$preAut1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreAut2 <- factor(preCLES$preAut2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreAut3 <- factor(preCLES$preAut3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreAut4 <- factor(preCLES$preAut4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreAut5 <- factor(preCLES$preAut5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreAut6 <- factor(preCLES$preAut6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreAut7 <- factor(preCLES$preAut7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))

# Define the names of the levels of pre Negotiation
levels(preCLES$preNeg1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preNeg2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preNeg3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preNeg4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preNeg5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preNeg6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preNeg7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create pre Negotiation factor
fpreNeg1 <- factor(preCLES$preNeg1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreNeg2 <- factor(preCLES$preNeg2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreNeg3 <- factor(preCLES$preNeg3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreNeg4 <- factor(preCLES$preNeg4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreNeg5 <- factor(preCLES$preNeg5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreNeg6 <- factor(preCLES$preNeg6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreNeg7 <- factor(preCLES$preNeg7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))

# Define the names of the levels of pre Prior Knowledge
levels(preCLES$prePKn1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$prePKn2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$prePKn3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$prePKn4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$prePKn5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$prePKn6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$prePKn7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create pre Prior Knowledge factor
fprePKn1 <- factor(preCLES$prePKn1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fprePKn2 <- factor(preCLES$prePKn2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fprePKn3 <- factor(preCLES$prePKn3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fprePKn4 <- factor(preCLES$prePKn4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fprePKn5 <- factor(preCLES$prePKn5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fprePKn6 <- factor(preCLES$prePKn6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fprePKn7 <- factor(preCLES$prePKn7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))

# Define the names of the levels of pre Student Centered
levels(preCLES$preSCe1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preSCe2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preSCe3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preSCe4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preSCe5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preSCe6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(preCLES$preSCe7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create pre Student Centered factor
fpreSCe1 <- factor(preCLES$preSCe1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreSCe2 <- factor(preCLES$preSCe2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreSCe3 <- factor(preCLES$preSCe3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreSCe4 <- factor(preCLES$preSCe4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreSCe5 <- factor(preCLES$preSCe5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreSCe6 <- factor(preCLES$preSCe6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpreSCe7 <- factor(preCLES$preSCe7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("almost never", "seldom", "sometimes", "often", "almost always"))



postCLES <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta),
                                       sheet = "cleandata",
                                       range = "AH2:BI151",
                                       trim_ws = T)
postCLES[postCLES == -99] <- NA

# Define the names of the levels of post Autonomy
levels(postCLES$postAut1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postAut2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postAut3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postAut4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postAut5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postAut6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postAut7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create post Autonomy factor
fpostAut1 <- factor(postCLES$postAut1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostAut2 <- factor(postCLES$postAut2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostAut3 <- factor(postCLES$postAut3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostAut4 <- factor(postCLES$postAut4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostAut5 <- factor(postCLES$postAut5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostAut6 <- factor(postCLES$postAut6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostAut7 <- factor(postCLES$postAut7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))

# Define the names of the levels of post Negotiation
levels(postCLES$postNeg1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postNeg2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postNeg3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postNeg4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postNeg5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postNeg6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postNeg7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create post Negotiation factor
fpostNeg1 <- factor(postCLES$postNeg1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostNeg2 <- factor(postCLES$postNeg2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostNeg3 <- factor(postCLES$postNeg3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostNeg4 <- factor(postCLES$postNeg4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostNeg5 <- factor(postCLES$postNeg5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostNeg6 <- factor(postCLES$postNeg6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostNeg7 <- factor(postCLES$postNeg7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))

# Define the names of the levels of post Prior Knowledge
levels(postCLES$postPKn1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postPKn2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postPKn3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postPKn4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postPKn5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postPKn6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postPKn7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create post Prior Knowledge factor
fpostPKn1 <- factor(postCLES$postPKn1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostPKn2 <- factor(postCLES$postPKn2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostPKn3 <- factor(postCLES$postPKn3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostPKn4 <- factor(postCLES$postPKn4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostPKn5 <- factor(postCLES$postPKn5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostPKn6 <- factor(postCLES$postPKn6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostPKn7 <- factor(postCLES$postPKn7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))

# Define the names of the levels of post Student Centered
levels(postCLES$postSCe1) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postSCe2) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postSCe3) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postSCe4) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postSCe5) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postSCe6) <- c("almost never", "seldom", "sometimes", "often", "almost always")
levels(postCLES$postSCe7) <- c("almost never", "seldom", "sometimes", "often", "almost always")
# Create post Student Centered factor
fpostSCe1 <- factor(postCLES$postSCe1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostSCe2 <- factor(postCLES$postSCe2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostSCe3 <- factor(postCLES$postSCe3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostSCe4 <- factor(postCLES$postSCe4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostSCe5 <- factor(postCLES$postSCe5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostSCe6 <- factor(postCLES$postSCe6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))
fpostSCe7 <- factor(postCLES$postSCe7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("almost never", "seldom", "sometimes", "often", "almost always"))



preCARS <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta),
                                      sheet = "cleandata",
                                      range = "BJ2:CH151",
                                      trim_ws = T)
preCARS[preCARS == -99] <- NA

# Define the names of the levels of pre CARS
levels(preCARS$preCARS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS11) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS12) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS13) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS14) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS15) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS16) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS17) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS18) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS19) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS20) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS21) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS22) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS23) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS24) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preCARS$preCARS25) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre CARS factor
fpreCARS1 <- factor(preCARS$preCARS1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS2 <- factor(preCARS$preCARS2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS3 <- factor(preCARS$preCARS3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS4 <- factor(preCARS$preCARS4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS5 <- factor(preCARS$preCARS5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS6 <- factor(preCARS$preCARS6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS7 <- factor(preCARS$preCARS7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS8 <- factor(preCARS$preCARS8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS9 <- factor(preCARS$preCARS9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS10 <- factor(preCARS$preCARS10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS11 <- factor(preCARS$preCARS11,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS12 <- factor(preCARS$preCARS12,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS13 <- factor(preCARS$preCARS13,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS14 <- factor(preCARS$preCARS14,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS15 <- factor(preCARS$preCARS15,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS16 <- factor(preCARS$preCARS16,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS17 <- factor(preCARS$preCARS17,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS18 <- factor(preCARS$preCARS18,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS19 <- factor(preCARS$preCARS19,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS20 <- factor(preCARS$preCARS20,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS21 <- factor(preCARS$preCARS21,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS22 <- factor(preCARS$preCARS22,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS23 <- factor(preCARS$preCARS23,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS24 <- factor(preCARS$preCARS24,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCARS25 <- factor(preCARS$preCARS25,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))



postCARS <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta),
                                       sheet = "cleandata",
                                       range = "CI2:DG151",
                                       trim_ws = T)
postCARS[postCARS == -99] <- NA

# Define the names of the levels of post CARS
levels(postCARS$postCARS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS11) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS12) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS13) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS14) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS15) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS16) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS17) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS18) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS19) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS20) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS21) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS22) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS23) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS24) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postCARS$postCARS25) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post CARS factor
fpostCARS1 <- factor(postCARS$postCARS1,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS2 <- factor(postCARS$postCARS2,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS3 <- factor(postCARS$postCARS3,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS4 <- factor(postCARS$postCARS4,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS5 <- factor(postCARS$postCARS5,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS6 <- factor(postCARS$postCARS6,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS7 <- factor(postCARS$postCARS7,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS8 <- factor(postCARS$postCARS8,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS9 <- factor(postCARS$postCARS9,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS10 <- factor(postCARS$postCARS10,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS11 <- factor(postCARS$postCARS11,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS12 <- factor(postCARS$postCARS12,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS13 <- factor(postCARS$postCARS13,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS14 <- factor(postCARS$postCARS14,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS15 <- factor(postCARS$postCARS15,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS16 <- factor(postCARS$postCARS16,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS17 <- factor(postCARS$postCARS17,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS18 <- factor(postCARS$postCARS18,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS19 <- factor(postCARS$postCARS19,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS20 <- factor(postCARS$postCARS20,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS21 <- factor(postCARS$postCARS21,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS22 <- factor(postCARS$postCARS22,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS23 <- factor(postCARS$postCARS23,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS24 <- factor(postCARS$postCARS24,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCARS25 <- factor(postCARS$postCARS25,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))


preTOSRA <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta),
                                       sheet = "cleandata",
                                       range = "DH2:FY151",
                                       trim_ws = T)
preTOSRA[preTOSRA == -99] <- NA

# Define the names of the levels of pre Adoption of Scientific Attitudes
levels(preTOSRA$preASA1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASA10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Adoption of Scientific Attitudes factor
fpreASA1 <- factor(preTOSRA$preASA1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA2 <- factor(preTOSRA$preASA2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA3 <- factor(preTOSRA$preASA3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA4 <- factor(preTOSRA$preASA4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA5 <- factor(preTOSRA$preASA5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA6 <- factor(preTOSRA$preASA6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA7 <- factor(preTOSRA$preASA7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA8 <- factor(preTOSRA$preASA8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA9 <- factor(preTOSRA$preASA9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASA10 <- factor(preTOSRA$preASA10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of pre Attitudes towards Scientific Inquiry
levels(preTOSRA$preASI1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preASI10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Attitudes towards Scientific Inquiry factor
fpreASI1 <- factor(preTOSRA$preASI1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI2 <- factor(preTOSRA$preASI2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI3 <- factor(preTOSRA$preASI3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI4 <- factor(preTOSRA$preASI4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI5 <- factor(preTOSRA$preASI5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI6 <- factor(preTOSRA$preASI6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI7 <- factor(preTOSRA$preASI7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI8 <- factor(preTOSRA$preASI8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI9 <- factor(preTOSRA$preASI9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreASI10 <- factor(preTOSRA$preASI10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of pre Career Interest in Science
levels(preTOSRA$preCIS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preCIS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Career Interest in Science factor
fpreCIS1 <- factor(preTOSRA$preCIS1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS2 <- factor(preTOSRA$preCIS2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS3 <- factor(preTOSRA$preCIS3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS4 <- factor(preTOSRA$preCIS4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS5 <- factor(preTOSRA$preCIS5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS6 <- factor(preTOSRA$preCIS6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS7 <- factor(preTOSRA$preCIS7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS8 <- factor(preTOSRA$preCIS8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS9 <- factor(preTOSRA$preCIS9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreCIS10 <- factor(preTOSRA$preCIS10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of pre Enjoyment of Science Lessons
levels(preTOSRA$preESL1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preESL10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Enjoyment of Science Lessons factor
fpreESL1 <- factor(preTOSRA$preESL1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL2 <- factor(preTOSRA$preESL2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL3 <- factor(preTOSRA$preESL3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL4 <- factor(preTOSRA$preESL4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL5 <- factor(preTOSRA$preESL5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL6 <- factor(preTOSRA$preESL6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL7 <- factor(preTOSRA$preESL7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL8 <- factor(preTOSRA$preESL8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL9 <- factor(preTOSRA$preESL9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreESL10 <- factor(preTOSRA$preESL10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of pre Leisure Interest in Science
levels(preTOSRA$preLIS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preLIS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Leisure Interest in Science factor
fpreLIS1 <- factor(preTOSRA$preLIS1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS2 <- factor(preTOSRA$preLIS2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS3 <- factor(preTOSRA$preLIS3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS4 <- factor(preTOSRA$preLIS4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS5 <- factor(preTOSRA$preLIS5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS6 <- factor(preTOSRA$preLIS6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS7 <- factor(preTOSRA$preLIS7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS8 <- factor(preTOSRA$preLIS8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS9 <- factor(preTOSRA$preLIS9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreLIS10 <- factor(preTOSRA$preLIS10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of pre Normality of Scientists
levels(preTOSRA$preNSc1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preNSc10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Normality of Scientists factor
fpreNSc1 <- factor(preTOSRA$preNSc1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc2 <- factor(preTOSRA$preNSc2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc3 <- factor(preTOSRA$preNSc3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc4 <- factor(preTOSRA$preNSc4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc5 <- factor(preTOSRA$preNSc5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc6 <- factor(preTOSRA$preNSc6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc7 <- factor(preTOSRA$preNSc7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc8 <- factor(preTOSRA$preNSc8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc9 <- factor(preTOSRA$preNSc9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreNSc10 <- factor(preTOSRA$preNSc10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of pre Social Implication of Science
levels(preTOSRA$preSIS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(preTOSRA$preSIS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create pre Social Implication of Science factor
fpreSIS1 <- factor(preTOSRA$preSIS1,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS2 <- factor(preTOSRA$preSIS2,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS3 <- factor(preTOSRA$preSIS3,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS4 <- factor(preTOSRA$preSIS4,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS5 <- factor(preTOSRA$preSIS5,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS6 <- factor(preTOSRA$preSIS6,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS7 <- factor(preTOSRA$preSIS7,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS8 <- factor(preTOSRA$preSIS8,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS9 <- factor(preTOSRA$preSIS9,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpreSIS10 <- factor(preTOSRA$preSIS10,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))



postTOSRA <- googlesheets4::sheets_read(as_sheets_id(WWASP.meta),
                                        sheet = "cleandata",
                                        range = "FZ2:IQ151",
                                        trim_ws = T)
postTOSRA[postTOSRA == -99] <- NA

# Define the names of the levels of post Adoption of Scientific Attitudes
levels(postTOSRA$postASA1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASA10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Adoption of Scientific Attitudes factor
fpostASA1 <- factor(postTOSRA$postASA1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA2 <- factor(postTOSRA$postASA2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA3 <- factor(postTOSRA$postASA3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA4 <- factor(postTOSRA$postASA4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA5 <- factor(postTOSRA$postASA5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA6 <- factor(postTOSRA$postASA6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA7 <- factor(postTOSRA$postASA7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA8 <- factor(postTOSRA$postASA8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA9 <- factor(postTOSRA$postASA9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASA10 <- factor(postTOSRA$postASA10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of post Attitudes towards Scientific Inquiry
levels(postTOSRA$postASI1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postASI10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Attitudes towards Scientific Inquiry factor
fpostASI1 <- factor(postTOSRA$postASI1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI2 <- factor(postTOSRA$postASI2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI3 <- factor(postTOSRA$postASI3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI4 <- factor(postTOSRA$postASI4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI5 <- factor(postTOSRA$postASI5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI6 <- factor(postTOSRA$postASI6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI7 <- factor(postTOSRA$postASI7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI8 <- factor(postTOSRA$postASI8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI9 <- factor(postTOSRA$postASI9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostASI10 <- factor(postTOSRA$postASI10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of post Career Interest in Science
levels(postTOSRA$postCIS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postCIS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Career Interest in Science factor
fpostCIS1 <- factor(postTOSRA$postCIS1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS2 <- factor(postTOSRA$postCIS2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS3 <- factor(postTOSRA$postCIS3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS4 <- factor(postTOSRA$postCIS4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS5 <- factor(postTOSRA$postCIS5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS6 <- factor(postTOSRA$postCIS6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS7 <- factor(postTOSRA$postCIS7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS8 <- factor(postTOSRA$postCIS8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS9 <- factor(postTOSRA$postCIS9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostCIS10 <- factor(postTOSRA$postCIS10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of post Enjoyment of Science Lessons
levels(postTOSRA$postESL1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postESL10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Enjoyment of Science Lessons factor
fpostESL1 <- factor(postTOSRA$postESL1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL2 <- factor(postTOSRA$postESL2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL3 <- factor(postTOSRA$postESL3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL4 <- factor(postTOSRA$postESL4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL5 <- factor(postTOSRA$postESL5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL6 <- factor(postTOSRA$postESL6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL7 <- factor(postTOSRA$postESL7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL8 <- factor(postTOSRA$postESL8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL9 <- factor(postTOSRA$postESL9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostESL10 <- factor(postTOSRA$postESL10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of post Leisure Interest in Science
levels(postTOSRA$postLIS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postLIS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Leisure Interest in Science factor
fpostLIS1 <- factor(postTOSRA$postLIS1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS2 <- factor(postTOSRA$postLIS2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS3 <- factor(postTOSRA$postLIS3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS4 <- factor(postTOSRA$postLIS4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS5 <- factor(postTOSRA$postLIS5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS6 <- factor(postTOSRA$postLIS6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS7 <- factor(postTOSRA$postLIS7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS8 <- factor(postTOSRA$postLIS8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS9 <- factor(postTOSRA$postLIS9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostLIS10 <- factor(postTOSRA$postLIS10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of post Normality of Scientists
levels(postTOSRA$postNSc1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postNSc10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Normality of Scientists factor
fpostNSc1 <- factor(postTOSRA$postNSc1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc2 <- factor(postTOSRA$postNSc2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc3 <- factor(postTOSRA$postNSc3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc4 <- factor(postTOSRA$postNSc4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc5 <- factor(postTOSRA$postNSc5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc6 <- factor(postTOSRA$postNSc6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc7 <- factor(postTOSRA$postNSc7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc8 <- factor(postTOSRA$postNSc8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc9 <- factor(postTOSRA$postNSc9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostNSc10 <- factor(postTOSRA$postNSc10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))

# Define the names of the levels of post Social Implication of Science
levels(postTOSRA$postSIS1) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS2) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS3) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS4) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS5) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS6) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS7) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS8) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS9) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
levels(postTOSRA$postSIS10) <- c("strongly disagree", "disagree", "neutral", "agree", "strongly agree")
# Create post Social Implication of Science factor
fpostSIS1 <- factor(postTOSRA$postSIS1,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS2 <- factor(postTOSRA$postSIS2,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS3 <- factor(postTOSRA$postSIS3,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS4 <- factor(postTOSRA$postSIS4,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS5 <- factor(postTOSRA$postSIS5,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS6 <- factor(postTOSRA$postSIS6,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS7 <- factor(postTOSRA$postSIS7,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS8 <- factor(postTOSRA$postSIS8,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS9 <- factor(postTOSRA$postSIS9,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))
fpostSIS10 <- factor(postTOSRA$postSIS10,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("strongly disagree", "disagree", "neutral", "agree", "strongly agree"))


#==========Data Wrangling==
# CLES subsets
preAutonomy <- preCLES[ , names(preCLES) %in% c("preAut1", "preAut2", "preAut3", "preAut4",
                                                "preAut5", "preAut6", "preAut7")]

preNegotiation <- preCLES[ , names(preCLES) %in% c("preNeg1", "preNeg2", "preNeg3", "preNeg4",
                                                   "preNeg5", "preNeg6", "preNeg7")]

prePriorKnowledge <- preCLES[ , names(preCLES) %in% c("prePKn1", "prePKn2", "prePKn3", "prePKn4",
                                                      "prePKn5", "prePKn6", "prePKn7")]

preStudentCentered <- preCLES[ , names(preCLES) %in% c("preSCe1", "preSCe2", "preSCe3", "preSCe4",
                                                       "preSCe5", "preSCe6", "preSCe7")]

postAutonomy <- postCLES[ , names(postCLES) %in% c("postAut1", "postAut2", "postAut3", "postAut4",
                                                   "postAut5", "postAut6", "postAut7")]

postNegotiation <- postCLES[ , names(postCLES) %in% c("postNeg1", "postNeg2", "postNeg3", "postNeg4",
                                                      "postNeg5", "postNeg6", "postNeg7")]

postPriorKnowledge <- postCLES[ , names(postCLES) %in% c("postPKn1", "postPKn2", "postPKn3", "postPKn4",
                                                         "postPKn5", "postPKn6", "postPKn7")]

postStudentCentered <- postCLES[ , names(postCLES) %in% c("postSCe1", "postSCe2", "postSCe3", "postSCe4",
                                                          "postSCe5", "postSCe6", "postSCe7")]
# CLES factor subsets
prefAutonomy <- table(c("fpreAut1", "fpreAut2", "fpreAut3", "fpreAut4",
                        "fpreAut5", "fpreAut6", "fpreAut7"))

prefNegotiation <- preCLES[ , names(preCLES) %in% c("fpreNeg1", "fpreNeg2", "fpreNeg3", "fpreNeg4",
                                                    "fpreNeg5", "fpreNeg6", "fpreNeg7")]

prefPriorKnowledge <- preCLES[ , names(preCLES) %in% c("fprePKn1", "fprePKn2", "fprePKn3", "fprePKn4",
                                                       "fprePKn5", "fprePKn6", "fprePKn7")]

prefStudentCentered <- preCLES[ , names(preCLES) %in% c("prefSCe1", "prefSCe2", "prefSCe3", "prefSCe4",
                                                        "prefSCe5", "prefSCe6", "prefSCe7")]

postfAutonomy <- postCLES[ , names(postCLES) %in% c("fpostAut1", "fpostAut2", "fpostAut3", "fpostAut4",
                                                    "fpostAut5", "fpostAut6", "fpostAut7")]

postfNegotiation <- postCLES[ , names(postCLES) %in% c("fpostNeg1", "fpostNeg2", "fpostNeg3", "fpostNeg4",
                                                       "fpostNeg5", "fpostNeg6", "fpostNeg7")]

postfPriorKnowledge <- postCLES[ , names(postCLES) %in% c("fpostPKn1", "fpostPKn2", "fpostPKn3", "fpostPKn4",
                                                          "fpostPKn5", "fpostPKn6", "fpostPKn7")]

postfStudentCentered <- postCLES[ , names(postCLES) %in% c("postfSCe1", "postfSCe2", "postfSCe3", "postfSCe4",
                                                           "postfSCe5", "postfSCe6", "postfSCe7")]

# TOSRA subsets 
preAdoptionScientificAttitudes <- preTOSRA[ , names(preTOSRA) %in% c("preASA1", "preASA2", "preASA3", "preASA4",
                                                                     "preASA5", "preASA6", "preASA7",  "preASA8",  "preASA9",  "preASA10")]

preAttitudesScientificInquiry <- preTOSRA[ , names(preTOSRA) %in% c("preASI1", "preASI2", "preASI3", "preASI4",
                                                                    "preASI5", "preASI6", "preASI7",  "preASI8",  "preASI9",  "preASI10")]

preCareerInterestScience <- preTOSRA[ , names(preTOSRA) %in% c("preCIS1", "preCIS2", "preCIS3", "preCIS4",
                                                               "preCIS5", "preCIS6", "preCIS7",  "preCIS8",  "preCIS9",  "preCIS10")]

preEnjoymentScienceLessons <- preTOSRA[ , names(preTOSRA) %in% c("preESL1", "preESL2", "preESL3", "preESL4",
                                                                 "preESL5", "preESL6", "preESL7",  "preESL8",  "preESL9",  "preESL10")]

preLeisureInterestScience <- preTOSRA[ , names(preTOSRA) %in% c("preLIS1", "preLIS2", "preLIS3", "preLIS4",
                                                                "preLIS5", "preLIS6", "preLIS7",  "preLIS8",  "preLIS9",  "preLIS10")]

preNormalityScientists <- preTOSRA[ , names(preTOSRA) %in% c("preNSc1", "preNSc2", "preNSc3", "preNSc4",
                                                             "preNSc5", "preNSc6", "preNSc7",  "preNSc8",  "preNSc9",  "preNSc10")]

preSocialImplicatioSISience <- preTOSRA[ , names(preTOSRA) %in% c("preSIS1", "preSIS2", "preSIS3", "preSIS4",
                                                                  "preSIS5", "preSIS6", "preSIS7",  "preSIS8",  "preSIS9",  "preSIS10")]

postAdoptionScientificAttitudes <- postTOSRA[ , names(postTOSRA) %in% c("postASA1", "postASA2", "postASA3", "postASA4",
                                                                        "postASA5", "postASA6", "postASA7",  "postASA8",  "postASA9",  "postASA10")]

postAttitudesScientificInquiry <- postTOSRA[ , names(postTOSRA) %in% c("postASI1", "postASI2", "postASI3", "postASI4",
                                                                       "postASI5", "postASI6", "postASI7",  "postASI8",  "postASI9",  "postASI10")]

postCareerInterestScience <- postTOSRA[ , names(postTOSRA) %in% c("postCIS1", "postCIS2", "postCIS3", "postCIS4",
                                                                  "postCIS5", "postCIS6", "postCIS7",  "postCIS8",  "postCIS9",  "postCIS10")]

postEnjoymentScienceLessons <- postTOSRA[ , names(postTOSRA) %in% c("postESL1", "postESL2", "postESL3", "postESL4",
                                                                    "postESL5", "postESL6", "postESL7",  "postESL8",  "postESL9",  "postESL10")]

postLeisureInterestScience <- postTOSRA[ , names(postTOSRA) %in% c("postLIS1", "postLIS2", "postLIS3", "postLIS4",
                                                                   "postLIS5", "postLIS6", "postLIS7",  "postLIS8",  "postLIS9",  "postLIS10")]

postNormalityScientists <- postTOSRA[ , names(postTOSRA) %in% c("postNSc1", "postNSc2", "postNSc3", "postNSc4",
                                                                "postNSc5", "postNSc6", "postNSc7",  "postNSc8",  "postNSc9",  "postNSc10")]

postSocialImplicatioSISience <- postTOSRA[ , names(postTOSRA) %in% c("postSIS1", "postSIS2", "postSIS3", "postSIS4",
                                                                     "postSIS5", "postSIS6", "postSIS7",  "postSIS8",  "postSIS9",  "postSIS10")]

# TOSRA factor subsets
prefAdoptionScientificAttitudes <- preTOSRA[ , names(preTOSRA) %in% c("prefASA1", "prefASA2", "prefASA3", "prefASA4",
                                                                      "prefASA5", "prefASA6", "prefASA7",  "prefASA8",  "prefASA9",  "prefASA10")]

prefAttitudesScientificInquiry <- preTOSRA[ , names(preTOSRA) %in% c("prefASI1", "prefASI2", "prefASI3", "prefASI4",
                                                                     "prefASI5", "prefASI6", "prefASI7",  "prefASI8",  "prefASI9",  "prefASI10")]

prefCareerInterestScience <- preTOSRA[ , names(preTOSRA) %in% c("prefCIS1", "prefCIS2", "prefCIS3", "prefCIS4",
                                                                "prefCIS5", "prefCIS6", "prefCIS7",  "prefCIS8",  "prefCIS9",  "prefCIS10")]

prefEnjoymentScienceLessons <- preTOSRA[ , names(preTOSRA) %in% c("prefESL1", "prefESL2", "prefESL3", "prefESL4",
                                                                  "prefESL5", "prefESL6", "prefESL7",  "prefESL8",  "prefESL9",  "prefESL10")]

prefLeisureInterestScience <- preTOSRA[ , names(preTOSRA) %in% c("prefLIS1", "prefLIS2", "prefLIS3", "prefLIS4",
                                                                 "prefLIS5", "prefLIS6", "prefLIS7",  "prefLIS8",  "prefLIS9",  "prefLIS10")]

prefNormalityScientists <- preTOSRA[ , names(preTOSRA) %in% c("prefNSc1", "prefNSc2", "prefNSc3", "prefNSc4",
                                                              "prefNSc5", "prefNSc6", "prefNSc7",  "prefNSc8",  "prefNSc9",  "prefNSc10")]

prefSocialImplicatioSISience <- preTOSRA[ , names(preTOSRA) %in% c("prefSIS1", "prefSIS2", "prefSIS3", "prefSIS4",
                                                                   "prefSIS5", "prefSIS6", "prefSIS7",  "prefSIS8",  "prefSIS9",  "prefSIS10")]

postfAdoptionScientificAttitudes <- postTOSRA[ , names(postTOSRA) %in% c("postfASA1", "postfASA2", "postfASA3", "postfASA4",
                                                                         "postfASA5", "postfASA6", "postfASA7",  "postfASA8",  "postfASA9",  "postfASA10")]

postfAttitudesScientificInquiry <- postTOSRA[ , names(postTOSRA) %in% c("postfASI1", "postfASI2", "postfASI3", "postfASI4",
                                                                        "postfASI5", "postfASI6", "postfASI7",  "postfASI8",  "postfASI9",  "postfASI10")]

postfCareerInterestScience <- postTOSRA[ , names(postTOSRA) %in% c("postfCIS1", "postfCIS2", "postfCIS3", "postfCIS4",
                                                                   "postfCIS5", "postfCIS6", "postfCIS7",  "postfCIS8",  "postfCIS9",  "postfCIS10")]

postfEnjoymentScienceLessons <- postTOSRA[ , names(postTOSRA) %in% c("postfESL1", "postfESL2", "postfESL3", "postfESL4",
                                                                     "postfESL5", "postfESL6", "postfESL7",  "postfESL8",  "postfESL9",  "postfESL10")]

postfLeisureInterestScience <- postTOSRA[ , names(postTOSRA) %in% c("postfLIS1", "postfLIS2", "postfLIS3", "postfLIS4",
                                                                    "postfLIS5", "postfLIS6", "postfLIS7",  "postfLIS8",  "postfLIS9",  "postfLIS10")]

postfNormalityScientists <- postTOSRA[ , names(postTOSRA) %in% c("postfNSc1", "postfNSc2", "postfNSc3", "postfNSc4",
                                                                 "postfNSc5", "postfNSc6", "postfNSc7",  "postfNSc8",  "postfNSc9",  "postfNSc10")]

postfSocialImplicatioSISience <- postTOSRA[ , names(postTOSRA) %in% c("postfSIS1", "postfSIS2", "postfSIS3", "postfSIS4",
                                                                      "postfSIS5", "postfSIS6", "postfSIS7",  "postfSIS8",  "postfSIS9",  "postfSIS10")]

#=========================Missing Value Analysis==
# The function "sapply()" can be used to return basic descriptives for the dataset:
# In the following, 'function(x)' is a placeholder and 'is.na(x)' returns cases that
# have missing values, NA = TRUE
# TRUE = 1; FALSE = 0

# Missing value total and percentage
sapply(baseWWASP, # selects the entire dataset
       function(x) sum(is.na(x))) # returns the sum of missing values for each variable
round(sapply(baseWWASP,
             function(x) sum(is.na(x)) / length(x) * 100), 2) # percentage of missing data

sapply(preCLES,
       function(x) sum(is.na(x)))
round(sapply(preCLES,
             function(x) sum(is.na(x)) / length(x) * 100), 2)

sapply(postCLES,
       function(x) sum(is.na(x)))
round(sapply(postCLES,
             function(x) sum(is.na(x)) / length(x) * 100), 2)

sapply(preCARS,
       function(x) sum(is.na(x)))
round(sapply(preCARS,
             function(x) sum(is.na(x)) / length(x) * 100), 2)

sapply(postCARS,
       function(x) sum(is.na(x)))
round(sapply(postCARS,
             function(x) sum(is.na(x)) / length(x) * 100), 2)

sapply(preTOSRA,
       function(x) sum(is.na(x)))
round(sapply(preTOSRA,
             function(x) sum(is.na(x)) / length(x) * 100), 2)

sapply(postTOSRA,
       function(x) sum(is.na(x)))
round(sapply(postTOSRA,
             function(x) sum(is.na(x)) / length(x) * 100), 2)


# Multiple imputation should only be done to noncategorical variables with <5% of missing data
# First, I'll create a new function that returns the percentage of missing data
perc.missing = function(x) {sum(is.na(x)) / (length(x) *100)}
missing.preCARS <- (apply(preCARS, # selects dataset
                          1, # 1 to select all rows or 2 to select all columns
                          perc.missing)) # the function that we created
table(missing.preCAR)
      
      
      
      
# This is fun