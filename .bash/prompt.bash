function parse_git_branch {
  [ -d .git ] || return 1
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
state="*"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
remote="↑"
    else
remote="↓"
    fi
fi
if [[ ${git_status} =~ ${diverge_pattern} ]]; then
remote="↕"
  fi
if [[ ${git_status} =~ ${branch_pattern} ]]; then
branch=${BASH_REMATCH[1]}
    echo " <${branch}${state}${remote}>"
  fi
}

export PS1='[\h] \[\033[0;32m\]\w\[\033[0;35m\]$(parse_git_branch)\[\033[0;m\]\[\033k\033\\\]\$ '