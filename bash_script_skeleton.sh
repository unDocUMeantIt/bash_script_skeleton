#!/usr/bin/env bash
#
# Copyright 2016-2023 Meik Michalke <meik.michalke@hhu.de>
#
# bash_script_skeleton.sh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bash_script_skeleton.sh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bash_script_skeleton.sh.  If not, see <http://www.gnu.org/licenses/>.

SCRIPT_VERSION="2023-06-25"
[[ "$1" =~ (--version) ]] && { 
  echo "${SCRIPT_VERSION}";
  exit 0
};

WITHCONFIG=false
WITHLICENSE=false
HAVENAME=false
HAVECONFIGNAME=false
LINKSCRIPT=false
EDITSCRIPT=false
INITSHARED=false
CSSVERSIONINFO=false

colors_basic () {
  [[ "$1" =~ ^(-h|--help)$ ]] && {
    echo "defines some basic colors and functions for text formatting
    
    usage: colors_basic

    use --colors to get a list of functions defined with colors_basic.sh.
    "
    return;
  }
  [[ "$1" =~ ^(-c|--colors)$ ]] && {
    echo "_bifulnc
_biulnc (deprecated)

_dgray (+bifulnc)
_lgray (+bifulnc)
_lred (+bifulnc)
_red (+bifulnc)
_lblue (+bifulnc)
_blue (+bifulnc)
_green (+bifulnc)
_lpurple (+bifulnc)
_purple (+bifulnc)
_black (+bifulnc)
_brown (+bifulnc)
_yellow (+bifulnc)
_orange (+bifulnc)
_cyan (+bifulnc)
_lcyan (+bifulnc)
_white (+bifulnc)
_green_on_grey (+bifulnc)
_orange_on_grey (+bifulnc)
_bg_red (+bifulnc)
_bg_green (+bifulnc)

_bold
_italic
_faint
_underscore
_blink
_inverse
_concealed (invisible)

_opt (+ifulnc; for option parameter names)
_arg (+bfulnc; for option arguments)
_path (+bifulnc; for path names)
_info (+bifulnc; for general info, e.g., configuration files)
_linfo (+bifulnc; for further infos to options, e.g., defaults)"
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "13"
    return;
  }
  TXT_DGRAY="\e[90m"
  TXT_LGRAY="\e[38;5;248m"
  TXT_LRED="\e[91m"
  TXT_RED="\e[31m"
  TXT_LBLUE="\e[94m"
  TXT_BLUE="\e[34m"
  TXT_LGREEN="\e[92m"
  TXT_GREEN="\e[32m"
  TXT_LPURPLE="\e[95m"
  TXT_PURPLE="\e[35m"
  TXT_BLACK="\e[30m"
  TXT_BROWN="\e[33m"
  TXT_YELLOW="\e[93m"
  TXT_ORANGE="\e[38;5;202m"
  TXT_CYAN="\e[36m"
  TXT_LCYAN="\e[96m"
  TXT_WHITE="\e[97m"
  TXT_BOLD="\e[1m"
  TXT_ITALIC="\e[3m"
  TXT_FAINT="\e[2m"
  TXT_UNDERSCORE="\e[4m"
  TXT_BLINK="\e[5m" ## only use with caution!
  TXT_INVERSE="\e[7m"
  TXT_CONCEALED="\e[8m"
  # examples for bachground colors (+10)
  TXT_BG_RED="\e[41m"
  TXT_BG_GREEN="\e[42m"
  # 48;5 for background, 38;5 for foreground, colors see ~/.post_install/bash/color_codes.png
  TXT_ORANGE_ON_GREY="\e[48;5;240;38;5;202m"
  TXT_GREEN_ON_GREY="\e[48;5;240;38;5;040m"
  OFF="\e[0m"
}

# call function here to locally define variables
colors_basic

