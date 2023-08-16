# Validation script for 11747 assignment. The zipped file should contain
#   - github-url.txt
#   - dev_results.txt
#   - test_results.txt
#   - report.pdf
#
# The structure of the folder should be
# assignment1 (github repo name)
# ├── github-url.txt
# ├── dev_results.txt
# ├── test_results.txt
# └── report.pdf
#
# usage:
#   bash submission_validator.sh [zip_file]

RED='\033[0;31m'
NC='\033[0m' # No Color
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
GREEN='\033[0;32m'

# For Mac OS users
# zip -d $1 __MACOSX/\*
# zip -d $1 \*/.DS_Store

unzip -qq $1 -d .11731tmp
curdir=$PWD
cd .11731tmp/*
allpass=1

function checkfile {
    if test -f $1; then
      printf "${GREEN}[INFO]${NC}: $1 is included.\n"
    else
      allpass=0
      printf "${RED}[ERROR]${NC}: $1 is not included, please check!\n"
    fi
}

function checkgithub {
    if test -f $1; then
      printf "${GREEN}[INFO]${NC}: $1 is included.\n"
      if [[ $(grep git github-url.txt | wc -l) -lt 1 ]]; then
        allpass=0
        printf "${RED}[ERROR]${NC}: $1 does not contain a github address.\n"
      fi
    else
      allpass=0
      printf "${RED}[ERROR]${NC}: $1 is not included, please check!\n"
    fi
}

function computeacc {
    while IFS= read -r lineA && IFS= read -r lineB <&3; do
      echo "$lineA"; echo "$lineB"
    done <$1 3<$2
}

computeacc dev_result topicclass_valid.txt

checkfile report.pdf
checkgithub github-url.txt
checkfile dev_results.txt
checkfile test_results.txt

cd $curdir
rm -rf .11731tmp

if [[ $allpass -eq 1 ]]; then
  printf "${GREEN}[INFO]${NC}: All the files are included! Please submit the zip file on canvas.\n"
fi 
