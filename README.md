# SciJava log handler for Python :snake::coffee::bookmark_tabs:

A very thin Python package (mavenized for [ImageJ2][imagej]) to use the
[SciJava][gh_scijava] [LogService][gh_sj_logservice] as a handler for
[Python's logging facility][py_logging]. See the wiki page about
[Logging][ij_logging] for more details about ImageJ's logging framework.

Developed and provided by the [Imaging Core Facility (IMCF)][imcf] of the
Biozentrum, University of Basel, Switzerland.

# Example usage

The snippet below demonstrates how to use the handler in an ImageJ2 Python
script utilizing the fabulous [Script Parameters][ij_script_params] for
retrieving the LogService instance.

```Python
#@ LogService sjlogservice

from sjlogging.logger import setup_scijava_logger
from sjlogging.setter import set_loglevel


def log_messages(level):
    log.critical("+++ new round of messages (level %s) +++" % level)
    set_loglevel(level)
    log.debug('debug log message')
    log.info('info log message')
    log.warn('warn log message')
    log.error('error log message')
    log.critical('critical log message')
    log.critical("--- finished round of messages (level %s) ---" % level)


log = setup_scijava_logger(sjlogservice)

log_messages('WARNING')
log_messages('INFO')
log_messages('DEBUG')
log_messages('WARNING')
```

Running this code from ImageJ will result in the following messages being
printed to the console or the *Log* window, depending on how you launch ImageJ:

```
[Fri Jan  5 12:25:15 CET 2018] [ERROR] +++ new round of messages (level WARNING) +++
[Fri Jan  5 12:25:15 CET 2018] [WARNING] warn log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] error log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] critical log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] --- finished round of messages (level WARNING) ---
[Fri Jan  5 12:25:15 CET 2018] [ERROR] +++ new round of messages (level INFO) +++
[Fri Jan  5 12:25:15 CET 2018] [INFO] info log message
[Fri Jan  5 12:25:15 CET 2018] [WARNING] warn log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] error log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] critical log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] --- finished round of messages (level INFO) ---
[Fri Jan  5 12:25:15 CET 2018] [ERROR] +++ new round of messages (level DEBUG) +++
[Fri Jan  5 12:25:15 CET 2018] [DEBUG] debug log message
[Fri Jan  5 12:25:15 CET 2018] [INFO] info log message
[Fri Jan  5 12:25:15 CET 2018] [WARNING] warn log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] error log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] critical log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] --- finished round of messages (level DEBUG) ---
[Fri Jan  5 12:25:15 CET 2018] [ERROR] +++ new round of messages (level WARNING) +++
[Fri Jan  5 12:25:15 CET 2018] [WARNING] warn log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] error log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] critical log message
[Fri Jan  5 12:25:15 CET 2018] [ERROR] --- finished round of messages (level WARNING) ---
```


[imcf]: https://www.biozentrum.unibas.ch/imcf
[imagej]: https://imagej.net
[ij_logging]: https://imagej.net/Logging
[ij_script_params]: http://imagej.net/Script_Parameters
[py_logging]: https://docs.python.org/2/library/logging.html
[gh_scijava]: https://github.com/scijava
[gh_sj_logservice]: https://github.com/scijava/scijava-common/tree/master/src/main/java/org/scijava/log