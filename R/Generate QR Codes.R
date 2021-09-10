library(qrcode)

{
svg("PandyEvents.svg")
qrcode_gen("https://pandemoniumbooks.com/apps/bookthatapp/calendar")
dev.off()
}

{
png("PandyEvents.png")
qrcode_gen("https://pandemoniumbooks.com/apps/bookthatapp/calendar")
dev.off()
}
