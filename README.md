
# Description

tspawn.sh is a basic helper script intended to simplify spawning of tmux
sessions based on static config files.  Think of it as an even simpler
version of tmuxinator with no Ruby/YAML dependencies.  Much of what this
helper script does can be achieved with an even simpler bash script,
but the methods necessary to name panes as they're created was inelegant
and unwieldy.  This helps to resolve that while also making configuration
of new sessions less painful and more concise.

Tspawn expects a corresponding XML file matching the argument passed, then
extracts window names, pane names, layout preferences, and commands
accordingly.  From there, it should spawn the necessary tmux session of
the same name, spawn expected windows and panes, and pass commands.

At present, the one thing I didn't include that is relatively easy to do
with a raw bash script was manually pre-designate percentages and split
directions of panes.  I could code tspawn to do it, but I'd already gotten
into the habit with my bash script equivalents of just spawning panes at
arbitrary default percentages and then invoking a "tmux set-layout" command
per window after each one was done, so the added complexity to make it
happen didn't feel justified.  I may revisit that another time, though.

# Prereqs

- bash
- tmux
- xmllint (usually included in your distro's xmllib2 package)
- xmlstarlet with xpath support

# Requirements

By default, tspawn.sh expects to live in ~/.config/tspawn/, but you can
tailor it easily to an alternative location of your choosing by changing the
value of BASE.  An XML file of the same name as the first argument passed to
the script (sans the .xml extension) is likewise expected.

DTD validation is performed against the matching XML file prior to session
creation to insure its contents are in proper order and all needed values
are present.  

# Installation

1. Clone into your ~/.config/ dir
2. > cd ~/.config/tspawn/doc
3. > cp example.xml ../cfg/sometmuxsessionname.xml
2. Tailor sometmuxsessionname.xml to your needs
3. Add a sometmuxsessionname alias to your shell's rc
4. ???
5. Profit

# Example Usage

```bash
> ~/.config/tspawn/tspawn.sh admin
```

  Or:

```bash
> cat 'alias admin="~/.config/tspawn/tspawn.sh admin"' >> ~/.zsh/aliases
> cat 'alias dev="~/.config/tspawn/tspawn.sh dev"' >> ~/.zsh/aliases
> . ~/.zshrc

> admin
> dev
```
