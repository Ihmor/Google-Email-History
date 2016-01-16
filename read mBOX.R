install.packages("tm.plugin.mail")
library(tm.plugin.mail)

setwd("C:/Private/Google Email History")
dir()

mbf <- "test.mbox"
convert_mbox_eml(mbf, "emlfile11234567")

maildir <- "emlfile12345"
mailfiles <- dir(maildir, full.names=TRUE)

readmsg <- function(fname) {
	l <- readLines(fname)
	subj <- grep("Subject: ", l, value=TRUE)
	subj <- gsub("Subject: ", "", subj)
	date <- grep("Date: ", l, value=TRUE)
	date <- gsub("Date: ", "", date)
	text1 <- tail(l, 3)[1]
	text2 <- tail(l, 3)[2]
	return(c(subj, date, text1, text2))
}

mdf <- do.call(rbind, lapply(mailfiles, readmsg)) 


####### big one...
mbox <- "Alle E-Mails einschließlich Spam-Nachrichten und E-2.mbox"
convert_mbox_eml(mbox, "google takeout")

gfiles <- dir(maildir, full.names=TRUE)