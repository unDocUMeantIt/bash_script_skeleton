#!/bin/bash
[[ "$1" =~ ^(--version)$ ]] && { 
    echo "2023-06-25";
    exit 0
};

HAVE_INPUT=false
HAVE_OUTPUT=false
OVERWRITE=false
UPDATE=false
REPLACE_DEPS=false
DEP_SECTION_START="### BEGIN DEPENDENCY SECTION ###"
DEP_SECTION_END="### END DEPENDENCY SECTION ###"

USERNAME=$(whoami)
USERHOME="${HOME}"
BSSHAREDIR="${USERHOME}/.config/bash_scripts_${USERNAME}/shared"
# DATE="$(date +%Y-%m-%d_%H-%M-%S)"

# OLDWD="$(pwd)"
# trap "cd ${OLDWD}" EXIT

### BEGIN DEPENDENCY SECTION ###
# use some basic functions from the shared directory
# for usage information, you can run the scripts in bash to define
# the enclosed functions locally, and then the function names after
# "func_" with "-h", "--help", "--version", or no parameter, e.g.
#   warning --help
# minimum version requirements were initially defined during script creation
# run this to manually check for updates of base shared functions:
#   bash_script_skeleton.sh -I -s "${BSSHAREDIR}"
declare -A DEPENDENCIES=(
    # text formatting functions defined in colors_basic.sh:
    # _bifulnc
    # _biulnc (deprecated)
    # 
    # _dgray (+bifulnc)
    # _lgray (+bifulnc)
    # _lred (+bifulnc)
    # _red (+bifulnc)
    # _lblue (+bifulnc)
    # _blue (+bifulnc)
    # _green (+bifulnc)
    # _lpurple (+bifulnc)
    # _purple (+bifulnc)
    # _black (+bifulnc)
    # _brown (+bifulnc)
    # _yellow (+bifulnc)
    # _orange (+bifulnc)
    # _cyan (+bifulnc)
    # _lcyan (+bifulnc)
    # _white (+bifulnc)
    # _green_on_grey (+bifulnc)
    # _orange_on_grey (+bifulnc)
    # _bg_red (+bifulnc)
    # _bg_green (+bifulnc)
    # 
    # _bold
    # _italic
    # _faint
    # _underscore
    # _blink
    # _inverse
    # _concealed (invisible)
    # 
    # _opt (+ifulnc; for option parameter names)
    # _arg (+bfulnc; for option arguments)
    # _path (+bifulnc; for path names)
    # _info (+bifulnc; for general info, e.g., configuration files)
    # _linfo (+bifulnc; for further infos to options, e.g., defaults)
    ["${BSSHAREDIR}/colors_basic.sh"]="colors_basic >= 13"
    ["${BSSHAREDIR}/func_warning.sh"]="warning >= 3"
    ["${BSSHAREDIR}/func_skip.sh"]="skip >= 3"
    ["${BSSHAREDIR}/func_error.sh"]="error >= 3"
    ["${BSSHAREDIR}/func_alldone.sh"]="alldone >= 4"
    ["${BSSHAREDIR}/func_edit_file.sh"]="edit_file >= 1"
    ["${BSSHAREDIR}/func_min_version.sh"]="min_version >= 1"
    ["${BSSHAREDIR}/func_mkmissingdir.sh"]="mkmissingdir >= 7"
    ["${BSSHAREDIR}/func_path_exists.sh"]="path_exists >= 4"
    ["${BSSHAREDIR}/func_usage.sh"]="usage >= 6"
    # appends given text as a new line to given file
    #   usage: appendconfig [path] [grep] [body] (extra)
    #    [path]:  file name, full path
    #    [grep]:  stuff to grep for in [path] to check whether the entry is already there
    #    [body]:  full line to append to [path] otherwise
    #    (extra): the key word "sudo" if sudo is needed for the operation, "config" to silence skips
    ["${BSSHAREDIR}/func_appendconfig.sh"]="appendconfig >= 8"
    ["${BSSHAREDIR}/func_check_tool.sh"]="check_tool >= 3"
    ["${BSSHAREDIR}/func_check_shared_script.sh"]="check_shared_script >= 10"
    ["${BSSHAREDIR}/func_dependency_section.sh"]="dependency_section >= 1"
    ["${BSSHAREDIR}/func_function_body.sh"]="function_body >= 2"
    ["${BSSHAREDIR}/func_link_script.sh"]="link_script >= 5"
    ["${BSSHAREDIR}/func_write_new_file.sh"]="write_new_file >= 2"
    ["${BSSHAREDIR}/func_yesno.sh"]="yesno >= 1"
)
# use check_shared_script to add your own shared functions;
# keep in mind they need to support both ^(-h|--help)$ and ^(-v|--version)$ parameters!
[[ "$1" =~ ^(--dependencies)$ ]] && {
    for i in ${!DEPENDENCIES[@]} ; do
      echo "${i} (${DEPENDENCIES[${i}]%% >=*} >= ${DEPENDENCIES[${i}]##*>= })"
    done
    exit 0
}
# now source the files needed in this script
for i in ${!DEPENDENCIES[@]} ; do
  [[ -f "${i}" ]] \
    || bash_script_skeleton.sh -I -s "${BSSHAREDIR}" || exit 1
  . "${i}" || exit 1
  [[ $(${DEPENDENCIES[${i}]%% >=*} --version) -ge $(echo ${DEPENDENCIES[${i}]##*>= }) ]] \
    || bash_script_skeleton.sh -I -s "${BSSHAREDIR}" || exit 1
done
unset i
# check for minimum version requirements
# min_version "bash_script_skeleton.sh" "--version" "2023-04-04"
### END DEPENDENCY SECTION ###
check_tool "sed" "$(which sed)"

if [[ "$1" =~ ^(-h|--help)$ || "$1" == "" ]] ; then
  echo -e "
  $(usage usage "${0##*/}" "[OPTIONS]")

  $(usage sect "OPTIONS")
    $(usage opt "-i" "<path>"   "script file to work on")
    $(usage opt "-o" "<path>"   "output file to write results to")
                                $(usage info "if missing will print to stdout")

    $(usage opt "-s" "<text>"   "marker that signals the beginning of the dependency section")
                                $(usage default "$(_blue "${DEP_SECTION_START}")")
    $(usage opt "-e" "<text>"   "marker that signals the end of the dependency section")
                                $(usage default "$(_blue "${DEP_SECTION_END}")")

    $(usage opt "-O" ""         "overwrite existing output file")
    $(usage opt "-U" ""         "update an outdated dependency section")
                                $(usage info "instead of a static replacement")

    $(usage conf "" "--version" "--dependencies")
"
  exit 0
fi

# get the options
while getopts ":i:o:s:e:OU" OPT; do
    case $OPT in
        i) HAVE_INPUT=true >&2
           IN_SCRIPT="${OPTARG}" >&2
           ;;
        o) HAVE_OUTPUT=true >&2
           OUT_SCRIPT="${OPTARG}" >&2
           ;;
        s) DEP_SECTION_START="${OPTARG}" >&2
           ;;
        e) DEP_SECTION_END="${OPTARG}" >&2
           ;;
        O) OVERWRITE=true >&2
           ;;
        U) UPDATE=true >&2
           ;;
        \?)
           error "Invalid option: $(_bold "-${OPTARG}")" >&2
           ;;
        :)
           error "Option $(_bold "-${OPTARG}") requires an argument." >&2
           ;;
    esac
