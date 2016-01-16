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
    print "#{count} mails\n"
    begin
      File.open(RMail::Parser.read(raw).header.date.strftime("split/mail-%y%m.txt"), 'a') do |out|
        out.print(RMail::Parser.read(raw).header['date'])
        out.print("\t")
        out.print(RMail::Parser.read(raw).header['From'])
        out.print("\t")
        out.print(RMail::Parser.read(raw).header['To'])
        out.print("\t")
        out.print(RMail::Parser.read(raw).header['Subject'])
        out.print("\t")
        out.print(RMail::Parser.read(raw).header['cc'])
        out.print("\t")
        out.print(RMail::Parser.read(raw).header['bcc'])
        #out.print("\t")
        #out.print(RMail::Parser.read(raw).header)
        #out.print("\n")
      end
    rescue NoMethodError
      print "Couldn't parse date header, ignoring broken spam mail\n"
    end
  end
end
