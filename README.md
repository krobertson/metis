Metis
=====

Metis is an implementation of the Nagios NRPE daemon in Ruby.  It provides an easy framework to write your own monitors in Ruby, have them running in a daemon, and distribute/share them with others.

Goals
-----

Metis is built around the idea of:

* **Monitors in Ruby**  
  Why? Ruby is a great language with a rich ecosystem of users, gems/libraries, and culture of testing.  The existing ecosystem of Nagios monitors has a lot of variance in what language they're in.  Some are bash, python, perl, etc.  That is an awesome strength, but also means less commonality.
* **Testable monitors**  
  We test our applications don't we?  Our monitors are what are supposed to be making sure our applications and servers are running correctly.  They should be tested too.  And they should be distributed with tests as well.  You're running a monitor from a 3rd party on all yours servers... do you have full confidence it was written well and is bug free?
* **Easy distribution of monitors**  
  Nagios has a great community and tons of available monitors for you to grab.  But grabbing monitors others have written can be hairy.  They can have varying dependencies such as modules from CPAN in Perl, or EasyInstall in Python.  If you don't know those languages, can be easily confused.  They have varying requirements, such as a check in python require v2.7 while your OS release only has v2.6.  Metis focuses on building in dependency handling and any framework to describe the configuration of the checks.
* **Easy deployment**  
  Metis works to cleanly separate monitor definition from configuration.  It utilizes a simple ruby DSL modeled after [Chef](http://www.opscode.com/chef/) for configuration of monitor parameters (username/passwords, warning/critical thresholds) as well as the monitor definition itself.  It also strives for easy integration with chef-server, so that the two can work hand-in-hand for self configuration.
* **Making monitors simple**  
  If you've ever written any of your own Nagios monitors, there can sometimes be a lot of setup.  Beyond just performing the check, you might also need to parse command-line parameters, remembering exit codes, and ensuring the proper messages get propagated.  Its wasted time and effort.  Metis provides a quick and simple way to define the output of your monitor and returns the most important parts.

Installation
------------

Installing Metis is a simple matter of running:

```
gem install metis
metis-server
```

Boom, you're up and ready... though you won't have any monitors defined.


Defining Monitors
-----------------

Monitors are defined as `define` blocks containing configuration attributes and an `execute` block that defines what to actually do.  The checks are defined in files under `checks/*.rb` from the working directory by default.

A simple monitor might be:

```ruby
define :simple do
  execute do
    "Hello World"
  end
end
```

You can set the result of the monitor using `critical()`, `warn()`, or `ok()`.  By default, Metis will assume the monitor is OK and if the `execute` block returns a string, set it as the message.

```ruby
define :eod do
  execute do
    warn("Getting close to the end of the day") if Time.now.hour >= 21
    critical("Real close now!") if Time.now.hour >= 23
    ok("We're all good")
  end
end
```

Monitors can define attributes that can be configured outside of the monitor logic itself using the `attribute` keyword.  They are then accessible within the monitor through a `params` hash.  For instance, to make a configurable warning/critical threshold:

```ruby
define :eod do
  attribute :warning,  :default => 21
  attribute :critical, :default => 23
  execute do
    warn("Getting close to the end of the day") if Time.now.hour >= params[:warning]
    critical("Real close now!") if Time.now.hour >= params[:critical]
    ok("We're all good")
  end
end
```

How to set these will be covered in the next section.

Monitors can also define external libraries or gems they might be dependent on using `require_gem`.  These will only be required when the monitor is triggered, return a critical result and message if not found, and soon be installed as a part of the deployment process.

```ruby
define :check_mysql do
  require_gem 'mysql'
  execute do
    # Connect to mysql and query it
  end
end
```

Configuring Monitors
--------------------

By default, Metis will look for a `config.rb` file in the working directory that should contain all the extra configuration settings for monitors.  Building on the `:eod` example from the last section, you could configure its alert thresholds using the `configure` block:

```ruby
configure :eod do
  warning  21
  critical 23
end
```

If you defined a more advanced monitor that required username/passwords to connect to a resource, you could include all of those:

```ruby
configure :check_mysql do
  username "foo"
  password "bar"
  port     3306
end
```

Testing Monitors
----------------

Helpers for writing tests against your monitors will be coming soon.


Contributing
------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Ken Robertson. See LICENSE for details.