_bifulnc () {
  # empty call turned off here
  [[ "$1" =~ ^(-h|--help)$ ]] && {
        echo -e "activates ${TXT_BOLD}bold${OFF}, ${TXT_ITALIC}italics${OFF}, ${TXT_FAINT}faint${OFF}, ${TXT_UNDERSCORE}underscore${OFF}, ${TXT_BLINK}blink${OFF}, ${TXT_INVERSE}inverse${OFF}, or concealed (invisible),
if the letters b, i, f, u, l, n and/or c are given.
you shouldn't use this as a standalone function but inside color setting functions.

  usage: _bifulnc \"[b|i|f|u|l|n|c]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  local CODE=""
  [[ "$1" =~ "b" ]] && CODE="${CODE}${TXT_BOLD}"
  [[ "$1" =~ "i" ]] && CODE="${CODE}${TXT_ITALIC}"
  [[ "$1" =~ "f" ]] && CODE="${CODE}${TXT_FAINT}"
  [[ "$1" =~ "u" ]] && CODE="${CODE}${TXT_UNDERSCORE}"
  [[ "$1" =~ "l" ]] && CODE="${CODE}${TXT_BLINK}"
  [[ "$1" =~ "n" ]] && CODE="${CODE}${TXT_INVERSE}"
  [[ "$1" =~ "c" ]] && CODE="${CODE}${TXT_CONCEALED}"
  echo -e "${CODE}"
}
_biulnc ()
{
    # deprecated, for backwards compatibility only
    _bifulnc $1
}
_dgray () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_DGRAY}[message]${OFF} in dark gray color

  usage: _dgray \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_DGRAY}$(_bifulnc $2)$1${OFF}"
}
_lgray () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_LGRAY}[message]${OFF} in light gray color

  usage: _lgray \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LGRAY}$(_bifulnc $2)$1${OFF}"
}
_lred () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_LRED}[message]${OFF} in light red color

  usage: _lred \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LRED}$(_bifulnc $2)$1${OFF}"
}
_red () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_RED}[message]${OFF} in red color

  usage: _red \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_RED}$(_bifulnc $2)$1${OFF}"
}
_lblue () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_LBLUE}[message]${OFF} in light blue color

  usage: _lblue \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LBLUE}$(_bifulnc $2)$1${OFF}"
}
_blue () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BLUE}[message]${OFF} in blue color

  usage: _blue \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BLUE}$(_bifulnc $2)$1${OFF}"
}
_lgreen () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_LGREEN}[message]${OFF} in light green color

  usage: _lgreen \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LGREEN}$(_bifulnc $2)$1${OFF}"
}
_green () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_GREEN}[message]${OFF} in green color

  usage: _green \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_GREEN}$(_bifulnc $2)$1${OFF}"
}
_lpurple () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_LPURPLE}[message]${OFF} in light purple color

  usage: _lpurple \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LPURPLE}$(_bifulnc $2)$1${OFF}"
}
_purple () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_PURPLE}[message]${OFF} in purple color

  usage: _purple \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_PURPLE}$(_bifulnc $2)$1${OFF}"
}
_black () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BLACK}[message]${OFF} in black color

  usage: _black \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BLACK}$(_bifulnc $2)$1${OFF}"
}
_brown () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BROWN}[message]${OFF} in brown color

  usage: _brown \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BROWN}$(_bifulnc $2)$1${OFF}"
}
_yellow () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_YELLOW}[message]${OFF} in yellow color

  usage: _yellow \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_YELLOW}$(_bifulnc $2)$1${OFF}"
}
_orange () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_ORANGE}[message]${OFF} in orange color

  usage: _orange \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_ORANGE}$(_bifulnc $2)$1${OFF}"
}
_cyan () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_CYAN}[message]${OFF} in cyan color

  usage: _cyan \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_CYAN}$(_bifulnc $2)$1${OFF}"
}
_lcyan () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_LCYAN}[message]${OFF} in light cyan color

  usage: _lcyan \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LCYAN}$(_bifulnc $2)$1${OFF}"
}
_white () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_WHITE}[message]${OFF} in white color

  usage: _white \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_WHITE}$(_bifulnc $2)$1${OFF}"
}
_green_on_grey () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_GREEN_ON_GREY}[message]${OFF} in green on grey color

  usage: _green_on_grey \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_GREEN_ON_GREY}$(_bifulnc $2)$1${OFF}"
}
_orange_on_grey () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_ORANGE_ON_GREY}[message]${OFF} in orange on grey color

  usage: _orange_on_grey \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_ORANGE_ON_GREY}$(_bifulnc $2)$1${OFF}"
}
_bg_red () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BG_RED}[message]${OFF} with red background color

  usage: _bg_red \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BG_RED}$(_bifulnc $2)$1${OFF}"
}
_bg_green () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BG_GREEN}[message]${OFF} with green background color

  usage: _bg_green \"[message]\" (bifulnc)

  [message]: the message to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BG_GREEN}$(_bifulnc $2)$1${OFF}"
}
_bold () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BOLD}[message]${OFF} bold

  usage: _bold \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BOLD}$1${OFF}"
}
_italic () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_ITALIC}[message]${OFF} in italics

  usage: _italic \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_ITALIC}$1${OFF}"
}
_faint () {
  [[ "$1" == "" ]] && {
    echo -e "prints faint ${TXT_FAINT}[message]${OFF}

  usage: _faint \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_FAINT}$1${OFF}"
}
_underscore () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_UNDERSCORE}[message]${OFF} underscored

  usage: _underscore \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_UNDERSCORE}$1${OFF}"
}
_blink () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_BLINK}[message]${OFF} blinking, only use with caution!

  usage: _blink \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BLINK}$1${OFF}"
}
_inverse () {
  [[ "$1" == "" ]] && {
    echo -e "prints ${TXT_INVERSE}[message]${OFF} inversed

  usage: _inverse \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_INVERSE}$1${OFF}"
}
_concealed () {
  [[ "$1" == "" ]] && {
    echo -e "prints [message] concealed (invisible)

  usage: _concealed \"[message]\""
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_CONCEALED}$1${OFF}"
}
_opt () {
  [[ "$1" == "" ]] && {
    echo -e "prints an ${TXT_BOLD}[-o]${OFF} option

  usage: _opt \"[-o]\" (ifulnc)

  [-o]:      the option to print
  (iulnc):  add \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible)); \"b\" ($(_bold "bold")) is active by default
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BOLD}$(_bifulnc $2)$1${OFF}"
}
_arg () {
  [[ "$1" == "" ]] && {
    echo -e "prints an ${TXT_RED}${TXT_ITALIC}[<arg>]${OFF} option argument

  usage: _arg \"[<arg>]\" (bfulnc)

  [<arg>]:   the option argument to print
  (bulnc):  add \"b\" ($(_bold "bold")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible)); \"i\" ($(_italic "italic")) is active by default
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_RED}${TXT_ITALIC}$(_bifulnc $2)$1${OFF}"
}
_path () {
  [[ "$1" == "" ]] && {
    echo -e "prints a ${TXT_BLUE}[path]${OFF}

  usage: _path \"[path]\" (bifulnc)

  [path]:    the path to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_BLUE}$(_bifulnc $2)$1${OFF}"
}
_info () {
  [[ "$1" == "" ]] && {
    echo -e "prints some ${TXT_DGRAY}[info]${OFF}

  usage: _info \"[info]\" (bifulnc)

  [info]:    the info to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_DGRAY}$(_bifulnc $2)$1${OFF}"
}
_linfo () {
  [[ "$1" == "" ]] && {
    echo -e "prints some ${TXT_LGRAY}[info]${OFF}

  usage: _linfo \"[info]\" (bifulnc)

  [info]:    the info to print
  (bifulnc): add \"b\" ($(_bold "bold")), \"i\" ($(_italic "italic")), \"f\" ($(_faint "faint")), \"u\" ($(_underscore "underscore")), \"l\" ($(_blink "blink")), \"n\" ($(_inverse "inverse")), or \"c\" (concealed, i.e. invisible))
  "
    return;
  }
  # no version, belongs to colors_basic.sh
  echo -e "${TXT_LGRAY}$(_bifulnc $2)$1${OFF}"
}

warning () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: warning [message]"
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "3"
    return;
  }
  echo -e "$(_orange_on_grey "warning:") $1"
}

skip () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: skip [message]"
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "3"
    return;
  }
  echo -e "$(_green_on_grey "skipping:") $1"
}

error () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: error [message]"
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "3"
    return;
  }
  echo -e "$(_lred "error:") $1"
  exit 1
}

alldone () {
  [[ "$1" =~ ^(-h|--help)$ ]] && {
    echo "usage: alldone"
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "4"
    return;
  }
  _green $' \u2714 '
}

yesno () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: yesno [question] (yes) (no) (show)

    returns true for yes or false for no

    [question]:  the question to ask
    (yes):       optional yes answer (default: \"[yY]\")
    (no)         optional no answer (default: \"[nN]\")
    (show)       optional string to show after question (default: \"(y/n)\")
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "1"
    return;
  }
  local ASK="$1";
  local YES="$2";
  [[ "${YES}" == "" ]] \
    && YES="[yY]"
  local NO="$3";
  [[ "${NO}" == "" ]] \
    && NO="[nN]"
  local SHOW="$4";
  [[ "${SHOW}" == "" ]] \
    && SHOW="(y/n)"
  local ANSWER
  local RESULT
  while true; do
    read -p "$(_bold "${ASK}") $(_dgray "${SHOW}") " ANSWER
    case ${ANSWER} in
      ${YES})
        RESULT=true >&2
        break
        ;;
      ${NO})
        RESULT=false >&2
        break
        ;;
      *) echo -e $(_red "invalid response!") >2
        ;;
    esac
  done
  echo ${RESULT}
}

edit_file () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "opens a file for editing if the correct argument is given

    usage: edit_file [file] [arg_if] [arg] (error) (editor)

    [file]:     the file to open for editing
    [arg_if]:   the value of [arg] that launches the editor 
    [arg]:      the argument to check
    (error):    optional custom error message
                default: \"unable to edit file!\"
    (editor):   optional editor command to run
                default: \"\${VISUAL:-\${EDITOR:-vi}}\"
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "1"
    return;
  }
  local EDITFILE="$1";
  local ARG_IF="$2";
  local ARG="$3";
  local ERROR_MSG="$4";
  local EDIT_CMD="$5";
  [[ "${ERROR_MSG}" == "" ]] && \
    ERROR_MSG="unable to edit file!";
  [[ "${EDIT_CMD}" == "" ]] && \
    EDIT_CMD="${VISUAL:-${EDITOR:-vi}}";
  [[ "${ARG}" =~ ("${ARG_IF}") ]] && { 
    ${EDIT_CMD} "${EDITFILE}" || error "${ERROR_MSG}"
    exit 0
  };
}

