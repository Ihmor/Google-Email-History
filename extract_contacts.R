#contacts.df <- read.table(file = "Meine Kontakte.vcf", sep = "¢", quote = "")
contacts.df <- read.table(file = "Alle Kontakte.vcf", sep = "¢", quote = "")

emails.l <- list()
new.contact <- which(contacts.df == "BEGIN:VCARD")
new.contact <- c(new.contact,nrow(contacts.df))

for(i in 1:(length(new.contact)-1)){
	print(i)
	first <- new.contact[i]
	second <- new.contact[i+1]
	contact <- contacts.df[first : second,]
	cat(contact)

	emails <- contact[substr(contact,1,6) == "EMAIL;"]
	for(email in emails){
		tmp <- regmatches(email, regexpr(":.*",email))
		tmp <- substr(tmp,2,nchar(tmp))
		emails.l[[i]] <- unlist(list(emails.l[i], tmp))
	}
}
emails.l <- emails.l[lapply(emails.l,length) != 0]
emails.l <- emails.l[lapply(emails.l,length) > 1]
alias.l  <- emails.l[lapply(emails.l,length) > 1]
emails.l
	