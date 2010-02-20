Bling
=====

I think Bundler is going to do a lot for gem management, but right now 
there are enough gem problems with it that I'd like to avoid it while 
playing with other Rails projects. As such, I've written this easy peasy
gem manager that will:

* Let you group gem dependencies by RAILS_ENV (see YAML below)
* Show you what gems are needed for a given RAILS_ENV (rake bling:show)
* Try to install those gems (bling install)

Installation
------------

You'll need to install the bling gem, and then from your Rails root
directory, just type `bling init`. There's one manual step you have to take,
and then you get to fill out your bling.yml to explain your gem dependencies.

Once you have your yaml filled out, you can type `bling install` and it
should install the gems you need.

YAML
----

When you run bling, you'll get a stock YAML file in your config directory
that just has the Rails gem (currently 3.0.0.beta). If you want to add
more gems, just add them either to the all section (meaning they will be
required for every environment), or to a specifically named section, like
test or production or development. Gems not listed in the all section will
only be included if RAILS_ENV matches.

Supported entries for gems are: name (gem name), version (allows ><~=), and
lib (in case you're not meant to require the gem name).