path_exists () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: path_exists [test] [path] (show)
    
    [test]:  the test to perform (e.g., -d for dir, -f for file, see man test)
    [path]:  the path to check
    (show):  optional argument \"show\", if given [path] will be printed before the result
             alternatively, use \"created\" to indicate that a currently missing path
             will be created if needed
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "5"
    return;
  }
  local TEST="$1"
  local CHECKPATH="$2"
  local SHOW="$3"
  if [[ "${SHOW}" == "show" ]] || [[ "${SHOW}" == "created" ]] ; then
    [[ "${CHECKPATH}" ]] \
      && echo -en "$(_blue "${CHECKPATH}") " \
      || echo -en "$(_lgray "(empty)") "
  fi
  if [ ${TEST} "${CHECKPATH}" ] ; then
    _green $'\u2714'
  else
    if [[ "${SHOW}" == "created" ]] ; then
      _orange $'\u2716 (autocreate)'
    else
      _red $'\u2716'
    fi
  fi
}

usage () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: usage [section] [arg1] [arg2] [arg3] [arg4] [arg5]
    
    [section]:  one of
                - \"usage\":   usage info with section title (2 args)
                - \"sect\":    name of a section of options (2 args)
                - \"opt\":     an option with (optional) argument and description (3 args)
                - \"default\": a default value after \"opt\" (1 arg)
                - \"info\":    additional info line after \"opt\" (5 args)
                - \"note\":    like \"info\", but the first arg is emphasized (5 args)
                - \"par\":     an additional parameter with explanation after \"opt\" (5 args)
                - \"par_i\":   additional info line after \"par\" (5 args)
                - \"par_l\":   additional list of infos after \"par\" (5 args)
                - \"par_n\":   like \"par_i\", but the first arg is emphasized (5 args)
                - \"conf\":    show configuration, version and dependencies info (5 args)
    [arg1]:     if usage:      the command to document
                if opt:        the option to document
                if sect:       the name of the section
                if default:    the default value
                if info:       the info to show
                if note:       the emphasized info (e.g., \"note:\")
                if par:        the parameter name (e.g., a character)
                if par_i:      the info to show
                if par_l:      the info to show
                if par_n:      the emphasized info (e.g., \"note:\")
                if conf:       the configuration file or \"\"
    [arg2]:     if usage:      the command options
                if opt:        an additional argument or \"\"
                if sect:       a line of additional info
                if default:    ignored
                if info:       a second line
                if note:       the info to show
                if par:        the parameter description
                if par_i:      a second line
                if par_l:      a second line
                if par_n:      the info to show
                if conf:       the version argument (e.g., \"--version\") or \"\"
    [arg3]:     if usage:      ignored
                if opt:        description of the option
                if sect:       ignored
                if default:    ignored
                if info:       a third line
                if note:       a second line
                if par:        a second line
                if par_i:      a third line
                if par_l:      a third line
                if par_n:      a second line
                if conf:       the dependencies argument (e.g., \"--dependencies\") or \"\"
    [arg4]:     if usage:      ignored
                if opt:        ignored
                if sect:       ignored
                if default:    ignored
                if info:       a fourth line
                if note:       a third line
                if par:        a third line
                if par_i:      a fourth line
                if par_l:      a fourth line
                if par_n:      a third line
                if conf:       the argument to edit the configuration file (e.g., \"--config\") or \"\"
    [arg5]:     if usage:      ignored
                if opt:        ignored
                if sect:       ignored
                if default:    ignored
                if info:       a fifth line
                if note:       a fourth line
                if par:        a fourth line
                if par_i:      a fifth line
                if par_l:      a fifth line
                if par_n:      a third line
                if conf:       the argument to edit the script file itself (e.g., \"--edit\") or \"\"
    
    you can set the following environment variables to use other than the default columns (in brackets):
      - USG_OPT: number of characters reserved for option names (4)
      - USG_ARG: number of characters reserved for option argument names (10)
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "7"
    return;
  }
  local SECT="$1"
  local ARG1="$2"
  local ARG2="$3"
  local ARG3="$4"
  local ARG4="$5"
  local ARG5="$6"

  local IS_NUM='^[0-9]+$'
  if ! [[ ${USG_OPT} =~ ${IS_NUM} ]] ; then
      local USG_OPT=4
  fi
  if ! [[ ${USG_ARG} =~ ${IS_NUM} ]] ; then
      local USG_ARG=10
  fi
  local USG_DESC=$((${USG_OPT} + ${USG_ARG} + 4))
  local USG_CONFDEPVAR=2
  local INFOS_TO_GO
  local i

  case $SECT in
      usage)
          echo -e "\rUsage:\n  $(_opt "${ARG1}") $(_info "${ARG2}" i)"
          ;;
      opt)
          echo -e "\r$(printf "%${USG_OPT}s")$(_opt "${ARG1}") $(_arg "$(printf "%-${USG_ARG}s" "${ARG2}")") ${ARG3}"
          ;;
      sect)
          echo -e "\r$(printf "%${USG_CONFDEPVAR}s")$(_underscore "${ARG1}"):"
          [[ "${ARG2}" != "" ]] && echo -e "\r$(printf "%${USG_CONFDEPVAR}s")$(_info "${ARG2}")"
          ;;
      default)
          echo -e "\r$(printf "%${USG_DESC}s")$(_info "default:") ${ARG1}"
          ;;
      info)
          for i in "${ARG1}" "${ARG2}" "${ARG3}" "${ARG4}" "${ARG5}" ; do
              [[ "${i}" != "" ]] && echo -e "\r$(printf "%${USG_DESC}s")$(_linfo "${i}")"
          done
          ;;
      note)
          echo -en "\r$(printf "%${USG_DESC}s")$(_info "${ARG1}")"
          [[ "${ARG2}" != "" ]] \
            && echo -e " $(_linfo "${ARG2}")" \
            || echo -e ""
          for i in "${ARG3}" "${ARG4}" "${ARG5}" ; do
              [[ "${i}" != "" ]] && echo -e "\r$(printf "%${USG_DESC}s")   $(_linfo "${i}")"
          done
          ;;
      par)
          echo -en "\r$(printf "%${USG_DESC}s")$(_blue "${ARG1}"):"
          [[ "${ARG2}" != "" ]] \
            && echo -e " $(_linfo "${ARG2}")" \
            || echo -e ""
          for i in "${ARG3}" "${ARG4}" "${ARG5}" ; do
              [[ "${i}" != "" ]] && echo -e "\r$(printf "%${USG_DESC}s")   $(_linfo "${i}")"
          done
          ;;
      par_i)
          for i in "${ARG1}" "${ARG2}" "${ARG3}" "${ARG4}" "${ARG5}" ; do
              [[ "${i}" != "" ]] && echo -e "\r$(printf "%${USG_DESC}s")   $(_linfo "${i}")"
          done
          ;;
      par_l)
          for i in "${ARG1}" "${ARG2}" "${ARG3}" "${ARG4}" "${ARG5}" ; do
              [[ "${i}" != "" ]] && echo -e "\r$(printf "%${USG_DESC}s")   $(_linfo "- ${i}")"
          done
          ;;
      par_n)
          echo -en "\r$(printf "%${USG_DESC}s")   $(_info "${ARG1}")"
          [[ "${ARG2}" != "" ]] \
            && echo -e " $(_linfo "${ARG2}")" \
            || echo -e ""
          for i in "${ARG3}" "${ARG4}" "${ARG5}" ; do
              [[ "${i}" != "" ]] && echo -e "\r$(printf "%${USG_DESC}s")     $(_linfo "${i}")"
          done
          ;;
      conf)
          echo -en "\r$(printf "%${USG_CONFDEPVAR}s")"
          if [[ "${ARG2}" != "" ]] || [[ "${ARG3}" != "" ]] || [[ "${ARG5}" != "" ]] ; then
              declare -a INFO_OPTIONS=()
              echo -en "$(_info "use") "
              [[ "${ARG3}" != "" ]] \
                  && INFO_OPTIONS+=("$(echo -e "$(_opt "${ARG3}") $(_info "to see which shared files are sourced by this script")")")
              [[ "${ARG2}" != "" ]] \
                  && INFO_OPTIONS+=("$(echo -e "$(_opt "${ARG2}") $(_info "for version info")")")
              [[ "${ARG5}" != "" ]] \
                  && INFO_OPTIONS+=("$(echo -e "$(_opt "${ARG5}") $(_info "to edit the script file")")")
              for (( i=0; i<${#INFO_OPTIONS[@]}; i++ )) ; do
                  echo -en "${INFO_OPTIONS[${i}]}"
                  INFOS_TO_GO=$(((${#INFO_OPTIONS[@]}-${i}-1)))
                  case ${INFOS_TO_GO} in
                    0) echo -e "$(_info ".")"
                       ;;
                    1) echo -en "$(_info ",")\r\n$(printf "%${USG_CONFDEPVAR}s")$(_info "and ")"
                       ;;
                    2) echo -en "$(_info ", ")"
                       ;;
                  esac
              done
              unset INFO_OPTIONS
          fi
          if [[ "${ARG1}" != "" ]] ; then
              if [[ "${ARG4}" != "" ]] ; then
                  echo -e "\r\n$(printf "%${USG_CONFDEPVAR}s")$(_info "you can use") $(_opt "${ARG4}") $(_info "to edit the defaults in the config file for this script:")"
              else
                  echo -e "\r\n$(printf "%${USG_CONFDEPVAR}s")$(_info "you can change/set the defaults by editing the config file for this script:")"
              fi
              echo -e "\r$(printf "%${USG_CONFDEPVAR}s")$(path_exists -f "${ARG1}" created)"
          fi
          ;;
      *)
          error "invalid section: ${TXT_BOLD}${SECT}${OFF}" >&2
          ;;
  esac

}

mkmissingdir () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: mkmissingdir [path] (extra) (mode)

    [path]:  the path to check and create (if missing)
    (extra): the keyword \"sudo\" if mkdir needs root privileges (use \"none\" if you just need \"(mode)\")
    (mode):  file mode (as in chmod)
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "7"
    return;
  }
  local SUDOCMD=""
  local MODECMD=""
  if [[ "$2" == "sudo" ]] ; then
    SUDOCMD="sudo"
  fi
  if [[ "$3" != "" ]]; then
    MODECMD="--mode=$3";
  fi;
  if [ ! -d "${1}" ] ; then
    echo -en "create missing directory $(_blue "${1}")..."
    ${SUDOCMD} mkdir ${MODECMD} --parents "${1}" || error "failed!"
    alldone
  fi
}

