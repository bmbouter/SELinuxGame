

Bill noticed the email server antivirus stopped scanning attachments, and he
thinks its SELinux related. He says if you disable SELinux the antivirus
scanning works. You overhear Bill say he can fix this by disabling SELinux.

"Can I help fix it without disabling SELinux?" - You

"Sure." - Bill

"How do you reproduce the problem that shows the error from the antivirus
scanner?" - You

Bill explains, "As any unprivileged user you can run
`clamdscan /mnt/email_attachments/*` and you'll see the errors from the
clamdscan. `clamdscan` is the client and `clamd` is the server, both of these
run on this same host while we are troubleshooting. In addition to the client
errors I see some SELinux errors"


