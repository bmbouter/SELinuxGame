

Bill noticed the email server antivirus stopped scanning attachments, and he
thinks its SELinux related. He says, "If you disable SELinux the antivirus
scanning works."

You ask Bill, "How do you reproduce the problem?"

Bill explains, "As any unprivileged user you can run
`clamdscan /mnt/email_attachments/*` and you'll see the errors from the
clamdscan. `clamdscan` is the client and `clamd` is the server, both of these
run on this same host while we are troubleshooting. In addition to the client
errors I see some SELinux errors."

Objective:

* With SELinux enforcing, run the following command and have it complete
  without errors.

    `clamdscan /mnt/email_attachments/*`