write_new_file (){
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: write_new_file [path] [cont] (overwrite)

    [path]:      the file to write to
    [cont]:      the content to write to [path]
    (overwrite): the keyword \"overwrite\" if existing files should be replaced
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "2"
    return;
  }
  local FILE="$1"
  local CONTENT="$2"
  local OVERWRITE="$3"
  if [ ! -f "${FILE}" ] ; then
    echo -en "creating new file $(_blue "${FILE}")..."
    echo "${CONTENT}" > "${FILE}" || error "failed!"
    alldone
  else
    if [[ "${OVERWRITE}" == "overwrite" ]] ; then
        echo -en "overwriting exiting file $(_blue "${FILE}")..."
        echo "${CONTENT}" > "${FILE}" || error "failed!"
        alldone
    else
      error "file exists: $(_blue "${FILE}")"
    fi
  fi
}

check_tool () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "checks if the given tool is available

    usage: check_tool [tool] [path]

    [tool]: name of tool to look up
    [path]: path to tool

    if there's only one parameter, \"which\" is called and the result returned
    if there's two, the functions exits silently if there are no errors
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "3"
    return;
  }
  local TNAME="$1"
  local TPATH="$2"
  if [ "${TPATH}" != "" ] ; then
    TOOL="${TPATH}"
  else
    TOOL="$(which ${TNAME})"
  fi
  if [ -x "${TOOL}" ] ; then
    if [ "${TPATH}" == "" ] ; then
      echo "\"${TOOL}\""
    fi
  else
    error "can't find ${TNAME}, please check your configuration!"
  fi
}

min_version () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "checks if the given command fulfills the minimum version requirement

    usage: min_version [cmd] [arg] [min]

    [cmd]:  command to check
    [arg]:  argument to get the version info from [cmd]
    [min]:  the minimum version number that is required
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "1"
    return;
  }
  local CMD="$1"
  local ARG="$2"
  local MIN="$3"
  [[ "${MIN}" == "" ]] && error "no minimum version info given!"

  VERSION_FOUND="$(${CMD} ${ARG})"
  [[ "${VERSION_FOUND}" -ge "${MIN}" ]] \
    || error "need $(_blue "${CMD}") $(_green ">= ${MIN}") but only found version $(_red "${VERSION_FOUND}")!"
}

function_body () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "prints the body of a bash function

  usage: function_body [function]
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "2"
    return;
  }
  local FBODY="$1"
  type ${FBODY} | sed -n '1!p'
}

dependency_section () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "creates a dependency section from an array

  usage: dependency_section [array] [dir] [version]
  
  [array]:   an array of active dependencies (path names)
  [dir]:     the directory prefix for shared files
  [version]: the version of bash_script_skeleton.sh
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "1"
    return;
  }
  declare -n DEP_ARRAY=$1;
  local BSSHAREDIR="$2"
  local SCRIPT_VERSION="$3"
  [[ "${SCRIPT_VERSION}" == "" ]] \
    && SCRIPT_VERSION="$(bash_script_skeleton.sh --version || exit 1)"
