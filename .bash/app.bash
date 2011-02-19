function app {
  if [ "$1" = "restart" ]; then
    touch tmp/restart.txt
  elif [ "$1" = "open" ]; then
    cur_dir=`pwd`
    app_name=`basename $cur_dir`
    url="http://$app_name.local"
    open -a Safari $url
  elif [ "$1" = "mate" ]; then
    cur_dir=`pwd`
    app_name=`basename $cur_dir`
    project_location="/Users/acarpen/Documents/Projects/$app_name.tmproj"
    if [ -e "$project_location" ]; then
      open $project_location
    else
      mate app/ config/ db/ doc/ lib/ public/ test/ spec/ README Gemfile Rakefile
    fi
  elif [ "$1" = "log" ]; then
    tail -n 200 -f log/development.log
  elif [ "$1" = "apache_access_log" ]; then
    tail -n 200 -f /var/log/apache2/access_log
  elif [ "$1" = "apache_error_log" ]; then
    tail -n 200 -f /var/log/apache2/error_log
  else
    LOCATION=`~/.bash/app-location.rb $1`
    if [ "$LOCATION" = "" ]; then
      echo "application '$1' not found; add using the passenger preference pane."
    else
      cd $LOCATION
    fi
  fi
}