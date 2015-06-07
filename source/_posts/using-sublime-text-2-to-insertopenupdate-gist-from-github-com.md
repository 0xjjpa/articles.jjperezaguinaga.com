title: Using Sublime Text 2 to insert/open/update Gist from Github.com
tags:
  - gist
  - github
  - sublime text
id: 272
categories:
  - Developer Stories
date: 2012-11-17 22:05:34
---

Today we are going to set up Sublime Text 2 to manage our Gists. First, get the [Package Manager](http://wbond.net/sublime_packages/package_control "Sublime Package Control") if you haven't done so. Restart may be required.

Now, let's pop it up, go Cmd/Ctrl + Shift + P to fire it up (Cmd mac, control windows/unix), type "Install to add a new Package". Now type "Gist" and select the [Gist Package](https://github.com/condemil/Gist "Gist Package for Sublime Text 2")

[![](http://jjperezaguinaga.files.wordpress.com/2012/11/screen-shot-2012-11-17-at-1-53-46-pm.png "Screen Shot 2012-11-17 at 1.53.46 PM")](http://jjperezaguinaga.files.wordpress.com/2012/11/screen-shot-2012-11-17-at-1-53-46-pm.png)

Now, execute it for the first time with Cmd/Ctrl+K **plus** Cmd/Ctrl+O. The settings page will pop up. Set up username and password. Now, to get a token execute the following script (available [here](https://gist.github.com/4100532 "Gist Token Generate")).

    #!/bin/bash
    #Usage ./gistToken.sh USERNAME (don't forget to chmod+x it)
    #Inspired in http://www.lornajane.net/posts/2012/github-api-access-tokens-via-curl
    curl -v -u $1 -X POST https://api.github.com/authorizations --data "{\"scopes\":[\"gist\"]}"`</pre>
    Either copy it and run it in your term, gist download it, chmod+x it and run it, or if you trust me, run from your terminal:
    <pre>`curl -L https://raw.github.com/gist/4100532/1609337cc431e0139486c0df11408f68f07cd20f/gistToken.sh | bash -s USERNAME

Where "USERNAME" is your Github username. Your password will be then prompted by your terminal. From there you can copy the token retrieved and paste into the settings back in Sublime Text 2\. You are all set.