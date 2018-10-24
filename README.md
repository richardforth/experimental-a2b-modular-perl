# experimental-a2b-modular-perl
An experimental attempt at modularizing the ~3000 line behemoth into bite sized modules


# Note

Because this is going to be a project consisting of many smaller files, on just one big one, this project wont work with teh curl and perl method of executing the original apache2buddy.pl script, so you'll need to git clone this one before executing it.

# The plan
```
main_script.pl // not decided on a name for it yet, probably apache2buddy.pl
/modules (folder)
/modules/Rpm.pm
/modules/Deb.pm
/modules/Preflight.pm
/modules/Rootcheck.pm
etc....
```

The idea being that  the main script is much smaller and just contains the overall workflow and logic whereas the meat of each function will be in its own module file.

# Pro's

Projects that are modular are easier to work with and unit test - you can only break one module not the entire project with a missing curly brace. Simpler to bugfix, and less code to trawl through

# Con's

Can't curl and perl one big script, need to download and install entire project with git clone before use.

# Caveats

This is highly experimental - the end goal is not to replace apache2buddy - but to discover what can be done by modularising such a big project. It opens the door to true code-reuseability. If you like a particular function - you can steal its .pm file for a project rather than cutting out code from a 3000 liine behemoth and then having to rewrite it becuse it relied on something else etc. Each perl module (.pm file) should be self contained.