echo -e "# use some basic functions from the shared directory
# for usage information, you can run the scripts in bash to define
# the enclosed functions locally, and then the function names after
# \"func_\" with \"-h\", \"--help\", \"--version\", or no parameter, e.g.
#   warning --help
# minimum version requirements were initially defined during script creation
# run this to manually check for updates of base shared functions:
#   bash_script_skeleton.sh -I -s \"${BSSHAREDIR}\"
declare -A DEPENDENCIES=(
    # text formatting functions defined in colors_basic.sh:
$(colors_basic --colors | sed -e 's/^/    # /')
    $([[ " ${DEP_ARRAY[@]} " =~ "colors_basic.sh " ]] || echo "# ")[\"${BSSHAREDIR}/colors_basic.sh\"]=\"colors_basic >= $(colors_basic --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_warning.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_warning.sh\"]=\"warning >= $(warning --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_skip.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_skip.sh\"]=\"skip >= $(skip --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_error.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_error.sh\"]=\"error >= $(error --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_alldone.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_alldone.sh\"]=\"alldone >= $(alldone --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_edit_file.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_edit_file.sh\"]=\"edit_file >= $(edit_file --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_min_version.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_min_version.sh\"]=\"min_version >= $(min_version --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_mkmissingdir.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_mkmissingdir.sh\"]=\"mkmissingdir >= $(mkmissingdir --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_path_exists.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_path_exists.sh\"]=\"path_exists >= $(path_exists --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_usage.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_usage.sh\"]=\"usage >= $(usage --version)\"
    # appends given text as a new line to given file
    #   usage: appendconfig [path] [grep] [body] (extra)
    #    [path]:  file name, full path
    #    [grep]:  stuff to grep for in [path] to check whether the entry is already there
    #    [body]:  full line to append to [path] otherwise
    #    (extra): the key word \"sudo\" if sudo is needed for the operation, \"config\" to silence skips
    $([[ " ${DEP_ARRAY[@]} " =~ "func_appendconfig.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_appendconfig.sh\"]=\"appendconfig >= $(appendconfig --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_check_tool.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_check_tool.sh\"]=\"check_tool >= $(check_tool --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_check_shared_script.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_check_shared_script.sh\"]=\"check_shared_script >= $(check_shared_script --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_dependency_section.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_dependency_section.sh\"]=\"dependency_section >= $(dependency_section --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_function_body.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_function_body.sh\"]=\"function_body >= $(function_body --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_link_script.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_link_script.sh\"]=\"link_script >= $(link_script --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_write_new_file.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_write_new_file.sh\"]=\"write_new_file >= $(write_new_file --version)\"
    $([[ " ${DEP_ARRAY[@]} " =~ "func_yesno.sh " ]] || echo "# ")[\"${BSSHAREDIR}/func_yesno.sh\"]=\"yesno >= $(yesno --version)\"
)
# use check_shared_script to add your own shared functions;
# keep in mind they need to support both ^(-h|--help)$ and ^(-v|--version)$ parameters!
[[ \"\$1\" =~ ^(--dependencies)$ ]] && {
    for i in \${!DEPENDENCIES[@]} ; do
      echo \"\${i} (\${DEPENDENCIES[\${i}]%% >=*} >= \${DEPENDENCIES[\${i}]##*>= })\"
    done
    exit 0
}
# now source the files needed in this script
for i in \${!DEPENDENCIES[@]} ; do
  [[ -f \"\${i}\" ]] \\\\
    || bash_script_skeleton.sh -I -s \"${BSSHAREDIR}\" || exit 1
  . \"\${i}\" || exit 1
  [[ \$(\${DEPENDENCIES[\${i}]%% >=*} --version) -ge \$(echo \${DEPENDENCIES[\${i}]##*>= }) ]] \\\\
    || bash_script_skeleton.sh -I -s \"${BSSHAREDIR}\" || exit 1
done
unset i
# check for minimum version requirements
# min_version \"bash_script_skeleton.sh\" \"--version\" \"${SCRIPT_VERSION}\""
}

check_shared_script () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "usage: check_shared_script [dir] [file] [type] [body] (head) (extra)

    [dir]:   \$BSSHAREDIR (directory for shared files)
    [file]:  shared file name
    [type]:  either \"function\" (will cause version extraction), \"versioned\" (dito) or \"plain\" (paste as-is)
    [body]:  body to echo into missing script
    (head):  an optional head, e.g. shebang, initial comments, etc.
    (extra): additional file content to append to the shared file
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "10"
    return;
  }
  local CSSDIR="$1"
  local CSSFILE="$2"
  local CSSTYPE="$3"
  local CSSBODY="$4"
  local CSSHEAD="$5"
  local CSSEXTRA="$6"
  local ORIGINFILE="# DO NOT EDIT THIS FILE! it was generated by ${0##*/}"
  local SCRIPTBODY
  local NEWVERSION
  if ! [ -f "${CSSDIR}/${CSSFILE}" ] ; then
    mkmissingdir "${CSSDIR}"
    echo -en "initializing shared script file $(_blue "${CSSFILE}")..."
    [ "${CSSTYPE}" == "function" ] \
      && SCRIPTBODY="# version $(eval ${CSSBODY} -v)\n${ORIGINFILE}\n\n$(function_body ${CSSBODY})" \
      || SCRIPTBODY="${ORIGINFILE}\n\n${CSSBODY}"
    [ "${CSSHEAD}" ] \
      && SCRIPTBODY="${CSSHEAD}\n${SCRIPTBODY}"
    [ "${CSSEXTRA}" ] \
      && SCRIPTBODY+="\n${CSSEXTRA}"
    echo -e "${SCRIPTBODY}" > "${CSSDIR}/${CSSFILE}" || error "unable to write shared file $(_blue "${CSSDIR}/${CSSFILE}")!"
    alldone
  elif [[ "${CSSTYPE}" =~ ("function"|"versioned") ]] ; then
    [ "${CSSTYPE}" == "function" ] \
      && NEWVERSION="$(eval ${CSSBODY} -v)" \
      || NEWVERSION="$(echo "${CSSHEAD}" | grep "^# version" | sed 's/^# version[[:space:]]*//')"
    OLDVERSION="$(grep "^# version" "${CSSDIR}/${CSSFILE}" | sed 's/^# version[[:space:]]*//')"
    if [[ "${OLDVERSION}" == "" || "${OLDVERSION}" -lt "${NEWVERSION}" ]] ; then
      echo -en "updating shared script file $(_blue "${CSSFILE}") from $(_bold "v${OLDVERSION}") to $(_bold "v${NEWVERSION}")..."
      if [ "${CSSTYPE}" == "function" ] ; then
        SCRIPTBODY="# version ${NEWVERSION}\n${ORIGINFILE}\n\n$(function_body ${CSSBODY})" || error "unable to generate script body!"
        [ "${CSSHEAD}" ] \
          && SCRIPTBODY="${CSSHEAD}\n${SCRIPTBODY}"
      else
        SCRIPTBODY="# version ${NEWVERSION}\n${ORIGINFILE}\n\n${CSSBODY}"
      fi
      [ "${CSSEXTRA}" ] \
        && SCRIPTBODY+="\n${CSSEXTRA}"
      echo -e "${SCRIPTBODY}" > "${CSSDIR}/${CSSFILE}" || error "unable to write shared file $(_blue "${CSSDIR}/${CSSFILE}")!"
      alldone
    fi
  fi
}

appendconfig () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "appends given text as a new line to given file

  usage: appendconfig [path] [grep] [body] (extra) (comm)

    [path]:   file name, full path
    [grep]:   stuff to grep for in [path] to check whether the entry is already there
    [body]:   full line to append to [path] otherwise
    (extra):  one of:
              - \"sudo\" if sudo is needed for the operation
              - \"config\" to silence skips
              - \"autoconfig\" for shorter syntax (assuming '^[grep]=' and '[grep]=')
    (comm):   an optional comment for the variable
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "8"
    return;
  }
  local FILEXISTS=false;
  local ACPATH="$1"
  local ACGREP="$2"
  local ACBODY="$3"
  local ACEXTRA="$4"
  local ACCOMMENT="$5"
  local ACGREPSHOW="${ACGREP}"
  local SUDOCMD
  [[ "${ACCOMMENT}" != "" ]] && {
    # force newline after comment
    ACCOMMENT="# ${ACCOMMENT%\\\n}\n"
  }

  if [[ "${ACEXTRA}" == "sudo" ]]; then
    SUDOCMD="sudo";
    sudo CONFFILE="${ACPATH}" bash -c '[[ -f "${CONFFILE}" ]]' && FILEXISTS=true
  else
    [[ -f "${ACPATH}" ]] && FILEXISTS=true;
  fi;
  if [[ "${ACEXTRA}" == "autoconfig" ]] ; then
    ACBODY="${ACGREP}=${ACBODY}"
    ACGREP="^${ACGREP}="
  fi
  if ${FILEXISTS}; then
    if ! [[ $(${SUDOCMD} grep "${ACGREP}" "${ACPATH}") ]] ; then
      echo -en "appending $(_blue "${ACGREPSHOW}") to $(_blue "${ACPATH}")..."
      if [[ "${ACEXTRA}" == "sudo" ]] ; then
        echo -e "${ACCOMMENT}${ACBODY}" | sudo tee --append "${ACPATH}" > /dev/null || error "failed!"
      else
        echo -e "${ACCOMMENT}${ACBODY}" >> "${ACPATH}" || error "failed!"
      fi
      alldone
    elif ! [[ "${ACEXTRA}" == "config" || "${ACEXTRA}" == "autoconfig" ]] ; then
      skip "appending to $(_blue "${ACPATH}") ($(_blue "${ACGREPSHOW}")), exists."
    fi
  else
    skip "$(_blue "${ACPATH}") not found!";
  fi
}

CONFIGDIR="${HOME}/.config/bash_scripts_${USER}"
CONFIGFILE="${CONFIGDIR}/bash_script_skeleton.conf"
if ! [ -f "${CONFIGFILE}" ] ; then
    mkmissingdir "${CONFIGDIR}"
    touch "${CONFIGFILE}"
fi
appendconfig "${CONFIGFILE}" "USERNAME" "\"$(whoami)\"" "autoconfig"
appendconfig "${CONFIGFILE}" "USERHOME" "\"${HOME}\"" "autoconfig"
appendconfig "${CONFIGFILE}" "SCRIPTPATH" "\"\${USERHOME}/bin\"" "autoconfig"
appendconfig "${CONFIGFILE}" "SCRIPTLINKPATH" "\"\${USERHOME}/bin\"" "autoconfig"
appendconfig "${CONFIGFILE}" "BSCONFIGDIR" "\"\\\${USERHOME}/.config/bash_scripts_\\\${USERNAME}\"" "autoconfig"
appendconfig "${CONFIGFILE}" "BSSHAREDIR" "\"\\\${USERHOME}/.config/bash_scripts_\\\${USERNAME}/shared\"" "autoconfig"
appendconfig "${CONFIGFILE}" "SHEBANG" "\"#!/usr/bin/env bash\"" "autoconfig"
appendconfig "${CONFIGFILE}" "LIC_AUTHOR_NAME" "\"Foo Bar\"" "autoconfig" "LIC_AUTHOR_NAME and LIC_AUTHOR_EMAIL can be used as defaults for license notes"
appendconfig "${CONFIGFILE}" "LIC_AUTHOR_EMAIL" "\"foo.bar@example.com\"" "autoconfig"
appendconfig "${CONFIGFILE}" "declare -A LICENSES" "(\n  [\"GPLv3\"]=\"#
# Copyright \$(date +%Y) __LIC_AUTHOR_NAME__ <__LIC_AUTHOR_EMAIL__>
#
# __SCRIPTNAME__ is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# __SCRIPTNAME__ is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with __SCRIPTNAME__.  If not, see <http://www.gnu.org/licenses/>.
\"\n)\n" "autoconfig" "add new license notes to this array, using __LIC_AUTHOR_NAME__,\n# __LIC_AUTHOR_EMAIL__ and __SCRIPTNAME__ as template variables"

. "${CONFIGFILE}"

edit_file "${CONFIGFILE}" "--config" "$1" "unable to edit configuration file!"
edit_file "${0}" "--edit" "$1" "unable to edit script file!"

LIC_NAMES=$(for i in ${!LICENSES[@]} ; do
    echo -e "$(usage info "- $(_blue "${i}")")"
done)

OLDWD="$(pwd)"

if [[ $1 == "" ]] ; then
    echo -e "
$(usage usage "${0##*/}" "[OPTIONS]")

  $(usage sect "OPTIONS")
    $(usage opt "-n" "<name>" "name of the script")
    $(usage opt "-p" "<path>" "script path")
                              $(usage default "$(path_exists -d "${SCRIPTPATH}" show)")
    $(usage opt "-d" "<path>" "config dir")
                              $(usage default "$(path_exists -d $(eval "echo ${BSCONFIGDIR}") created)")
    $(usage opt "-s" "<path>" "dir for files shared with other scripts")
                              $(usage default "$(path_exists -d $(eval "echo ${BSSHAREDIR}") created)")

    $(usage opt "-C" ""       "add code for script's config file")
    $(usage opt "-c" "<name>" "name of config file")
                              $(usage default "$(_path "\"\$(basename scriptname .sh).conf\" suffix")")
  
    $(usage opt "-L" "<name>" "add a license note, options are:")
                                ${LIC_NAMES}
    $(usage opt "-a" "<name>" "use $(_arg "<name>") as author name")
                              $(usage default "$(_blue "${LIC_AUTHOR_NAME}")")
    $(usage opt "-m" "<mail>" "use $(_arg "<mail>") as author e-mail address")
                              $(usage default "$(_blue "${LIC_AUTHOR_EMAIL}")")

    $(usage opt "-k" ""       "open script with \$VISUAL or \$EDITOR for editing")
                              $(usage info "$(_linfo "current") $(_blue "\$VISUAL")$(_linfo ":") $(_blue "$([ ${VISUAL} ] && echo "${VISUAL}" || echo "(unset)")")")
                              $(usage info "$(_linfo "current") $(_blue "\$EDITOR")$(_linfo ":") $(_blue "$([ ${EDITOR} ] && echo ${EDITOR} || echo "(unset)")")")
                              $(usage info "fallback: $(_path "vi")")
    $(usage opt "-l" ""       "link script to $(path_exists -d "${SCRIPTLINKPATH}" show)")
    $(usage opt "-e" ""       "use $(_path "#!/bin/bash") shebang")
                              $(usage default "$(_path "${SHEBANG}")")

    $(usage opt "-I" ""       "only initialize basic shared files in dir as set by $(_opt "-s")")
    $(usage opt "-V" ""       "show version information of basic shared files available in this script")
    
    $(usage conf "${CONFIGFILE}" "--version" "" "--config" "--edit")
"
  exit 0
fi

# get the options
while getopts ":a:Cc:d:eIklL:m:n:p:s:V" OPT; do
  case $OPT in
    a) LIC_AUTHOR_NAME="${OPTARG}" >&2
       ;;
    C) WITHCONFIG=true >&2
       ;;
    c) HAVECONFIGNAME=true >&2
       BSCONFIGFILE="${OPTARG}" >&2
       ;;
    d) BSCONFIGDIR="${OPTARG}" >&2
       ;;
    e) SHEBANG="#!/usr/bin/env bash" >&2
       ;;
    I) INITSHARED=true >&2
       ;;
    k) EDITSCRIPT=true >&2
       ;;
    l) LINKSCRIPT=true >&2
       ;;
    L) WITHLICENSE=true >&2
       LICENSE_NAME="${OPTARG}" >&2
       [[ " ${!LICENSES[@]} " =~ " ${LICENSE_NAME} " ]] || error "invalid license: ${LICENSE_NAME}"
       ;;
    m) LIC_AUTHOR_EMAIL="${OPTARG}" >&2
       ;;
    n) HAVENAME=true >&2
       SCRIPTNAME="${OPTARG}" >&2
       ;;
    p) SCRIPTPATH="${OPTARG}" >&2
       ;;
    s) BSSHAREDIR="${OPTARG}" >&2
       ;;
    V) CSSVERSIONINFO=true >&2
       ;;
    \?)
      error "Invalid option: $(_bold "-${OPTARG}")" >&2
      exit 1
      ;;
    :)
      error "Option $(_bold "-${OPTARG}") requires an argument." >&2
      exit 1
      ;;
  esac
