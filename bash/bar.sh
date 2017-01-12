#!/bin/bash
#### Description......: Fancy progress bar with many styles and colors to choose.
#### Written by.......: Sotirios Roussis (aka. xtonousou) - xtonousou@gmail.com on 01-2017

# Bar parts.
FCHARS=''
ECHARS=''

# Bar style.
STYLE=1 # Default value

# Colors
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[1;32m"
YELLOW="\e[0;33m"
BLUE="\e[1;34m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
WHITE="\e[0;37m"
NORMAL="\e[1;0m"

function show_usage() {

  echo    " usage..: bar [arg1] [arg2] [arg3] [arg4]"
  echo    "  arg1..: [0-100] | 'help | HELP | -h | --help' to show this help message"
  echo    "  arg2..: [color]"
  echo    "          'black | BLACK | red | RED | green | GREEN | yellow | YELLOW | blue | BLUE"
  echo    "           purple | PURPLE | cyan | CYAN | white | WHITE'"
  echo    "  arg3..: [style]"
  echo    "  arg4..: 'percentage | percent | PERCENTAGE | PERCENT | %' (optional)"
  echo    " colors.:"
  echo -e "  black.: ${BLACK}◼${NORMAL}  red...: ${RED}◼${NORMAL}  green.: ${GREEN}◼${NORMAL}"
  echo -e "  yellow: ${YELLOW}◼${NORMAL}  blue..: ${BLUE}◼${NORMAL}  purple: ${PURPLE}◼${NORMAL}"
  echo -e "  cyan..: ${CYAN}◼${NORMAL}  white.: ${WHITE}◼${NORMAL}"
  echo    " styles.: bar styles | bar STYLES | bar -s | bar --styles"
  echo    " example: bar 80 red 5 percent"

  exit 0
}

function show_styles() {

  echo " # |------ FULL ------| |------ EMPTY -----|"

  bar_style 0
  echo -n " 0 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 1
  echo -n " 1 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 2
  echo -n " 2 "
  echo -n "${FCHARS} "
  echo    "${ECHARS}"

  bar_style 3
  echo -n " 3 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 4
  echo -n " 4 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 5
  echo -n " 5 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 6
  echo -n " 6 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 7
  echo -n " 7 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 8
  echo -n " 8 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"

  bar_style 9
  echo -n " 9 "
  echo -n "${FCHARS} "
  echo    "          ${ECHARS}"
  
  exit 0
}

function bar_style() {

  case "$1" in
    0)
      FCHARS='..........'
      ECHARS='          '
    ;;
    1)
      FCHARS='##########'
      ECHARS='          '
    ;;
    2)
      FCHARS='⚫⚫⚫⚫⚫⚫⚫⚫⚫⚫'
      ECHARS='⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪'
    ;;
    3)
      FCHARS='⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿'
      ECHARS='⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀'
    ;;
    4)
      FCHARS='▰▰▰▰▰▰▰▰▰▰'
      ECHARS='▱▱▱▱▱▱▱▱▱▱'
    ;;
    5)
      FCHARS='██████████'
      ECHARS='░░░░░░░░░░'
    ;;
    6)
      FCHARS='██████████'
      ECHARS='▁▁▁▁▁▁▁▁▁▁'
    ;;
    7)
      FCHARS='▮▮▮▮▮▮▮▮▮▮'
      ECHARS='▯▯▯▯▯▯▯▯▯▯'
    ;;
    8)
      FCHARS='◼◼◼◼◼◼◼◼◼◼'
      ECHARS='◻◻◻◻◻◻◻◻◻◻'
    ;;
    9)
      FCHARS='◼◼◼◼◼◼◼◼◼◼'
      ECHARS='▭▭▭▭▭▭▭▭▭▭'
    ;;
  esac
}

function main() {

  case "$1" in
    "help"|"HELP"|"-h"|"--help") show_usage ;;
    "styles"|"STYLES"|"-s"|"--styles") show_styles ;;
    "") show_usage ;;
  esac

  # Excludes everything except numbers from 0 to 9.
  if [[ ! "$1" =~ ^-?[0-9]+$ ]]; then echo "Input should be an integer from 0 to 100" && exit 1; fi
  # Limits user input to {0..100}.
  if [[ "$1" -lt 0 ]] || [[ "$1" -gt 100 ]]; then echo "Invalid values passed" && exit 1; fi

  if [[ ! -z "$3" ]]; then
    case "$3" in
      "styles") show_styles ;;
      0) STYLE=0 ;;
      1) STYLE=1 ;;
      2) STYLE=2 ;;
      3) STYLE=3 ;;
      4) STYLE=4 ;;
      5) STYLE=5 ;;
      6) STYLE=6 ;;
      7) STYLE=7 ;;
      8) STYLE=8 ;;
      9) STYLE=9 ;;
      *) show_styles ;;
    esac
  fi
  
  PERCENT="$1"

  # Create fancy bar.
  F=$((PERCENT/10))
  E=$((10-F))
  bar_style "${STYLE}"
  BAR="${FCHARS:0:F}${ECHARS:0:E}"

  # Color options.
  if [[ -z "$2" ]]; then BAR="${BAR}"
  else
    case "$2" in
      "black"|"BLACK")
        BAR="${BLACK}${BAR}${NORMAL}"
      ;;
      "red"|"RED")
        BAR="${RED}${BAR}${NORMAL}"
      ;;
      "green"|"GREEN")
        BAR="${GREEN}${BAR}${NORMAL}"
      ;;
      "yellow"|"YELLOW")
        BAR="${YELLOW}${BAR}${NORMAL}"
      ;;
      "blue"|"BLUE")
        BAR="${BLUE}${BAR}${NORMAL}"
      ;;
      "purple"|"PURPLE")
        BAR="${PURPLE}${BAR}${NORMAL}"
      ;;
      "cyan"|"CYAN")
        BAR="${CYAN}${BAR}${NORMAL}"
      ;;
      "white"|"WHITE")
        BAR="${WHITE}${BAR}${NORMAL}"
      ;;
      "default"|"normal"|"DEFAULT"|"NORMAL")
        BAR="${NORMAL}${BAR}"
      ;;
      *)
        BAR="${BAR}"
      ;;
    esac
  fi

  if [[ ! -z "$4" ]]; then
    case "$4" in
      "percentage"|"percent"|"PERCENT"|"PERCENTAGE"|"%")
        BAR="${BAR} ${PERCENT}%"
      ;;
      *) show_usage ;;
    esac
  fi

  echo -e "${BAR}"
}

main "$1" "$2" "$3" "$4"
