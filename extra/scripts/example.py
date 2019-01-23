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
