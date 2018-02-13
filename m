From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH] Samba RADOS service registration
Date: Tue, 13 Feb 2018 02:25:40 +0100
Message-ID: <20180213022540.5f9686b7@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_//RKHQZl0YSij8whKTvlQsRJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933112AbeBMBZn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:25:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Samba Technical <samba-technical@lists.samba.org>

--MP_//RKHQZl0YSij8whKTvlQsRJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've been working on having Samba's smbd daemon register itself with the
Ceph Cluster via rados_service_register(), and would appreciate some
input on what to include in the instance and metadata descriptors.

The attached patch implements basic Samba service registration
functionality, but only uses a $hostname:smbd string for the instance
and doesn't add any extra metadata (see [1] as a sample service dump).

I'd like to (at the very least) pack the CephFS backed share names and
paths into the service registration. For this, I'm leaning towards
adding the share name as an instance suffix (i.e.
$hostname:smbd:$share), with a separate registration for each share.
Each share could then include the CephFS path as instance specific
metadata. That still leaves me with a few questions:
- does it make sense to only register shares which are backed by CephFS?
  + consider a server with local and CephFS shares, or worse still,
    shared printers
  + what about a Samba service without any shares?
- I'd be using a single RADOS cluster connection to register all
  shares. Can these services can be deregistered individually in case of
  share removal, or are separate cluster connections required?
  + a rados_service_deregister() hook would be useful

Cheers, David

1. Sample Samba smbd service dump with shares ignored

> ceph service dump
{
    "epoch": 2,
    "modified": "2018-02-13 01:53:09.263133",
    "services": {
        "samba": {
            "daemons": {
                "summary": "",
                "rapido1:smbd": {
                    "start_epoch": 2,
                    "start_stamp": "2018-02-13 01:53:08.112102",
                    "gid": 4131,
                    "addr": "192.168.124.104:0/1984347853",
                    "metadata": {
                        "arch": "x86_64",
                        "ceph_version": "ceph version 12.2.1-387-g313479ab90 (313479ab90915289fa4905822d1f4825d1bf1e7c) luminous (stable)",
                        "cpu": "QEMU Virtual CPU version 2.5+",
                        "distro": "dracut",
                        "distro_description": "openSUSE Leap 42.3 dracut-044-29.1 (Initramfs)",
                        "distro_version": "044-29.1",
                        "hostname": "rapido1",
                        "kernel_description": "#21 SMP Tue Feb 13 01:05:27 CET 2018",
                        "kernel_version": "4.4.115+",
                        "mem_swap_kb": "0",
                        "mem_total_kb": "1022828",
                        "os": "Linux"
                    }
                }
            }
        }
    }
}


--MP_//RKHQZl0YSij8whKTvlQsRJ
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-ceph-add-rados-service-integration.patch

From fcbcb4443ed70a84ad04f60d52dc2926479b2ca6 Mon Sep 17 00:00:00 2001
From: David Disseldorp <ddiss@samba.org>
Date: Wed, 7 Feb 2018 14:58:48 +0100
Subject: [PATCH] ceph: add rados service integration

On startup, Samba advertises its presence to the Ceph cluster via
rados_service_register().

Signed-off-by: David Disseldorp <ddiss@samba.org>
---
 source3/smbd/rados_service.c | 147 +++++++++++++++++++++++++++++++++++++++++++
 source3/smbd/rados_service.h |  30 +++++++++
 source3/smbd/server.c        |   7 +++
 source3/wscript              |  10 ++-
 source3/wscript_build        |  12 +++-
 5 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 source3/smbd/rados_service.c
 create mode 100644 source3/smbd/rados_service.h

