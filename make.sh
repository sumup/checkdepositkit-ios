#!/bin/sh
set -e

readonly WORKING_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Prompty user for information

echo "Please enter the name of your module:"
read NAME
echo "Please enter a brief summary of your module:"
read SUMMARY
echo "Please enter your name, as the author:"
read AUTHOR
echo "Please enter your team name, as the codeowner (eg: @sumup/online-payments-bifrost):"
read CODEOWNER

read YEAR MONTH DAY <<<$(date +'%Y %m %d')

GIT_PATH=$(git remote -v | grep fetch | sed 's/origin\tgit@github.com://' | sed 's/ (fetch)//')

echo

# Trim spaces in APP_NAME
readonly NAME_NO_SPACES=$(echo "$NAME" | sed "s/ //g")

# Rename files structure
echo ">>> 🔎 Replacing files structure"

## user define function
rename(){
    local DIR=$1
    local NEW_DIR=$2
    mv $DIR $NEW_DIR
}

readonly NAME_PLACEHOLDER="{{NAME}}"
readonly SUMMARY_PLACEHOLDER="{{SUMMARY}}"
readonly AUTHOR_PLACEHOLDER="{{AUTHOR}}"
readonly GIT_PATH_PLACEHOLDER="{{GIT_PATH}}"
readonly DAY_PLACEHOLDER="{{DAY}}"
readonly MONTH_PLACEHOLDER="{{MONTH}}"
readonly YEAR_PLACEHOLDER="{{YEAR}}"

rename "${NAME_PLACEHOLDER}" "${NAME_NO_SPACES}"
rename "${NAME_PLACEHOLDER}.podspec" "${NAME_NO_SPACES}.podspec"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}/AuthTokenProvider+${NAME_PLACEHOLDER}.swift" "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}/AuthTokenProvider+${NAME_NO_SPACES}.swift"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}" "${NAME_PLACEHOLDER}SampleApp/${NAME_NO_SPACES}"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj/xcshareddata/xcschemes/${NAME_PLACEHOLDER}SampleApp.xcscheme" "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj/xcshareddata/xcschemes/${NAME_NO_SPACES}SampleApp.xcscheme"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj/xcshareddata/xcschemes/${NAME_PLACEHOLDER}SnapshotTests.xcscheme" "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj/xcshareddata/xcschemes/${NAME_NO_SPACES}SnapshotTests.xcscheme"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj/xcshareddata/xcschemes/${NAME_PLACEHOLDER}UnitTests.xcscheme" "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj/xcshareddata/xcschemes/${NAME_NO_SPACES}UnitTests.xcscheme"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SampleApp.xcodeproj" "${NAME_PLACEHOLDER}SampleApp/${NAME_NO_SPACES}SampleApp.xcodeproj"
rename "${NAME_PLACEHOLDER}SampleApp.xcworkspace" "${NAME_NO_SPACES}SampleApp.xcworkspace"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}SnapshotTests" "${NAME_PLACEHOLDER}SampleApp/${NAME_NO_SPACES}SnapshotTests"
rename "${NAME_PLACEHOLDER}SampleApp/${NAME_PLACEHOLDER}UnitTests" "${NAME_PLACEHOLDER}SampleApp/${NAME_NO_SPACES}UnitTests"
rename "${NAME_PLACEHOLDER}SampleApp" "${NAME_NO_SPACES}SampleApp"

# Search and replace in files
echo ">>> 🔎 Replacing placeholders within files..."
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s/${NAME_PLACEHOLDER}/${NAME}/g" {} +
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s/${SUMMARY_PLACEHOLDER}/${SUMMARY}/g" {} +
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s/${AUTHOR_PLACEHOLDER}/${AUTHOR}/g" {} +
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s/${DAY_PLACEHOLDER}/${DAY}/g" {} +
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s/${MONTH_PLACEHOLDER}/${MONTH}/g" {} +
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s/${YEAR_PLACEHOLDER}/${YEAR}/g" {} +
LC_ALL=C find $WORKING_DIR -not -path '*/\.git*' -type f -exec sed -i "" "s;${GIT_PATH_PLACEHOLDER};${GIT_PATH};g" {} +
echo ">>> ✅  Completed"

echo ">>> 💎 Installing gems"
bundle install
echo ">>> 🧩 Installing submodules"
git submodule update --init --recursive
echo ">>> 🍫 Installing pod dependencies"
bundle exec pod install --repo-update

# Update scripts
echo ">>> 🗑  Removing script files"
rm -rf make.sh
mv github .github
echo "* $CODEOWNER" > ".github/CODEOWNERS"

echo ">>> ✅  Completed"
