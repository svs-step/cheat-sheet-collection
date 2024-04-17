  

## Bash Profile

  

- bash - `.bashrc`

- zsh - `.zshrc`

  

```bash

# Always run ls after cd

function cd {

builtin cd "$@" && ls

}

  

# Prompt user before overwriting any files

alias cp='cp --interactive'

alias mv='mv --interactive'

alias rm='rm --interactive'

  

# Always show disk usage in a human readable format

alias df='df -h'

alias du='du -h'

```

  

## Bash Script

  

### Variables

  

```bash

#!/bin/bash

  

foo=123 # Initialize variable foo with 123

declare -i foo=123 # Initialize an integer foo with 123

declare -r foo=123 # Initialize readonly variable foo with 123

echo $foo # Print variable foo

echo ${foo}_'bar' # Print variable foo followed by _bar

echo ${foo:-'default'} # Print variable foo if it exists otherwise print default

  

export foo # Make foo available to child processes

unset foo # Make foo unavailable to child processes

```

  

### Environment Variables

  

```bash

#!/bin/bash

  

env # List all environment variables

echo $PATH # Print PATH environment variable

export FOO=Bar # Set an environment variable

```

  

### Functions

  

```bash

#!/bin/bash

  

greet() {

local world = "World"

echo "$1 $world"

return "$1 $world"

}

greet "Hello"

greeting=$(greet "Hello")

```

  

### Exit Codes

  

```bash

#!/bin/bash

  

exit 0 # Exit the script successfully

exit 1 # Exit the script unsuccessfully

echo $? # Print the last exit code

```

  

### Conditional Statements

  

#### Boolean Operators

  

- `$foo` - Is true

- `!$foo` - Is false

  

#### Numeric Operators

  

- `-eq` - Equals

- `-ne` - Not equals

- `-gt` - Greater than

- `-ge` - Greater than or equal to

- `-lt` - Less than

- `-le` - Less than or equal to

- `-e` foo.txt - Check file exists

- `-z` foo - Check if variable exists

  

#### String Operators

  

- `=` - Equals

- `==` - Equals

- `-z` - Is null

- `-n` - Is not null

- `<` - Is less than in ASCII alphabetical order

- `>` - Is greater than in ASCII alphabetical order

  

#### If Statements

  

```bash

#!/bin/bash

  

if [[$foo = 'bar']]; then

echo 'one'

elif [[$foo = 'bar']] || [[$foo = 'baz']]; then

echo 'two'

elif [[$foo = 'ban']] && [[$USER = 'bat']]; then

echo 'three'

else

echo 'four'

fi

```

  

#### Inline If Statements

  

```bash

#!/bin/bash

  

[[ $USER = 'rehan' ]] && echo 'yes' || echo 'no'

```

  

#### While Loops

  

```bash

#!/bin/bash

  

declare -i counter

counter=10

while [$counter -gt 2]; do

echo The counter is $counter

counter=counter-1

done

```

  

#### For Loops

  

```bash

#!/bin/bash

  

for i in {0..10..2}

do

echo "Index: $i"

done

  

for filename in file1 file2 file3

do

echo "Content: " >> $filename

done

  

for filename in *;

do

echo "Content: " >> $filename

done

```

  

#### Case Statements

  

```bash

#!/bin/bash

  

echo "What's the weather like tomorrow?"

read weather

  

case $weather in

sunny | warm ) echo "Nice weather: " $weather

;;

cloudy | cool ) echo "Not bad weather: " $weather

;;

rainy | cold ) echo "Terrible weather: " $weather

;;

* ) echo "Don't understand"

;;

esac

```