done

BASICCOLORSEXTRA="colors_basic

$(function_body _bifulnc)
$(function_body _biulnc)
$(function_body _dgray)
$(function_body _lgray)
$(function_body _lred)
$(function_body _red)
$(function_body _lblue)
$(function_body _blue)
$(function_body _green)
$(function_body _lpurple)
$(function_body _purple)
$(function_body _black)
$(function_body _brown)
$(function_body _yellow)
$(function_body _orange)
$(function_body _cyan)
$(function_body _lcyan)
$(function_body _white)
$(function_body _green_on_grey)
$(function_body _orange_on_grey)
$(function_body _bg_red)
$(function_body _bg_green)
$(function_body _bold)
$(function_body _italic)
$(function_body _faint)
$(function_body _underscore)
$(function_body _blink)
$(function_body _inverse)
$(function_body _concealed)
$(function_body _opt)
$(function_body _arg)
$(function_body _path)
$(function_body _info)
$(function_body _linfo)
"

link_script () {
  [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] && {
    echo "links given script [file] from [source dir] to [target dir] with executable rights

  usage: link_script [file] [source dir] [target dir]

    [file]:       script name
    [source dir]: source directory
    [target dir]: target directory
    "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "5"
    return;
  }
  mkmissingdir "$3"
  if [ ! -f "$3/$1" ] ; then
    cd "$3"
    echo -e "linking $(_blue "$1")"
    ln -sf "$2/$1" .
    chmod +x "$2/$1"
    cd "${OLDWD}"
  else
    skip "not linking $(_blue "$3/$1"), exists."
  fi
}

