#!/usr/bin/ruby -w

# Split a mbox file into $year-$month files
# Copyright (C) 2008 Joerg Jaspert
# BSD style license, on Debian see /usr/share/common-licenses/BSD

require 'pathname'
require 'rmail'

count = 0

File.open(Pathname.new(ARGV[0]), 'r') do |mbox|
  RMail::Mailbox.parse_mbox(mbox) do |raw|
    count += 1
    print "\r#{count} mails"
    begin
      File.open(RMail::Parser.read(raw).header.date.strftime("split/mail-%y%m.txt"), 'a') do |out|
        text = "NewMessage\t" + 
               RMail::Parser.read(raw).header["date"].gsub(/\s+/, "") + "\t" +
               RMail::Parser.read(raw).header["From"].gsub(/\s+/, "") + "\t" +
               RMail::Parser.read(raw).header["To"].gsub(/\s+/, "")  + "\t"  +             
               RMail::Parser.read(raw).header["Subject"].gsub(/\s+/, "") + "\n"
        out.print(text)
        #out.print(RMail::Parser.read(raw).header['cc'].gsub(/\s+/, ""))
        #out.print("\n\n")
        #RMail::Parser.read(raw).header['cc'].gsub(/\s+/, "") 
        #RMail::Parser.read(raw).header["bcc"].gsub(/\s+\"\'/, "") + "\t" +
      end
    rescue NoMethodError
      print "Couldn't parse date header, ignoring broken spam mail\n"
    end
  end
end
