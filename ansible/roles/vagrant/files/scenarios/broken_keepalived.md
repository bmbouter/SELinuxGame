

On your first day of work at Acme, Inc your new manager Jane is talking to you at your desk:

Jane: "Your first assignment is to figure out how we can stop having to rely on an engineer to
       restart our order processing application several times a day."

You: "Why does the application need to be restarted so often?"

Jane: "We are still trying to figure that out, but when it's down, orders pile up on the message
       bus until someone restarts the application. We are starting to miss delivery deadlines
       because of this problem."

You: "I have just the tool to solve this problem. It's called `keepalived`. It will restart the
      application when it notices that it has crashed."

You decide to put together a quick POC on your Fedora 25 machine. You install keepalived. Then you
run `sudo systemctl start keepalived` to start the daemon. You then look at `sudo journalctl -f` and
notice that `keepalived` keeps crashing and restarting. The problem goes away when you disable SELinux.
It even seems to be gone after you re-enable SELinux, but comes right back when
you restart `keepalived` with SELinux enforcing.

Objective:

* Determine how to start `keepalived` with SELinux enabled and without scary AVC denials.