init_shared () {
  [[ "$1" =~ ^(-h|--help)$ ]] && {
    echo "initializes or updates basic shared files for bash scripts (if missing or old)

  usage: init_shared [dir]

    [dir]: \$BSSHAREDIR (directory for shared files)"
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "4"
    return;
  }
  check_shared_script "$1" "colors_basic.sh"              "function" "colors_basic"         "${SHEBANG}" "${BASICCOLORSEXTRA}"
  check_shared_script "$1" "func_alldone.sh"              "function" "alldone"              "${SHEBANG}"
  check_shared_script "$1" "func_appendconfig.sh"         "function" "appendconfig"         "${SHEBANG}"
  check_shared_script "$1" "func_check_shared_script.sh"  "function" "check_shared_script"  "${SHEBANG}"
  check_shared_script "$1" "func_check_tool.sh"           "function" "check_tool"           "${SHEBANG}"
  check_shared_script "$1" "func_dependency_section.sh"   "function" "dependency_section"   "${SHEBANG}"
  check_shared_script "$1" "func_edit_file.sh"            "function" "edit_file"            "${SHEBANG}"
  check_shared_script "$1" "func_error.sh"                "function" "error"                "${SHEBANG}"
  check_shared_script "$1" "func_function_body.sh"        "function" "function_body"        "${SHEBANG}"
  check_shared_script "$1" "func_link_script.sh"          "function" "link_script"          "${SHEBANG}"
  check_shared_script "$1" "func_min_version.sh"          "function" "min_version"          "${SHEBANG}"
  check_shared_script "$1" "func_mkmissingdir.sh"         "function" "mkmissingdir"         "${SHEBANG}"
  check_shared_script "$1" "func_path_exists.sh"          "function" "path_exists"          "${SHEBANG}"
  check_shared_script "$1" "func_skip.sh"                 "function" "skip"                 "${SHEBANG}"
  check_shared_script "$1" "func_usage.sh"                "function" "usage"                "${SHEBANG}"
  check_shared_script "$1" "func_warning.sh"              "function" "warning"              "${SHEBANG}"
  check_shared_script "$1" "func_write_new_file.sh"       "function" "write_new_file"       "${SHEBANG}"
  check_shared_script "$1" "func_yesno.sh"                "function" "yesno"                "${SHEBANG}"
}

func_version () {
  [[ "$1" =~ ^(-h|--help)$ ]] && {
    echo "show version information of basic shared files

  usage: func_version (func)

    (func): name of a function to examine (optional)
            default is to list all functions
  "
    return;
  }
  [[ "$1" =~ ^(-v|--version)$ ]] && {
    echo "1"
    return;
  }
  local FUNC="$1";
  local i;
  if [[ ${FUNC} == "" ]] ; then
    for i in \
      "colors_basic" \
      "alldone" \
      "appendconfig" \
      "check_shared_script" \
      "check_tool" \
      "edit_file" \
      "error" \
      "function_body" \
      "link_script" \
      "min_version" \
      "mkmissingdir" \
      "path_exists" \
      "skip" \
      "usage" \
      "warning" \
      "write_new_file" \
      "yesno"
    do
      echo -e "  - $(_path "${i}") $(_bold "$(${i} --version)")"
    done
  else
    echo -e "  - $(_path "${FUNC}") $(_bold "$(${FUNC} --version)")"
  fi
}

if ${INITSHARED} ; then
  init_shared "$(eval echo ${BSSHAREDIR})"
  exit 0
fi

if ${CSSVERSIONINFO} ; then
  func_version
  exit 0
fi

if ! ${HAVENAME} ; then
  error "you *must* set a script name with '${TXT_BOLD}-n${OFF}'!"
fi
if ! ${HAVECONFIGNAME} ; then
  BSCONFIGFILE="$(basename $SCRIPTNAME .sh).conf"
fi

DEFAULT_DEPENDENCIES=(
    "colors_basic.sh"
    "func_warning.sh"
    "func_skip.sh"
    "func_edit_file.sh"
    "func_error.sh"
    "func_alldone.sh"
    "func_mkmissingdir.sh"
    "func_path_exists.sh"
    "func_usage.sh"
)

if ${WITHCONFIG} ; then
  CONFSTUB="