done

if ! ${HAVE_INPUT} ; then
    error "you $(_bold "must") set $(_orange_on_grey "-i")!"
fi

if ! [ -f ${IN_SCRIPT} ] ; then
    error "file does not exist: $(_blue "${IN_SCRIPT}")!"
fi

if ! [[ $(grep "${DEP_SECTION_START}" "${IN_SCRIPT}") ]] || ! [[ $(grep "${DEP_SECTION_END}" "${IN_SCRIPT}") ]] ; then
    error "file $(_blue "${IN_SCRIPT}") does not contain a marked dependency section!"
fi

# using cut to only fetch the first value in each line
DEP_LIST=$(${IN_SCRIPT} --dependencies | cut -d " " -f1)

if ! [[ "${DEP_LIST}" ]] ; then
    error "file $(_blue "${IN_SCRIPT}") does not seem to have any detected dependencies!"
fi

echo -e "detected dependencies of script file $(_blue "${IN_SCRIPT}"):"
for i in ${DEP_LIST} ; do
    echo -e "  $(_blue "${i}")"
done

if ${UPDATE} ; then
    DEPENDENCIES_ARRAY=(${DEP_LIST})
    DEP_REPLACEMENT=$(dependency_section DEPENDENCIES_ARRAY "\${BSSHAREDIR}")
else
    DEP_REPLACEMENT=$(
        for i in ${DEP_LIST} ; do
            echo -e "### BEGIN DEPENDENCY FILE ${i##*/} ###";
            # remove shebang, version comment, edit comment and empty lines before script starts
            sed -e '/^#!/d' -e '/^# version/d' -e '/^# DO NOT EDIT THIS FILE/d' -e '/./,$!d' "${i}";
            echo -e "### END DEPENDENCY FILE ${i##*/} ###\n";
        done
    )
fi

BEFORE_DEP_SECTION="$(sed -e "/^${DEP_SECTION_START}$/Q" ${IN_SCRIPT})"
AFTER_DEP_SECTION="$(sed -e "1,/^${DEP_SECTION_END}$/d" ${IN_SCRIPT})"

NEWSCRIPT="${BEFORE_DEP_SECTION}

${DEP_SECTION_START}
${DEP_REPLACEMENT}
${DEP_SECTION_END}

${AFTER_DEP_SECTION}"

if ${HAVE_OUTPUT} ; then
    if ! [ -f "${OUT_SCRIPT}" ] || ${OVERWRITE} ; then
        echo "${NEWSCRIPT}" > "${OUT_SCRIPT}" || error "can't write to file $(_blue "${OUT_SCRIPT}")!"
        chown --reference="${IN_SCRIPT}" "${OUT_SCRIPT}"
        chmod --reference="${IN_SCRIPT}" "${OUT_SCRIPT}"
    else
        error "file $(_blue "${OUT_SCRIPT}") exists and overwrite not requested!"
    fi
else
    echo "${NEWSCRIPT}"
fi

exit 0
