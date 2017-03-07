#!/usr/bin/expect -f

set timeout 30

spawn /opt/codebeamer/cb.bin

expect "Directory (" { send "/opt/codebeamer/dist\r" }

expect "LICENSE AGREEMENT" { send "n\r" }

expect "Do you agree with the LICENSE AGREEMENT" { send "Y\r"}

expect "Please enter the TCP/IP portnumber for codeBeamer" { send "8080\r"}

expect "Please enter the SSL TCP/IP portnumber for codeBeamer" {send "8443\r"}

expect "Please enter the SHUTDOWN portnumber for codeBeamer" {send "8002\r"}

expect "Do you want to start codeBeamer setup wizard now" {send "y\r\r"}

interact