### BEGIN CONFIG SECTION ###
## (uncomment & configure to use; include func_appendconfig.sh in the dependencies!)
#CONFIGDIR=\"${BSCONFIGDIR}\"
#CONFIGFILE=\"\${CONFIGDIR}/${BSCONFIGFILE}\"
#if ! [ -f \"\${CONFIGFILE}\" ] ; then
#    mkmissingdir \"\${CONFIGDIR}\"
#    touch \"\${CONFIGFILE}\"
#fi
#appendconfig \"\${CONFIGFILE}\" \"USERNAME\" \"\\\"\${USERNAME}\\\"\" \"autoconfig\"
#appendconfig \"\${CONFIGFILE}\" \"USERHOME\" \"\\\"/home/\\\${USERNAME}\\\"\" \"autoconfig\"
#appendconfig \"\${CONFIGFILE}\" \"BSSHAREDIR\" \"\\\"\${BSSHAREDIR}\\\"\" \"autoconfig\"
#appendconfig \"\${CONFIGFILE}\" \\
#  \"declare -A PRF_EXAMPLEARRAY\" \\
#  \"(\\n  [\\\"example\\\"]=\\\"/tmp/example\\\"\\n)\\n\\n\" \\
#  \"autoconfig\" \\
#  \"add a comment\"
#appendconfig \"\${CONFIGFILE}\" \\
#  \"declare -A PRF_EXAMPLEARRAY2\" \\
#  \"(\\n  [\\\"example\\\"]=\\\"foo\\\"\\n)\\n\\n\" \\
#  \"autoconfig\" \\
#  \"another comment\"
#
#. \"\${CONFIGFILE}\"
#
## if you want to use config profiles via arrays with identical keys
#PROFILES=\$(for i in \${!PRF_EXAMPLEARRAY[@]} ; do
#    echo -e \"\$(usage par \"\${i}\")\"
#    echo -e \"\$(usage par_l \"path:          \$(path_exists -d \"\${PRF_EXAMPLEARRAY[\"\${i}\"]}\" show)\")\"
#    echo -e \"\$(usage par_l \"foo:           \${PRF_EXAMPLEARRAY2[\"\${i}\"]}\")\"
#done)
#
# edit_file \"\${CONFIGFILE}\" \"--config\" \"\$1\" \"unable to edit configuration file!\"
### END CONFIG SECTION ###
"
  DEFAULT_DEPENDENCIES+=("func_appendconfig.sh")
  CONFINFO="\${CONFIGFILE}"
  CONFEDIT="--config"
  CONFPROFILEUSAGE="
        \$(usage opt \"-p\" \"<profile>\" \"select profile:\")
                \$(usage note \"note:\" \"if only one profile is defined, it will be used by default!\")
                \${PROFILES}\n"
  CONFPROFILEOPTSET="p:"
  CONFPROFILEOPTCHECK="
        p) CONFPROFILE=\"\${OPTARG}\" >&2
           [[ \" \${!PRF_EXAMPLEARRAY[@]} \" =~ \" \${CONFPROFILE} \" ]] || error \"invalid profile: \${CONFPROFILE}\"
           HAVE_PROFILE=true >&2
           ;;"
  CONFPROFILESELECT="
## use default profile if only a single one is defined
# if ! \${HAVE_PROFILE} ; then
#     if [[ \"\${#PRF_EXAMPLEARRAY[@]}\" -gt 1 ]] ; then
#         error \"you must select a profile via \$(_opt \"-p\")!\"
#     else
#         CONFPROFILE=\"\${!PRF_EXAMPLEARRAY[@]}\"
#         HAVE_PROFILE=true >&2
#     fi
# fi
#
## set variable value from chosen profile
# EXAMPLEVAR=\"\${PRF_EXAMPLEARRAY[\"\${CONFPROFILE}\"]}\"
# EXAMPLEVAR2=\"\${PRF_EXAMPLEARRAY2[\"\${CONFPROFILE}\"]}\"
"
else
  CONFSTUB=""
  CONFFUNCLOAD="# "
  CONFINFO=""
  CONFEDIT=""
  CONFPROFILEUSAGE=""
  CONFPROFILEOPTSET=""
  CONFPROFILEOPTCHECK=""
  CONFPROFILESELECT=""
fi

if ${WITHLICENSE} ; then
  LICSTUB="${LICENSES["${LICENSE_NAME}"]}"
  LICSTUB="${LICSTUB//__SCRIPTNAME__/${SCRIPTNAME}}"
  LICSTUB="${LICSTUB//__LIC_AUTHOR_NAME__/${LIC_AUTHOR_NAME}}"
  LICSTUB="${LICSTUB//__LIC_AUTHOR_EMAIL__/${LIC_AUTHOR_EMAIL}}"
else
  LICSTUB=""
fi

mkmissingdir "${SCRIPTPATH}"

FULLSCRIPTPATH="${SCRIPTPATH}/${SCRIPTNAME}"

SCRIPTCONTENT="${SHEBANG}
${LICSTUB}
[[ \"\$1\" =~ ^(--version)$ ]] && { 
    echo \"$(date +%Y-%m-%d)\";
    exit 0
};

### BEGIN SCRIPT INITIALIZATION ###
## initialize hard coded variables here
# EXAMPLE=false
# BASHHINTS=false

# DATE=\"\$(date +%Y-%m-%d_%H-%M-%S)\"

# OLDWD=\"\$(pwd)\"
# trap \"cd \${OLDWD}\" EXIT

# keep these variables if you source files in the dependency section
USERNAME=\$(whoami)
USERHOME=\"\${HOME}\"
BSSHAREDIR=\"${BSSHAREDIR}\"
### END SCRIPT INITIALIZATION ###

### BEGIN DEPENDENCY SECTION ###
$(dependency_section DEFAULT_DEPENDENCIES "\${BSSHAREDIR}" "${SCRIPT_VERSION}")
### END DEPENDENCY SECTION ###
${CONFSTUB}
edit_file \"\${0}\" \"--edit\" \"\$1\" \"unable to edit script file!\"

### BEGIN USAGE SECTION ###
if [[ \"\$1\" =~ ^(-h|--help)\$ || \"\$1\" == \"\" ]] ; then
  USG_OPT=4  # spaces before option names
  USG_ARG=10 # width of option argument names
  echo -e \"
\$(usage usage \"\${0##*/}\" \"[OPTIONS]\")

    \$(usage sect \"OPTIONS\")${CONFPROFILEUSAGE}
        \$(usage opt \"-e\" \"<path>\" \"example option\")
                \$(usage default \"\$(path_exists -d \"\${USERHOME}\" show)\")
        \$(usage opt \"-h\" \"\" \"call ~/bin/bash_hints.sh\")

    \$(usage conf \"${CONFINFO}\" \"--version\" \"--dependencies\" \"${CONFEDIT}\" \"--edit\")
\"
# see also \$(usage info ...) and \$(usage par ...)
  exit 0
fi
### END USAGE SECTION ###

# get the options
while getopts \":${CONFPROFILEOPTSET}e:h\" OPT; do
    case \$OPT in${CONFPROFILEOPTCHECK}
        e) EXAMPLE=true >&2
           USERHOME=\"\${OPTARG}\" >&2
           ;;
        h) BASHHINTS=true >&2
           ;;
        \\?)
           error \"Invalid option: \$(_bold \"-\${OPTARG}\")\" >&2
           ;;
        :)
           error \"Option \$(_bold \"-\${OPTARG}\") requires an argument.\" >&2
           ;;
    esac
done

### BEGIN SCRIPT BODY ###
## run stuff cleanly in the background
## just call eval_bg with the command to be evaluated in a quoted character string!
# eval_bg() {
#     eval \"$@\" &>/dev/null &disown
# }

## prepare tempfile name and clean up with trap on exit
## \"-u\" will not actually create a file but just the name
# TEMPFILE=\"\$(mktemp -u \"/tmp/${SCRIPTNAME%.*}.XXXXXXXXXX\")\"
# trap \"rm -f \${TEMPFILE}\" EXIT
${CONFPROFILESELECT}
# if ! \${EXAMPLE} ; then
#     error \"you \$(_bold \"must\") set \$(_orange_on_grey \"-e\")!\"
# fi

# if \${BASHHINTS} ; then
#     . ~/bin/bash_hints.sh
#     exit 0
# fi

# # check for running processes
# if [[ \$(pgrep -u \${USERNAME} \"someapp\") ]] ; then
#     warning \"'someapp' appears to be running!\"
# fi

# # back to the directory where we started
# cd \"\${OLDWD}\"
### END SCRIPT BODY ###

exit 0"

write_new_file "${FULLSCRIPTPATH}" "${SCRIPTCONTENT}"
chmod +x "${FULLSCRIPTPATH}"

# bootstrap initial shared files
init_shared "$(eval echo ${BSSHAREDIR})"

if ${LINKSCRIPT} ; then
  link_script "${SCRIPTNAME}" "${SCRIPTPATH}" "${SCRIPTLINKPATH}"
fi

if ${EDITSCRIPT} ; then
  ${VISUAL:-${EDITOR:-vi}} "${FULLSCRIPTPATH}" || error "unable to edit configuration file!"
fi

exit 0
