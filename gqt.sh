#!/bin/bash

act=$1
actinput=$2
actsubin=$3
actsubi2=$4

gqtHelp () {
    echo " "
    echo " +-+-+-+"
    echo " |G|Q|T|  ~  Welcome, please follow the instructions bellow."
    echo " +-+-+-+"
    echo " "
    echo " Please see the list of actions and their coresponding options bellow."
    echo " They are layed out in the following format."
    echo " "
    echo " # [ action ]"
    echo " #  ~ this will explain the purpose of the tool."
    echo " # "
    echo " "
    echo " You can use the action to perform the function or use help for ways to complete in one command."
    echo " "
    echo " ***********************************************************************************************"
    echo " ***************************************** Action List *****************************************"
    echo " ***********************************************************************************************"
    echo " "
    echo " # [ push ]"
    echo " #  ~ 'gqt -push' enables the user to *push* all changes to their repository."
    echo " # "
    echo " "
    echo " # [ bran ]"
    echo " #  ~ This will enable you switch branches with ease."
    echo " # "
    # echo " "
    # echo " # [ merge ]"
    # echo " #  ~ This will enable you switch branches with ease."
    # echo " # "
    echo " "
    echo " # [ login ]"
    echo " #  ~ This will enable you to store your credentuals in a file or in temp memory cache."
    echo " # "
}

gqtPush () {
    echo " "
    echo " +-+-+-+"
    echo " |G|Q|T|  ~  Push ${actinput} ${subinput}"
    echo " +-+-+-+"
    if [ -z $actinput ]; then
        echo " "
        git status
        echo " "
        ## read -p "Please Enter the branch you with to go to: " branchname
        echo " "
    fi
    case $actinput in
        help)
            echo " # "
            echo " # *[ msg ]"
            echo " # ** ~ Submit a message capped to a length no longer than 50 characters."
            echo " # "
            echo " # **[ \"message\" ]"
            echo " # ** ~ This is the message that is to be used during the commit stages. The message must reside in \" \""
            echo " # "
            echo " # **[ temp ]"
            echo " # ** ~ This will run a template file then enables you to describe your commit in more detail."
            echo " # "
            echo " "
        ;;
        msg)
            echo " ******** msg Still needs work."
        ;;
        temp)
            echo " ******** temp Still needs work."
        ;;
        *)
            echo " ******** Still needs work."
        ;;
    esac
}

gqtBranch () {
    echo " "
    echo " +-+-+-+"
    echo " |G|Q|T|  ~  Branch ${actinput} ${subinput}"
    echo " +-+-+-+"
    if [ -z $actinput ]; then
        echo " "
        git branch -a --color
        echo " "
        read -p "Please Enter the branch you with to go to: " branchname
        echo " "
    fi
    case $actinput in
        help)
            echo " # "
            echo " # *[ Branch_Name ]"
            echo " # * ~ Include this to switch directly to a new branch."
            echo " # "
        ;;
        *)
            git checkout ${branchname} || echo "branch did not exist, please try again." exit 1
        ;;
    esac
}

gqtMerge () {
    echo " "
    echo " +-+-+-+"
    echo " |G|Q|T|  ~  Merge ${actinput} ${subinput}"
    echo " +-+-+-+"
    if [ -z $actinput ]; then
        echo " "
        echo " Dont know yet..."
        ## read -p "Please Enter the branch you with to go to: " branchname
        echo " "
    fi
    case $actinput in
        help)
            echo " # "
            echo " # *[ Merge_Location ]"
            echo " # ** ~ Submit a message capped to a length no longer than 50 characters."
            echo " # "
            # echo " # **[ \"message\" ]"
            # echo " # ** ~ This is the message that is to be used during the commit stages. The message must reside in \" \""
            # echo " # "
            # echo " # **[ temp ]"
            # echo " # ** ~ This will run a template file then enables you to describe your commit in more detail."
            # echo " # "
            # echo " "
        ;;
        *)
            echo " ******** Merge Still needs work."
        ;;
    esac
}

gqtLogin () {
    echo " "
    echo " +-+-+-+"
    echo " |G|Q|T|  ~  login  ${actinput} ${subinput}"
    echo " +-+-+-+" 
    while true; do
        if [ -z $actinput ]; then
            echo " "
            read -p " Would you like to 'store' or 'cache' the details? " actinput
        else
            case $actinput in
                cache | 0 ) 
                    git config credential.helper cache
                    if [ -z $actsubin ]; then
                        echo " "
                        read -p " Set an expire time? " actsubin
                    fi
                    case $actsubin in
                        help)
                            echo " # "
                            echo " # *[ store | 1 ]"
                            echo " # * ~ Save credentuals localy in a file."
                            echo " # "
                            echo " # *[ cache | 0 ]"
                            echo " # * ~ Save them localy in memory cache."
                            echo " # "
                            echo " # **[ 0 ]"
                            echo " # ** ~ Store in cache until system reset."
                            echo " # "
                            echo " # **[ intager value ]"
                            echo " # ** ~ Provide a expire time in seconds."
                            echo " #"
                            echo " # **[ clear ]"
                            echo " # ** ~ Provide a expire time in seconds."
                            echo " "
                        ;;
                        clear)
                            git credential-cache exit
                        ;;
                        0)
                        ;;
                        *)
                            git config credential.helper 'cache --timeout=${actsubin}' || echo "input was not valid, please only use whole numbers value."
                        ;;
                    esac
                    echo " "
                    break;;
                store | 1 )
                    echo " "
                    read -p " Please Enter Your Git UserName: " gitUser
                    read -p " Please Enter Your Git Email:    " gitEmail
                    echo ""
                    git config --global user.email "${gitUser}"
                    git config --global user.name "${gitEmail}"
                    break;;
                * )
                    actinput=""
                    echo "Please answer wish 'cache'/'0' or 'store'/'1'."
                    echo "";;
            esac
        fi
    done
    
}

if [ -n "$(git status --porcelain)" ];
    then
    if [ -z $act ]; then
        echo " "
        echo " +-+-+-+"
        echo " |G|Q|T|  ~  Help. Please follow the instructions bellow."
        echo " +-+-+-+"
        echo " "
        echo " Git Quick Tools enable you to perform many actions. One of which is the"
        echo " ability to perform multiple actions at once in a streamline format."
        echo " "
        echo " This can be done by including additional actions that follow 'gqt'."
        echo " This can be run as 'gqt [action] [input] [actsubin] [actsubi2]'"
        echo " "
        echo " To see more details on how to take advantage of gqt, use the action 'help'"
        echo " "
        exit;
    else
        case $act in
        help )
            gqtHelp
        ;;
        login )
            gqtLogin
        ;;
        push )
            gqtPush
        ;;
        bran )
            gqtBranch
        ;;
        merge )
            gqtMerge
        ;;
        esac
    fi
else
    echo " "
    echo " +-+-+-+"
    echo " |G|Q|T|  ~  Please enter a git directory to interact with the Git Quick Tools."
    echo " +-+-+-+"
    echo " "
fi