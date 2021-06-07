#!/bin/bash

act=$1
actinput=$2
actSubInput=$3
subInput1=$4
subInput2=$5

# workingBranch=$(git branch --show-current)

# Confirm Branch feature not yet added, New branch to be added.
gqtBranch () {
    gqtLogo
    if [[ -z $actinput ]]; then
        echo " "
        git branch -a --color
        echo " "
        read -p "Please Enter the branch you with to go to: " branchname
        echo " "
    fi
    case $actinput in
        help)
            printf "[ act ] Bran\n\n"
            printf "   [ actInput ] 'Branch_Name'\n    ~ Include this to switch directly to a new branch.\n\n"
            break
        ;;
        *)
            git checkout ${branchname} || { echo "branch did not exist, please try again."; exit 1; }
        ;;
    esac
}

gqtFinder () {
    case $act in
        bran )
            gqtBranch
        ;;
        help )
            gqtHelp
        ;;
        login )
            gqtLogin
        ;;
        merge )
            gqtMerge
        ;;
        push )
            gqtPush
        ;;
        root )
            gqtRooting
        ;;
    esac
}

gqtHelp () {
    act="Help:"
    actinput="Please follow the instructions bellow."
    gqtLogo
    echo " Please see the list of actions and their coresponding options bellow."
    echo " They are layed out in the following format."
    echo " "
    echo " # [ act ]"
    echo " #  ~ this will explain the purpose of the tool."
    echo " # "
    echo " "
    echo " You can use the act to perform the function or use help for ways to complete in one command."
    echo " "
    printf "\n[ act ] list\n\n"
    printf "   [ act ] 'bran'\n    ~ 'gqt bran' enable you switch branches with ease.\n\n"
    printf "   [ act ] 'login'\n    ~ 'gqt login' enable you to store your credentuals in a file or in temp memory cache.\n\n"
    printf "   [ act ] 'merge'\n    ~ 'gqt merge' enable you switch branches with ease.\n\n"
    printf "   [ act ] 'push'\n    ~ 'gqt push' enables the user to *push* all changes to their repository.\n\n"
    printf "   [ act ] 'root'\n    ~ 'gqt root' enables you to return to the root directory to interact with all sub folders.\n       This when run will returns you back to your original directory location.\n\n"
}

gqtLogin () {
    case $actinput in
        0 )
        actinput="cache"
        ;;
        1 )
        actinput="store"
        ;;
        * )
        ;;
    esac
    gqtLogo
    while true; do
        if [[ -z $actinput ]]; then
            read -p " Would you like to 'store' or 'cache' the details? " actinput
            echo
        else
            case $actinput in
                cache ) 
                    git config credential.helper cache
                    if [[ -z $actSubInput ]]; then
                        read -p " Set an expire time? " actSubInput
                        echo
                    fi
                    case $actSubInput in
                        clear )
                            git credential-cache exit
                        ;;
                        0 )
                        ;;
                        * )
                            git config credential.helper 'cache --timeout=${actSubInput}' || { echo "You actInput '${actSubInput}' was not valid, please only use whole numbers value."; exit 1; }
                        ;;
                    esac
                    break;;
                store )
                    if [[ -z ${actSubInput} ]]; then
                        read -p " Please Enter Your Git UserName  : " gitUser
                        echo
                    else
                        gitUser=${actSubInput}
                    fi
                    if [[ -z ${subInput1} ]]; then
                        read -p " Please Enter Your Git E-mail    : " gitEmail
                        echo
                    else
                        gitEmail=${actSubInput}
                    fi
                    git config --global user.email "${gitEmail}"
                    git config --global user.name "${gitUser}"
                    break;;
                help )
                    printf "[ act ] ${act}\n\n"
                    printf "   [ actInput ] 'store' or '1'\n    ~ Save credentials in a file saved localy.\n\n"
                    printf "   [ store ][ actSubInput ] 'gitUser'\n    ~ Set the UserName for git repository.\n\n"
                    printf "   [ store ][ gitUser ][ subInput1 ] 'gitEmail'\n    ~ Set the Email Address for git repository.\n\n"
                    printf "   [ actInput ] 'cache' or '0'\n    ~ Save them temporal memory cache.\n\n"
                    printf "   [ cache ][ actSubInput ] '0'\n    ~ Store credential in the system untill it is reset.\n\n"
                    printf "   [ cache ][ actSubInput ] >= '1'\n    ~ Provide a whole number to set a cache expire time in seconds.\n\n"
                    printf "   [ cache ][ actSubInput ] 'clear'\n    ~ Clear the current account stored in cache.\n\n"
                    break
                ;;
                * )
                    actinput=""
                    echo "Please answer wish 'cache'/'0' or 'store'/'1'."
                    echo "";;
            esac
        fi
    done
    
}