diff --git a/source3/smbd/rados_service.c b/source3/smbd/rados_service.c
new file mode 100644
index 00000000000..2066c5c6301
--- /dev/null
+++ b/source3/smbd/rados_service.c
@@ -0,0 +1,147 @@
+/*
+   Copyright (C) David Disseldorp 2018
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#include "source3/include/includes.h"
+#include <rados/librados.h>
+#include "rados_service.h"
+
+struct ceph_service_state {
+	rados_t cluster;
+};
+
+static int ceph_service_destroy(struct ceph_service_state *state)
+{
+	DBG_DEBUG("ending Ceph cluster service registration\n");
+	rados_shutdown(state->cluster);
+	return 0;
+}
+
+static int ceph_service_instance_gen(char *buf, size_t buflen,
+				     const char *daemon)
+{
+	int ret;
+	size_t hlen;
+	size_t remain;
+
+	ret = gethostname(buf, buflen);
+	if (ret == -1) {
+		return -errno;
+	}
+	buf[buflen - 1] = '\0';
+	hlen = strlen(buf);
+	remain = buflen - hlen;
+
+	ret = snprintf(buf + hlen, remain, ":%s", daemon);
+	if (ret >= remain) {
+		DBG_ERR("Ceph instance name too long, skipping service "
+			"registration\n");
+		return -ENAMETOOLONG;
+	}
+
+	return 0;
+}
+
+int ceph_service_register(TALLOC_CTX *parent_ctx, const char *daemon)
+{
+	int ret;
+	const char *user_id = NULL;
+	const char *conf_file = NULL;
+	const char *cluster_name = NULL;
+	char instance_buf[HOST_NAME_MAX + 256];
+	const char *md = "";
+	struct ceph_service_state *state = talloc(parent_ctx,
+						struct ceph_service_state);
+
+	if (state == NULL) {
+		return -ENOMEM;
+	}
+
+	/*
+	 * XXX This does not reuse the existing (share based) "ceph:user_id"
+	 * parameter, to allow for:
+	 * - running Samba with Ceph support, but without service registration.
+	 * - future mapping between Samba and Ceph users.
+	 */
+	user_id = lp_parm_const_string(GLOBAL_SECTION_SNUM, "ceph",
+				       "service_user_id", NULL);
+	if (user_id == NULL) {
+		DBG_DEBUG("built with Ceph support, but missing ceph:"
+			  "service_user_id configuration - skipping service "
+			  "registration\n");
+		ret = 0;
+		goto out_mem_free;
+	}
+
+	ret = ceph_service_instance_gen(instance_buf, sizeof(instance_buf),
+					daemon);
+	if (ret < 0) {
+		goto out_mem_free;
+	}
+
+	cluster_name = lp_parm_const_string(GLOBAL_SECTION_SNUM, "ceph",
+					    "cluster_name", NULL);
+	DBG_DEBUG("registering as %s with %s Ceph cluster\n", instance_buf,
+		  (cluster_name != NULL ? cluster_name : "default"));
+
+	ret = rados_create2(&state->cluster, cluster_name, user_id, 0);
+	if (ret < 0) {
+		DBG_ERR("failed to create ceph cluster context\n");
+		goto out_mem_free;
+	}
+
+	conf_file = lp_parm_const_string(GLOBAL_SECTION_SNUM, "ceph",
+					 "config_file", NULL);
+	/* a NULL conf_file sees libceph use the default path */
+	ret = rados_conf_read_file(state->cluster, conf_file);
+	if (ret < 0) {
+		DBG_ERR("failed to parse Ceph cluster config: %s\n",
+			strerror(-ret));
+		goto err_cluster_free;
+	}
+
+	ret = rados_connect(state->cluster);
+	if (ret < 0) {
+		DBG_ERR("failed to connect to ceph cluster\n");
+		goto err_cluster_free;
+	}
+
+	if (strcmp(daemon, "smbd") == 0) {
+		/*
+		 * TODO walk list of shares and add as metadata
+		 * and register for share inventory updates
+		 */
+	}
+
+	/* walk ceph specific shares, and add corresponding metadata */
+	ret = rados_service_register(state->cluster, "samba", instance_buf,
+				     md);
+	if (ret < 0) {
+		DBG_ERR("failed to register service with ceph cluster\n");
+		goto err_cluster_free;
+	}
+
+	/* close cluster conn and drop service listing on server exit */
+	talloc_set_destructor(state, ceph_service_destroy);
+
+	return 0;
+
+err_cluster_free:
+	rados_shutdown(state->cluster);
+out_mem_free:
+	talloc_free(state);
+	return ret;
+}
diff --git a/source3/smbd/rados_service.h b/source3/smbd/rados_service.h
new file mode 100644
index 00000000000..bdc579c9b18
--- /dev/null
+++ b/source3/smbd/rados_service.h
@@ -0,0 +1,30 @@
+/*
+   Copyright (C) David Disseldorp 2018
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#ifndef _RADOS_SERVICE_H
+#define _RADOS_SERVICE_H
+
+int ceph_service_register(TALLOC_CTX *mem_ctx, const char *daemon);
+#if !defined(HAVE_LIBRADOS_SERVICES)
+/* built without librados service support, do nothing */
+int ceph_service_register(TALLOC_CTX *mem_ctx, const char *daemon)
+{
+	return 0;
+}
+#endif
+
+#endif /* _RADOS_SERVICE_H */
diff --git a/source3/smbd/server.c b/source3/smbd/server.c
index 99baf9d519d..88a0b371e13 100644
--- a/source3/smbd/server.c
+++ b/source3/smbd/server.c
@@ -54,6 +54,7 @@
 #include "lib/util/sys_rw.h"
 #include "cleanupdb.h"
 #include "g_lock.h"
