---
title: bash_script_skeleton.sh -- A bash script to write bash scripts
author: m.eik michalke
---

I like scripting things that reoccur. There's also a few standard things I want in almost all my scripts:

- use arguments
- just show a usage message when called without any arguments
- colored text
- maybe use a configuration file instead of hard coding variables

I experimented a lot to find solutions that I liked and that are also maintainable, e.g. when I want to change details, fix issues or learned something new. The result of this is `bash_script_skeleton.sh`, my personal tool to start writing new bash scripts. I released it here in the hope that others find it useful as well. It is still under active development, but I do take care to not introduce breaking changes (if only for my own sake).

That is something to take care of because `bash_script_skeleton.sh` doesn't just generate a new scripts's skeleton file, but also maintains a small library of bash functions that can be sourced by its generated scripts to provide standard features, like coloring text or writing/updating a configuration file. I call these files *dependencies* of my scripts, as they wouldn't run without them. Therefore, I try hard not to break these functions with updates. I sometimes add new features to them or improve their behavior, but I'd rather add an all new function than breaking an existing one.

This `README` explains how to use the script, its internal workflow and what it expects. It might take some time to understand how to use it, but it can then save a lot more time with each new script that you write based on one of its generated skeletons.

## Usage

My scripts are supposed not to cause harm when they are called without any arguments. That is, in order to actually do something, at least one additional argument must always be used. There's but one exception to this rule, and that is initializing configuration files, which we'll look at later.

Instead, when called without arguments, both `bash_script_skeleton.sh` as well as generated scripts show a usage/help message. It usually lists all available arguments with a short description, including some default flags:

- `--version` shows the version number of the script
- `--dependencies` lists all of the dependency files that are sourced by the script (and are maintained by `bash_script_skeleton.sh`)
- `--edit` opens the script file itself for editing
- `--config` opens the configuration file for the script for editing (if it uses one)

If the script uses a configuration file, the path to it is also shown. In the case of `--edit` and `--config`, files will be opened using the editors that are defined by the environment variables `VISUAL` or `EDITOR` (in that order). Set them in your `.bashrc` to control this.

### Typical usage

Typically, when I want to write a new script, I initialize it like this:

```bash
bash_script_skeleton.sh -n <name of script>.sh -C -L GPLv3 -k
```

The `-n` argument takes the name of the script without the path. I usually put all of my scripts in the same directory, so the default path is set in the configuration file, it can be overruled with `-p` if desired. You can also have the script written to one directory (e.g., a private cloud share) and have a symlink to `~/bin` created via `-l`.

The `-C` arguments adds some stuff to the script skeleton to enable the use of a configuration file. The default path for those is also pre-configured and can be overruled with `-d`. The config file is named `<name of script>.conf` unless changed via `-c`.

If I intend to share or release the script, I ususally already add a license info by using `-L`. By default only GPLv3 is configured, but you can add all your preferred license headers in the configuration.

Finally, `-k` opens the new script in the configured editor. A script that was initialized this way will already »work« in the sense that you can call it and it will show an example usage message.


## Configuration files

When first called, `bash_script_skeleton.sh` will automatically initialize its own configuration file. It defines a number of variables that are used by the script already in the usage message, so they must be available even if you just want to see the message. So if you no longer want to use this script and purge its files, you'll also need to remove the config file manually. Its path is always shown at the end of the usage message, by default `bash_script_skeleton.sh`  puts all config files (also for genrated scripts) below `~/.config/bash_scripts_${USER}/`.

In newly generated scripts, the section dealing with configuration files is present but commented out. You have to uncomment the block starting with `## poor man's configuration` first in order to actually use it. This is to prevent initializing a configuration file with example variables you will never use.

After ensuring the target directory exists, the configuration is maintained by one of the helper functions called `appendconfig`. It usually takes four values:

- the path to the config file
- the variable name to set
- the default value of the variable
- a keyword to control its behavior, `"autoconfig"` is a good choice ;)

For example, if you need a configurable variable named `TARGET_DIR` with the default value `"/tmp"` in quotes, here you would add:

```bash
appendconfig "${CONFIGFILE}" "TARGET_DIR" "\"/tmp\"" "autoconfig"
```

The `appendconfig` function will search `${CONFIGFILE}` for the variable each time the script is called, and if no such variable can be found, it will be appended to the config file with the script's default value. Existing variables will not be touched. Since `appendconfig` ensures the availability of all variables the script defines, it is simple to add new variables to your configuration with updated versions of your script.

Of course you can still define variables directly in the script. But if you plan on using a script on different machines and, e.g., paths are not the same, it is much more flexible to define this in a separate file.

If you look at the config file for `bash_script_skeleton.sh`, specifically the variables dealing with the license info, you can see that using arrays is also an option you might consider. For instance, if you would like to define various profiles for a script, you could do this using arrays.

All scripts that use this configuration feature do that in three steps:

1. create the config directory if it doesn't exist
2. check for all variables and append defaults if they are missing, thereby initializing the configuration file if missing as well
3. source the configuration file to make all variables available in the scope of the script

## Dependencies: Helpful bash functions

