##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = 'a504f7bf5628d8ace769e43582ffaa9245d3fdfb'
AESD_ASSIGNMENTS_SITE = 'https://github.com/cu-ecen-aeld/assignments-3-and-later-leeyunhome.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/
	if [ ! -f $(TARGET_DIR)/etc/passwd ]; then \
		echo "root:x:0:0:root:/root:/bin/sh" > $(TARGET_DIR)/etc/passwd ; \
		echo "daemon:x:1:1:daemon:/usr/sbin:/bin/sh" >> $(TARGET_DIR)/etc/passwd ; \
		echo "bin:x:2:2:bin:/bin:/bin/sh" >> $(TARGET_DIR)/etc/passwd ; \
		echo "default:x:1000:1000:Default user:/home/default:/bin/sh" >> $(TARGET_DIR)/etc/passwd ; \
	fi
	echo 'root:$$6$$aesd$$7vCUVe2npOcrcMLEF6okFwsYTapf.BWvV8.6j0ZfZsYkwzSOGudZ4HUYAYPP5wYychxEZsBDR/ILY/ZxK3cGk1:10933:0:99999:7:::' > $(TARGET_DIR)/etc/shadow
	echo "daemon:*::0:99999:7:::" >> $(TARGET_DIR)/etc/shadow
	echo "bin:*::0:99999:7:::" >> $(TARGET_DIR)/etc/shadow
	echo "default:*::0:99999:7:::" >> $(TARGET_DIR)/etc/shadow
	if [ ! -f $(TARGET_DIR)/etc/group ]; then \
		echo "root:x:0:" > $(TARGET_DIR)/etc/group ; \
		echo "daemon:x:1:" >> $(TARGET_DIR)/etc/group ; \
		echo "bin:x:2:" >> $(TARGET_DIR)/etc/group ; \
		echo "default:x:1000:" >> $(TARGET_DIR)/etc/group ; \
	fi
	if [ ! -f $(TARGET_DIR)/etc/hosts ]; then \
		echo -e "127.0.0.1\tlocalhost\n127.0.1.1\tbuildroot" > $(TARGET_DIR)/etc/hosts ; \
	fi
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/finder-app/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/ 2>/dev/null || true
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
	$(INSTALL) -d 0755 $(TARGET_DIR)/bin/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin/ 2>/dev/null || true
endef

$(eval $(generic-package))
