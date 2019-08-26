# VulnFindr

- [VulnFindr](#gehl)
  - [Setup](#setup)
    - [Requirements](#requirements)
    - [Configuration](#configuration)
    - [First Run](#first-run)
  - [Included tooling](#included-tooling)
    - [JS Toolchain](#js-toolchain)
    - [Tests](#tests)
    - [Deployment](#deployment)
    - [Heroku](#heroku)
  - [Appendix](#appendix)
    - [Conventions](#conventions)
    - [Setting up Ruby](#setting-up-ruby)
    - [Setting up Node JS](#setting-up-node-js)
    - [Setting up PostgreSQL](#setting-up-postgresql)
      - [MacOS](#macos)
      - [Linux](#linux)
    - [Setting up chromedriver](#setting-up-chromedriver)
      - [MacOS](#macos-1)
      - [Arch Linux:](#arch-linux)

## Setup

See the conventions appendix for an explanation of some of the notation used in
these instructions.

### Requirements

You must have the following installed and available on your machine:

- **Ruby 2.6.3**
- **Node JS 12.x**
- **PostgreSQL 11.x**
- **chromedriver** and **Google Chrome**

Instructions for setting up each of the above are included in the [appendix](#appendix)
section.

### Configuration

There are two main configuration files that are of concern:

- `.env` - configuration that's common across all environments that you intend
  to run on your machine (e.g. database connection)
- `.env.development` - configuration that's specific to the development
  environment that you intend to run on your machine (e.g. API credentials)

There exists a `.env.test` which is checked in to source control, used to
configure the test equivalents for whatever is in `.env.development`. As tests
will be written such that they don't make any calls to external services, **it
should not contain any real credentials.** Instead, use dummy credentials and
stub any external calls using the test suite's features.

Setting up the configuration is a matter of copying the supplied examples and
filling in the gaps, as follows:

```sh
$ cp .env.example .env
# edit .env with username and password

$ cp .env.development.example .env.development
# edit .env.development with username and password
```


### First Run

Install the Ruby and JS dependencies

```sh
$ npm install -g yarn
$ bundle install
$ yarn install
```

Prepare the database

```sh
$ rails db:setup
```

Run the test suite

```sh
$ rspec spec
```

Start a development server and check out the app in a browser

```sh
$ heroku local
```

## Included tooling

### JS Toolchain

The more complicated front end components are built using the
JS stack included in newer Rails versions, built around Webpack
rather than sprockets.

This mainly refers to the map based interfaces that are used in
the app. You can find the source for these in `app/javascripts`

### Tests

For testing the ruby parts of the app, the suite is built using
the usual RSpec tooling. Test files are located in `spec/**/*.rb`

For JS unit testing, Jest is included. Test files are located
in `spec/javascripts/**/*.js`

Integration testing is done using Capybara and the chrome
webdriver. Integration tests are located in
`spec/features/**/*.rb`

To run the ruby unit tests and integration tests, use `bundle exec rspec`

To run the JS unit tests, use `yarn exec jest`

### Deployment

Using Heroku review apps and CI. Auto merge setup to staging environment on merging of branches into master.

Remote (App)
Staging https://git.heroku.com/vulnfinder-staging-eu.git (https://vulnfindr-staging-eu.herokuapp.com/)

### Heroku

Dynos - EU location, Heroku-18 stack
Postgres - Hobby Dev $7 in staging and Standard $50 in production

## Appendix

### Conventions

This document and other documentation in this project may use the following
conventions:

**`$`** is used to denote commands that are executed in your shell
(zsh/fish/bash etc.)

**`>`** is used to denote commands that are executed in a REPL or other
interactive tool (e.g. ruby console, psql session.)

**`#`** is used to annotate the instructions or describe what the reader will
see when the instructions are followed. It doesn't hold any functional
significance.

For example:

```sh
$ bundle exec irb
> puts "foo"
# you'll see ruby repeat "foo" back to you
> exit

$ psql -h localhost
> select * from table;
```

Context will often indicate what the `>` prompt represents, but it may be
represented in unambiguous ways such as:

```sh
$ bundle exec irb
(irb)> puts "foo"
# you'll see ruby repeat "foo" back to you
(irb)> exit

$ psql -h localhost
(psql)> SELECT * FROM table;
```

### Setting up Ruby

A platform-independent tool [asdf](https://github.com/asdf-vm/asdf) is useful
for managing Rubies on development machines.

Follow the [installation instructions for
asdf](https://asdf-vm.com/#/core-manage-asdf-vm), and then install the Ruby
plugin and Ruby 2.6.3 as below

```sh
$ asdf plugin-add ruby

$ asdf install ruby 2.6.3

$ asdf local ruby 2.6.3

$ ruby -v
# You should see a string like "ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]"
```

### Setting up Node JS

Once again, [asdf](https://github.com/asdf-vm/asdf) is useful for managing Node
JS versions on development machines.

Follow the [installation instructions for
asdf](https://asdf-vm.com/#/core-manage-asdf-vm), and then install the Node JS
plugin and Node JS 12.2.0 as below

```sh
$ asdf plugin-add nodejs

$ bash $ASDF_DIR/plugins/nodejs/bin/import-release-team-keyring

$ asdf install nodejs 12.2.0

$ asdf local nodejs 12.2.0

$ node -v
# You should see "v12.2.0" printed
```

### Setting up PostgreSQL

#### MacOS

```sh
$ brew install postgresql
$ brew services start postgresql
```

#### Linux

It's possible to use your distro's package to run a PostgreSQL server, however
it may be difficult to get the correct version.

Alternatively, you can start one using Docker:

Ensure you have your distribution's packages installed and service started
(consult the [Docker documentation](https://docs.docker.com/))

```sh
$ docker create \
  --env POSTGRES_USER=$USER \
  --name postgres \
  --network host \
  postgres:11.x

$ docker start postgres
# You should now have a server available and the ability to access it.

$ psql -h localhost
# If it was set up correctly, you should now have a psql shell.
# You can connect using the same username as your login one, with no password.
# Try running some SQL commands:

(psql)> SELECT NOW();
```

### Setting up chromedriver

Install your system's package for `chromedriver`

#### MacOS

`brew cask install chromedriver`

#### Arch Linux:

Install `chromedriver` from the AUR
