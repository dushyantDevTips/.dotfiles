#!/bin/sh

. $(pwd)/constants.sh
. $(pwd)/omz/themes.sh
. $(pwd)/omz/plugins.sh

git_config() 
{
    # Link config
    if [ "$1" = "--link" ]; then
        case $OS in
        "Linux")
            GIT_CONF="$HOME/.gitconfig"
            if [ -f "$GIT_CONF" ]; then
                sudo mv $GIT_CONF $HOME/.gitconfig.pre-config-run.$TIME
            fi
            ln -s $DOTFILES_CONF/.gitconfig $GIT_CONF
            ls -l $DOTFILES_CONF/.gitconfig
            ;;
        *)
            # leave as is
            return
            ;;
        esac
    fi
    # Unlink config
    if [ "$1" = "--unlink" ]; then
        case $OS in
        "Linux")
            GIT_CONF="$HOME/.gitconfig"
            unlink $GIT_CONF
            ;;
        *)
            # leave as is
            return
            ;;
        esac
    fi
}

zsh_config() 
{
    if [ "$1" = "--link" ]; then
        case $OS in
        "Linux")
            ZSH_CONF="$HOME/.zshrc"
            if [ -f "$ZSH_CONF" ]; then
                sudo mv $ZSH_CONF $HOME/.zshrc.pre-config-run.$TIME
            fi
            ln -s $DOTFILES_CONF/.zshrc $ZSH_CONF
            ls -l $DOTFILES_CONF/.zshrc
            ;;
        *)
            # leave as is
            return
            ;;
        esac
    fi
    if [ "$1" = "--unlink" ]; then
        case $OS in
        "Linux")
            ZSH_CONF="$HOME/.zshrc"
            unlink $ZSH_CONF
            ;;
        *)
            # leave as is
            return
            ;;
        esac
    fi
}

omz_config() 
{
    if [ "$1" = "--link" ]; then
        case $OS in
        "Linux")
            OMZ_CUSTOM="$HOME/.oh-my-zsh/custom"
            OMZ_CONF_ALIASES="$OMZ_CUSTOM/alias.zsh"
            OMZ_CONF_FUNCTIONS="$OMZ_CUSTOM/functions.zsh"

            if [ -f "$OMZ_CONF_ALIASES" ]; then
                sudo mv $OMZ_CONF_ALIASES $OMZ_CUSTOM/alias.zsh.pre-config-run.$TIME
            fi
            if [ -f "$OMZ_CONF_FUNCTIONS" ]; then
                sudo mv $OMZ_CONF_FUNCTIONS $OMZ_CUSTOM/functions.zsh.pre-config-run.$TIME

            fi

            # Create symlink for omz alias 
            ln -s $DOTFILES_CONF/.oh-my-zsh/custom/alias.zsh $OMZ_CONF_ALIASES
            ls -l $OMZ_CONF_ALIASES
            
            # Create symlink for omz functions
            ln -s $DOTFILES_CONF/.oh-my-zsh/custom/alias.zsh $OMZ_CONF_FUNCTIONS
            ls -l $OMZ_CONF_FUNCTIONS

            # Clone omz plugins
            printf "$GREEN Installing WakaTime plugin. $NC\n"
            zsh_wakatime
            printf "$GREEN Installing zsh_nvm plugin. $NC\n" 
            zsh_nvm
            printf "$GREEN Installing autosuggestion plugin. $NC\n" 
            zsh_autosuggestions
            printf "$GREEN Installing syntax highlighting plugin. $NC\n" 
            zsh_syntax_highlighting
            ;;
        *)
            # leave as is
            return
            ;;
        esac
    fi
    if [ "$1" = "--unlink" ]; then
        case $OS in
        "Linux")
            OMZ_CUSTOM="$HOME/.oh-my-zsh/custom"
            OMZ_CONF_ALIASES="$OMZ_CUSTOM/alias.zsh"
            OMZ_CONF_FUNCTIONS="$OMZ_CUSTOM/functions.zsh"

            unlink $OMZ_CONF_ALIASES
            unlink $OMZ_CONF_FUNCTIONS
            ;;
        *)
            # leave as is
            return
            ;;
        esac
    fi
}
# TODO Add any config option managed through this file.
list_help() {
    printf "\n$YELLOW_HL Config options.$NC\n"
    printf "$GREEN
    --link or -l (To create symbolic link between config file on .dotfiles project and link location)\n
    --unlink or -u (To remove created symbolic link)
    $NC\n"
    printf "$YELLOW_HL Following configurations are managed by the config.sh script.$NC\n"
    printf "$GREEN
    Git (Version control system),\n 
    Hyper.js (Terminal Emulator),\n 
    zsh (zsh shell configs),\n 
    omz (oh-my-zsh plugins and themes)\n 
    $NC\n"
}

main() {
    # Parse Action
    case $1 in
    -l | --link)
        action="--link"
        ;;
    -u | --unlink)
        action="--unlink"
        ;;
    --help | *)
        list_help
        exit 0
        ;;
    esac
    action=$(echo $action | tr '[:upper:]' '[:lower:]')

    # Parse config arguments
    if [ $# -gt 1 ]; then
        for args in "$@"; do
            args=$(echo $args | tr '[:upper:]' '[:lower:]') # Change input to lowercase
            case $args in
            "git")
                git_config $action
                ;;
            "zsh")
                zsh_config $action
                ;;
            "omz")
                omz_config $action
                ;;
            "p10k")
                p10k_config $action
                ;;
            -l | --link | -u | --unlink | --help)
                # do nothing it is parsed as action
                ;;
            *)
                printf "\n$RED Configuration instruction for \"$args\" dose not exist.$NC\n"
                list_help
                exit 1
                ;;
            esac
        done
    fi
}

main $@