gqtLogo () {
    printf "\n +-+-+-+\n |G|Q|T|  ~  ${act} ${actinput} ${actSubInput} ${subInput1} ${subInput2}\n +-+-+-+\n\n"
}

# Not yet implemented.
gqtMerge () {
    gqtLogo
    if [[ -z $actinput ]]; then
        echo " "
        echo " Dont know yet..."
        ## read -p "Please Enter the branch you with to go to: " branchname
        echo " "
    fi
    case $actinput in
        help)
            printf "[ act ] ${act}\n\n"
            printf "   [ actInput ] 'Merge_Location'\n    ~ Include this to switch directly to a new branch.\n\n"
            break
        ;;
        *)
            echo " ******** Merge Still needs work."
        ;;
    esac
}

# Not yet implemented.
gqtPush () {
    gqtLogo
    if [[ -z $actinput ]]; then
        echo " "
        git status
        echo " "
        read -p " would you like to submit a 'msg' or use a 'temp'? " actinput
        echo " "
    fi
    case $actinput in
        help)
            printf "[ act ] ${act}\n\n"
            printf "   [ actInput ] 'msg'\n    ~ Send a message no longer than 50 characters long.\n\n"
            printf "   [ msg ][ actSubInput ] '\"Message\"'\n    ~ This is the commit message. It must reside within \" \" to submit.\n\n"
            printf "   [ actInput ] 'temp'\n    ~ This will run a template file then enables you to describe your commit in more detail.\n\n"
            break
        ;;
        msg)
            while true; do
                echo "                      ##################################################"
                read -p "Please Enter Message: " commiting
                commitlength=$( echo -n "${commiting}" | wc -c )
                if [[ ${commitlength} -lt 50 ]]; then
                    break;
                else
                    echo "Please do not exceed limit of '50' characters. Current length = ${commitlength}"
                    echo " "
                fi
            done
        ;;
        temp)
            echo " ******** temp Still needs work."
        ;;
        *)
            echo " ******** Still needs work."
        ;;
    esac
}

gqtRooting () {
    printf "\n +-+-+-+\n |G|Q|T|  ~  Confirm Root Directory.\n +-+-+-+\n\n"
    projectRootDir=false
    while [ $projectRootDir = false ]
    do
        if [ -d '.git' ]
        then
            echo "   - Root directory confirmed in '$(pwd)'."
            act=${actinput}
            actinput=${actSubInput}
            actSubInput=${subInput1}
            subInput1=${subInput2}
            gqtFinder
            $projectRootDir = true
            break
        else
            cd ..
            echo "   - Change Directory: $(pwd)"
            if [ $PWD == $HOME || $PDW == "/" ]
            then
                printf "Unable to confirm root directory in this repository!\n\n"
                break;
            fi
        fi
    done
}

if [[ -n "$(git status --porcelain 2>/dev/null)" ]];
    then
    if [[ -z $act ]]; then
        act="WELCOME:"
        actinput="Please follow the instructions bellow."
        gqtLogo
        echo
        printf " Git Quick Tools enable you to perform many actions. One of which is the ability to perform\n multiple actions at once in a streamline format.\n\n"
        printf " This can be done by including additional inputs that follow \`gqt\`. This is writen as follows:-\n\n"
        printf " $ gqt [ act ] [ actInput ] [ actSubInput ] [ subInput1 ] [ subInput2 ]\n\n"
        printf " To see more the list of actions Git Quick Tools can use, execute the \`gqt help\` act\n to see a list of all possible [ act ]'s that can be applied.\n\n"
        exit;
    else
        gqtFinder
    fi
else
    act="WARNING:"
    actinput="Git Repo Not Found."
    actSubInput="ACTION:"
    subInput1="'gqt' can only be run within a 'git directory', please change to a supported location."
    subInput2=""
    gqtLogo
fi