About 2/3 of `bash_script_skeleton.sh` is function definitions, and each of these functions is written to a separate file when initialized by calling `bash_script_skeleton.sh -I`. These function files use a simple version control feature, in the sense that they will be replaced with a newer version if an updated `bash_script_skeleton.sh` provides it and is called with `-I`. You can actually source these files in `bash` and call them with the `--version` flag to see which version of that particular function your scripts are currently using (with the exception of all the text color/layout functions that are part of `colors_basic.sh` and don't have individual version numbers).

You can find these files in the directory `~/.config/bash_scripts_${USER}/shared/`.

### Text colors and layout

The library `colors_basic.sh` defines some basic colors and short functions to color text. These functions all begin with an undersccore folowed by the color or layout (e.g., bold, italic, underscored). You will most likely use them with `echo -e`. This example prints text in blue letters:

```bash
echo -e "$(_blue "This is an example")"
```

There are other color functions available, like `_green`, `_orange`, or `_purple`, and they are documented in every initiated script file. You will notice there's also functions like `_bold`, `_italic`, or `_underline`, that don't change the color of text. These are also already included in all color functions, abbreviated by their initial letter which can be given as a second argument. That is, to get text in red that is also bold and underlined, you would call:

```bash
echo -e "$(_red "This is another example" bu)"
```

These global color definitions are also used in many of the other functions, so it should always be sourced as soon as *any* other of he library files is sourced.

### Errors, warnings and successes

You might want to include some checks in your script and stop it with an informative error message if they fail, or show success if something went as expected. For that there's `error`, `warning` and `alldone`. The first two print a custom message with either a red »error:« or orange »warning:« prefix, and in case of an error the script will also exit with status code 1.

`alldone` doesn't take messages but prints a single space and a green check mark. I often use this in combination with a previous `echo -n` call explaining what will be tried next. The `-n` suppresses a newline, so a following `alldone` puts the checkmark directly after the message:

```bash
echo -n "Trying something..."
if false ; then
    error "There was an error!"
fi
alldone
```

These functions are very simple, but they encourage me to write more verbose scripts that show me what they're up to in a way that doesn't surprise me. adding `|| error "..."` after a call to other tools immediately stops a script in case of an error, otherwise it might keep running and break things. A shorter way of achieving this:

```bash
call_something \
    && alldone \
    || error "There was an error!"
```


### Usage messages

Like said, all scripts come with a usage message. I like that one structured and colored as well, it's nice to read and easier to find what you are looking for. So I wrote a `usage` function that over time became quite versatile. Depending on what section of the usage message you want to write, it produces a different layout. It will usually start printing from the start of a line with a defined indentation, to make sure that all scripts' usage messages have a very similar appearance to also improve their comprehensability.

An initiated script will already include an example usage message for you to study and adjust. In general, it is combined by multiple calls to `usage`, each with a definition of the section type as its second argument, and then one or more arguments (depending on the section type), i.e., the text you want to be shown.

For instance, to document the argument `-e` with the explanation `show an example`, you would add:

```bash
echo -e "
    $(usage opt "-e" "" "show an example")
"
```

Notice the empty string in the middle? That is because the `opt` section is also used to document flags that take a value, but `-e` doesn't. `usage` will try to properly align the columns. Other implemented sections include

- `usage` to show the initial usage statement (you can probably leave that as is, it will use the file name by default),
- `section` to add section headlines,
- `default` to show the default values if a flag is not used (e.g., the value of a variable from the config file), or
- `par` to document flag values that act like a sub-flag parameter.

There's also a `config` section that prints the `--config`, `--edit`, and `--dependencies` messages, as well as the path to the config file.

The `usage` function really is more of a »what you see is what you mean« thing, as it will apply its layout definitions to the text you provide, depending on the section argument.


### Other functions

We won't be covering all of the functions in detail here, as they all have their own usage message as a way of self-documentation. Other functions include:

- `mkmissingdir` to check if a directory exists and create it if not
- `yesno` to ask a simple yes/no question and return the value
- `check_tool` to check for the availability of a third party tool your script uses, so you can stop before it tries to use it and fail
- `path_exists` to check for the existence of files or directories and show the result (red X if missing, green checkmark if found, optional orange X if missing but your script will create it if needed)
- `skip` to indicate if your script is skipping something
- `write_new_file` to write content to a file with control for its previous existence
- `edit_file` to open files for editing
- `function_body` to print the content of a bash function, e.g. to write your own functions and add them to the function library for use in other scripts


### Activating these functions in your scripts

You will probably not use all of these functions in every script, so not all of them are being sourced by default. All main parts of an intialized new script are marked as a block between comments like `### BEGIN ${SOMETHING} ###` and `### END ${SOMETHING} ###`. In the case of these functions, the block begins with `### BEGIN DEPENDENCY SECTION ###` which declares all functions to be used in this script as an array named `DEPENDENCIES`.

By toggling the comment status of each script file you can include or exclude a particular file from being sourced. I would recommend to always keep the basic colors and feedback functions like `error`.


## Turning your script into a static file

In case you want to share your script with others and do not expect them to have access to `bash_script_skeleton.sh`, you can also replace the array of dependencies with the function bodies themselves. That is, the script will not source external files to define its internal functions, but provide the function code itself. It will therefore run out-of-the-box.

The obvious downside of this is that your script will grow significantly, and you will have to take care of functions updates in each script manually. But of course you can keep the dynamically linked original, use that for development, and export a new static version for publication.

To do so, use the script `bash_script_static_dependencies.sh` from this repo. Call it without arguments to get its usage info, it should be self-explanatory and straight forward to use.


## Contributing

To ask for help, report bugs, suggest feature improvements, or discuss the global
development of the scripts, please contact me at <meik.michalke@hhu.de>.


### Branches

Please note that all development happens in the `develop` branch. Pull requests against the `master`
branch will be rejected, as it is reserved for the current stable release.


## Licence

Copyright 2023 Meik Michalke <meik.michalke@hhu.de>

These scripts are free software: you can redistribute them and/or modify
them under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

These scripts are distributed in the hope that they will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with these scripts.  If not, see <https://www.gnu.org/licenses/>.
