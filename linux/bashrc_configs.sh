alias l='ls -la --color=auto'

# configure git branch to be displayed in prompt line:
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\A \u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

\a Alarm (Bell)
\d Date in fomat "Wed Jun 21"
\h Hostname
\j Jobs (Number of Background jobs)
\l Current Terminal Name
\n Newline inserted into prompt. (Usefull for 2-line prompts)
\r Carriage return in prompt
\s Current Shell
\t Time in 24 hour format, 16:25:00
\T Time in 12 hour format, 04:25:00
\u User's account name
\v Version and release of bash
\w Current working directory (full path /home/bill/.mozilla)
\W Last element of Working directory (.mozilla)
\V Version, release and patch level of bash
\\ single backslash inserted into prompt
\! Number of current command in command history
\# Number of current command where numbers start at 1 when shell starts
\A Time in 24 hour format without seconds 16:25
\@ Time in 12 hour format without seconds, 04:25 p.m.
\$ indicates root. display $ when not root and # when root. 
\[ starts a sequence of non printing characters ending with \] (explanation to follow)
\nnn the character in ascii set coresponding to the octal number nnn
