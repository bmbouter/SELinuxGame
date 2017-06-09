

Your co-worker, Xiang needs to host a static site built with
[Jekyll](http://jekyllrb.com/). She installed it and configured Apache, but
when she tries to fetch it she receives a 403 Forbidden error along with some
AVC denials. She notices that if you temporarily disable SELinux she is able
to fetch the test page.

Xiang tells you, "To reproduce, run curl against the test page on localhost."

    curl http://localhost/index.html

She shows you the failure which looks like this:

    <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
    <html><head>
    <title>403 Forbidden</title>
    </head><body>
    <h1>Forbidden</h1>
    <p>You don't have permission to access /index.html
    on this server.<br />
    </p>
    </body></html>

At Super Secure, Corp. SELinux must be enforcing on all webservers. Do you
know how to help Xiang?

Objective:

* Run the curl reproducer with SELinux Enforcing and have it serve the test
  page data.

