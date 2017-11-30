#!/bin/sh

{{ ansible_managed | comment  }}

### BEGIN INIT INFO
# Provides:          crowd
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Initscript for Atlassian Crowd
# Description:  Automatically start Atlassian Crowd when the system starts up.
#               Provide commands for manually starting and stopping Crowd.
### END INIT INFO

# Based on script at http://www.bifrost.org/problems.html

RUN_AS_USER={{ atlassian_crowd_user }}
CATALINA_HOME="{{ atlassian_crowd_dir }}/apache-tomcat"

start() {
    echo "Starting Crowd: "
    if [ "x$USER" != "x$RUN_AS_USER" ]; then
        su - $RUN_AS_USER -c "$CATALINA_HOME/bin/startup.sh"
    else
        $CATALINA_HOME/bin/startup.sh
    fi
    echo "done."
}
stop() {
    echo "Shutting down Crowd: "
    if [ "x$USER" != "x$RUN_AS_USER" ]; then
        su - $RUN_AS_USER -c "$CATALINA_HOME/bin/shutdown.sh"
    else
        $CATALINA_HOME/bin/shutdown.sh
    fi
    echo "done."
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        sleep 10
        #echo "Hard killing any remaining threads.."
        #kill -9 `cat $CATALINA_HOME/work/catalina.pid`
        start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
esac

exit 0

