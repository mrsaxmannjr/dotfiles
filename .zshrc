# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jamesmann/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="miloshadzic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ALIASES

# Open in Vscode
alias c="code ."

# Git Aliases
alias ga="git add -A"
alias gs="git status"
alias gc="git commit -m"
alias master="git push origin master"
alias gr="git reset"
alias all="ls -a"

# Directory
alias gschool="cd ~/Desktop/gschool"
alias resident="cd ~/Desktop/gResident"
alias projects="cd ~/Desktop/Projects"
alias lutz="cd ~/Desktop/LUTz/"
alias bos="cd ~/Desktop/wesBoss"
alias capstone="cd ~/Desktop/gschool/CapSTONE"
alias root="cd ~"
alias desk="cd ~/Desktop"
alias downloads="cd ~/Downloads/"
alias gdrive="cd ~/Google\ Drive/"

# Functions

# git add -A into git status
function add {
  git add -A
  git status
}

# git commit into messsage quotes
function commit {
  git commit -m "$*"
}

#open eslintrc file
function linter {
  cd ~
  code .eslintrc
}

#open zshrc file
function zsh {
  cd ~
  code .zshrc
}

# create boilerplate Database and Server
function createdbfilestructure {
  take $1
  touch app.js
  touch database-connection.js
  touch queries.js
  npm init
  npm install --save express cors body-parser pg knex
  knex init
  echo 'const express = require("express");
        const cors = require("cors");
        const bodyParser = require("body-parser");
        const app = express();
        const queries = require("./queries");

        app.use(cors());
        app.use(bodyParser.json());

        app.get("/", (request, response) => {
          queries
            .list()
            .then(test => {
              response.json({ test });
            })
            .catch(console.error);
        });

        app.post("/", (req, res) => {
          res.json("POST worked!");
        });

        app.listen(process.env.PORT || 3000);' >> app.js
  echo 'const CONFIG = require("./knexfile")[process.env.NODE_ENV || "development"];
        module.exports = require("knex")(CONFIG);' >> database-connection.js
  echo 'module.exports = {
        development: {
          client: "pg",
          connection: "postgres:///testdb"
        },

        production: {
          client: "pg",
          connection: process.env.DATABASE_URL
        }
      };' > knexfile.js
  echo 'const database = require("./database-connection");

      module.exports = {
        list() {
          return database("test").select();
        },
        read(id) {
          return database("test")
            .select()
            .where("id", id)
            .first();
        },
        create(resolution) {
          return database("test")
            .insert(resolution)
            .returning("*")
            .then(record => record[0]);
        },
        update(id, resolution) {
          return database("test")
            .update(resolution)
            .where("id", id)
            .returning("*")
            .then(record => record);
        },
        delete(id) {
          return database("test")
            .delete()
            .where("id", id);
        }
    };' >> queries.js
  knex migrate:make $1db
  knex seed:make 01_$1
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