+#include "rados_service.h"
 
 #ifdef CLUSTER_SUPPORT
 #include "ctdb_protocol.h"
@@ -1593,6 +1594,7 @@ extern void build_options(bool screen);
 	struct smbd_parent_context *parent = NULL;
 	TALLOC_CTX *frame;
 	NTSTATUS status;
+	int ret;
 	struct tevent_context *ev_ctx;
 	struct messaging_context *msg_ctx;
 	struct server_id server_id;
@@ -2053,6 +2055,11 @@ extern void build_options(bool screen);
 	 * -- bad things will happen if smbd is launched via inetd
 	 *  and we fork a copy of ourselves here */
 	if (is_daemon && !interactive) {
+		ret = ceph_service_register(parent, "smbd");
+		if (ret < 0) {
+			exit_daemon("Samba failed to register with Ceph "
+				    "cluster", -ret);
+		}
 
 		if (rpc_lsasd_daemon() == RPC_DAEMON_FORK) {
 			start_lsasd(ev_ctx, msg_ctx);
diff --git a/source3/wscript b/source3/wscript
index 6d2d94bae87..605bdca6e01 100644
--- a/source3/wscript
+++ b/source3/wscript
@@ -1544,14 +1544,18 @@ main() {
 
     conf.env['CCFLAGS_CEPHFS'] = "-D_FILE_OFFSET_BITS=64"
     if Options.options.libcephfs_dir:
+        conf.env['CPPPATH_RADOS'] = Options.options.libcephfs_dir + '/include'
         conf.env['CPPPATH_CEPHFS'] = Options.options.libcephfs_dir + '/include'
         conf.env['LIBPATH_CEPHFS'] = Options.options.libcephfs_dir + '/lib'
         conf.env['LIBPATH_CEPH-COMMON'] = Options.options.libcephfs_dir + '/lib/ceph'
+        conf.env['LIBPATH_RADOS'] = Options.options.libcephfs_dir + '/lib'
 
     if (Options.options.with_cephfs and
         conf.CHECK_HEADERS('cephfs/libcephfs.h', False, False, 'cephfs') and
+        conf.CHECK_HEADERS('rados/librados.h', False, False, 'rados') and
         conf.CHECK_LIB('cephfs', shlib=True) and
-        conf.CHECK_LIB('ceph-common', shlib=True)):
+        conf.CHECK_LIB('ceph-common', shlib=True) and
+        conf.CHECK_LIB('rados', shlib=True)):
         if Options.options.with_acl_support:
             conf.DEFINE('HAVE_CEPH', '1')
             if conf.CHECK_FUNCS_IN('ceph_statx', 'cephfs ceph-common',
@@ -1561,6 +1565,10 @@ main() {
             Logs.warn("ceph support disabled due to --without-acl-support")
             conf.undefine('HAVE_CEPH')
 
+        if conf.CHECK_FUNCS_IN('rados_service_register', 'rados ceph-common',
+                               headers='rados/librados.h'):
+            conf.DEFINE('HAVE_LIBRADOS_SERVICES', '1')
+
     if Options.options.with_glusterfs:
         conf.CHECK_CFG(package='glusterfs-api', args='"glusterfs-api >= 4" --cflags --libs',
                        msg='Checking for glusterfs-api >= 4', uselib_store="GFAPI")
diff --git a/source3/wscript_build b/source3/wscript_build
index 76c5d6e203b..64f4b7ecebd 100644
--- a/source3/wscript_build
+++ b/source3/wscript_build
@@ -1052,6 +1052,16 @@ bld.SAMBA3_SUBSYSTEM('SPOOLSSD',
                          RPC_SOCK_HELPER
                          ''')
 
+smbd_rados_deps = ''
+if bld.CONFIG_SET('HAVE_LIBRADOS_SERVICES'):
+    bld.SAMBA_LIBRARY('rados_service',
+                      source='smbd/rados_service.c',
+                      deps='SMBCONF_PARAM samba-debug',
+                      local_include=False,
+                      public_deps='rados ceph-common',
+                      private_library=True)
+    smbd_rados_deps += ' rados_service'
+
 ########################## BINARIES #################################
 
 bld.SAMBA3_BINARY('smbd/smbd',
@@ -1064,7 +1074,7 @@ bld.SAMBA3_BINARY('smbd/smbd',
                       FSSD
                       MDSSD
                       SPOOLSSD
-                      ''',
+                      ''' + smbd_rados_deps,
                  install_path='${SBINDIR}')
 
 
-- 
2.13.6


--MP_//RKHQZl0YSij8whKTvlQsRJ--
