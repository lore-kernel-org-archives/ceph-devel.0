From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V2 1/6] Build support for BlkKin (LTTng + Zipkin) tracing
Date: Tue, 25 Nov 2014 10:54:23 -0800
Message-ID: <1416941668-26150-2-git-send-email-agshew@gmail.com>
References: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53919 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaKYSyh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 13:54:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so1127400pab.5
        for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 10:54:36 -0800 (PST)
In-Reply-To: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Andrew Shewmaker <agshew@gmail.com>, Marios-Evaggelos Kogias <marioskogias@gmail.com>

 * Adds --with-blkin to autoconf (default without)
 * Adds BLKIN_LIBS to necessary automake files
 * Adds documentation for testing BlkKin tracing

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
---
 configure.ac             | 11 ++++++
 do_autogen.sh            |  5 ++-
 doc/dev/blkin.rst        | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/Makefile-env.am      |  6 ++++
 src/Makefile.am          | 10 ++++++
 src/librados/Makefile.am |  7 ++++
 src/mon/Makefile.am      |  7 +++-
 src/msg/Makefile.am      |  6 ++++
 src/os/Makefile.am       |  6 ++++
 src/osd/Makefile.am      |  7 ++++
 src/osdc/Makefile.am     |  7 ++++
 11 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 doc/dev/blkin.rst

diff --git a/configure.ac b/configure.ac
index 36312cf..9ca7bc3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -285,6 +285,17 @@ if test "x$enable_coverage" != xno; then
 fi
 AC_SUBST(GCOV_PREFIX_STRIP, `echo $(pwd)/src | tr -dc / | wc -c`)
 
+# blkin (lttng+zipkin) tracing?
+AC_ARG_WITH([blkin],
+	    [AS_HELP_STRING([--with-blkin], [blkin (lttng + zipkin) tracing])],
+	    [],
+	    [with_blkin=no])
+have_blkin=no
+AS_IF([test "x$with_blkin" == "xyes"],
+    [PKG_CHECK_MODULES([BLKIN], [blkin], [have_blkin=yes])])
+AM_CONDITIONAL(WITH_BLKIN, test "x$have_blkin" == xyes)
+AM_COND_IF([WITH_BLKIN], [AC_DEFINE([WITH_BLKIN], [1], [Defined if using BlkKin])])
+
 # radosgw?
 AC_ARG_WITH([radosgw],
             [AS_HELP_STRING([--with-radosgw], [build RADOS gateway])],
diff --git a/do_autogen.sh b/do_autogen.sh
index ea498d8..13256ff 100755
--- a/do_autogen.sh
+++ b/do_autogen.sh
@@ -5,6 +5,7 @@ usage() {
 do_autogen.sh: make a ceph build by running autogen, etc.
 
 -h:                              this help message
+-b                               blkin tracing
 -d <level>                       debug build
                                  level 0: no debug
                                  level 1: -g
@@ -30,9 +31,11 @@ debug_level=0
 verbose=0
 profile=0
 CONFIGURE_FLAGS=""
-while getopts  "d:e:hHTPjpnvO:" flag
+while getopts  "bd:e:hHTPjpnvO:" flag
 do
     case $flag in
+    b) CONFIGURE_FLAGS="$CONFIGURE_FLAGS --with-blkin";;
+
     d) debug_level=$OPTARG;;
 
     O) CFLAGS="${CFLAGS} -O$OPTARG";;
diff --git a/doc/dev/blkin.rst b/doc/dev/blkin.rst
new file mode 100644
index 0000000..e3694c2
--- /dev/null
+++ b/doc/dev/blkin.rst
@@ -0,0 +1,88 @@
+=========================
+ Tracing Ceph With BlkKin
+=========================
+
+Ceph can use Blkin, a library created by Marios Kogias and others,
+which enables tracking a specific request from the time it enters
+the system at higher levels till it is finally served by RADOS.
+
+In general, Blkin implements the Dapper_ tracing semantics
+in order to show the causal relationships between the different
+processing phases that an IO request may trigger. The goal is an
+end-to-end visualisation of the request's route in the system,
+accompanied by information concerning latencies in each processing
+phase. Thanks to LTTng this can happen with a minimal overhead and
+in realtime. The LTTng traces can then be visualized with Twitter's
+Zipkin_.
+
+.. _Dapper: http://static.googleusercontent.com/media/research.google.com/el//pubs/archive/36356.pdf
+.. _Zipkin: http://twitter.github.io/zipkin/
+
+Testing Blkin
+=============
+
+It's easy to test Ceph's Blkin tracing. Compile Ceph with the Blkin
+changes, then launch Ceph with the vstart script so you can see the
+possible tracepoints.::
+
+  cd src
+  OSD=3 MON=3 RGW=1 ./vstart.sh -n
+  lttng list --userspace
+
+You'll see something like the following:::
+
+  UST events:
+  -------------
+  PID: 8987 - Name: ./ceph-osd
+        zipkin:timestamp (loglevel: TRACE_WARNING (4)) (type: tracepoint)
+        zipkin:keyval (loglevel: TRACE_WARNING (4)) (type: tracepoint)
+        ust_baddr_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
+
+  PID: 8407 - Name: ./ceph-mon
+        zipkin:timestamp (loglevel: TRACE_WARNING (4)) (type: tracepoint)
+        zipkin:keyval (loglevel: TRACE_WARNING (4)) (type: tracepoint)
+        ust_baddr_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
+
+  ...
+
+Next, stop Ceph so that the tracepoints can be enabled.::
+
+  ./stop.sh
+
+Start up an LTTng session and enable the tracepoints.::
+
+  lttng create blkin-test
+  lttng enable-event --userspace zipkin:timestamp
+  lttng enable-event --userspace zipkin:keyval
+  lttng start
+
+Then start up Ceph again.::
+
+  OSD=3 MON=3 RGW=1 ./vstart.sh -n
+
+You may want to check that ceph is up.::
+
+  ./ceph status
+
+Now put something in usin rados, check that it made it, get it back, and remove it.::
+
+  rados put test-object-1 ./vstart.sh --pool=data
+  rados -p data ls
+  ceph osd map data test-object-1
+  rados get test-object-1 ./vstart-copy.sh --pool=data
+  md5sum vstart*
+  rados rm test-object-1 --pool=data
+
+You could also use the example in ``examples/librados/``.
+
+Then stop the LTTng session and see what was collected.::
+
+  lttng stop
+  lttng view
+
+You'll see something like:::
+
+  [13:09:07.755054973] (+?.?????????) scruffy zipkin:timestamp: { cpu_id = 5 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 7492589359882233221, span_id = 2694140257089376129, parent_span_id = 0, event = "Message allocated" }
+  [13:09:07.755071569] (+0.000016596) scruffy zipkin:keyval: { cpu_id = 5 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 7492589359882233221, span_id = 2694140257089376129, parent_span_id = 0, key = "Type", val = "MOSDOp" }
+  [13:09:07.755074217] (+0.000002648) scruffy zipkin:keyval: { cpu_id = 5 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 7492589359882233221, span_id = 2694140257089376129, parent_span_id = 0, key = "Reqid", val = "client.4126.0:1" }
+  ...
diff --git a/src/Makefile-env.am b/src/Makefile-env.am
index e1ba4a8..0e5dbe7 100644
--- a/src/Makefile-env.am
+++ b/src/Makefile-env.am
@@ -167,6 +167,12 @@ if ENABLE_COVERAGE
 EXTRALIBS += -lgcov
 endif # ENABLE_COVERAGE
 
+if WITH_BLKIN
+AM_CPPFLAGS += -DWITH_BLKIN
+AM_CXXFLAGS += $(BLKIN_CFLAGS)
+EXTRALIBS += $(BLKIN_LIBS)
+endif
+
 # Libosd always needs osdc and os
 LIBOSD += $(LIBOSDC) $(LIBOS)
 
diff --git a/src/Makefile.am b/src/Makefile.am
index edec05e..243a616 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -38,10 +38,20 @@ include tools/Makefile.am
 
 ceph_mon_SOURCES = ceph_mon.cc
 ceph_mon_LDADD = $(LIBMON) $(LIBOS) $(CEPH_GLOBAL) $(LIBCOMMON)
+if WITH_BLKIN
+ceph_mon_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+ceph_mon_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+ceph_mon_LDADD += $(BLKIN_LIBS)
+endif
 bin_PROGRAMS += ceph-mon
 
 ceph_osd_SOURCES = ceph_osd.cc
 ceph_osd_LDADD = $(LIBOSD) $(CEPH_GLOBAL) $(LIBCOMMON)
+if WITH_BLKIN
+ceph_osd_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+ceph_osd_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+ceph_osd_LDADD += $(BLKIN_LIBS)
+endif
 bin_PROGRAMS += ceph-osd
 
 ceph_mds_SOURCES = ceph_mds.cc
diff --git a/src/librados/Makefile.am b/src/librados/Makefile.am
index 23e9167..a2a59c0 100644
--- a/src/librados/Makefile.am
+++ b/src/librados/Makefile.am
@@ -9,6 +9,13 @@ librados_la_CXXFLAGS = ${AM_CXXFLAGS}
 
 LIBRADOS_DEPS += libcls_lock_client.la $(LIBOSDC) $(LIBCOMMON)
 librados_la_LIBADD = $(LIBRADOS_DEPS) $(PTHREAD_LIBS) $(CRYPTO_LIBS) $(EXTRALIBS)
+
+if WITH_BLKIN
+librados_la_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+librados_la_CXXFLAGS += $(BLKIN_CXXFLAGS)
+librados_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 librados_la_LDFLAGS = ${AM_LDFLAGS} -version-info 2:0:0
 if LINUX
 librados_la_LDFLAGS += -export-symbols-regex '^rados_.*'
diff --git a/src/mon/Makefile.am b/src/mon/Makefile.am
index 68c6503..e08cbde 100644
--- a/src/mon/Makefile.am
+++ b/src/mon/Makefile.am
@@ -15,6 +15,12 @@ libmon_la_SOURCES = \
 	mon/DataHealthService.cc \
 	mon/ConfigKeyService.cc
 libmon_la_LIBADD = $(LIBAUTH) $(LIBCOMMON) $(LIBOS)
+
+if WITH_BLKIN
+libmon_la_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+libmon_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libmon.la
 
 noinst_HEADERS += \
@@ -43,4 +49,3 @@ noinst_HEADERS += \
 	mon/QuorumService.h \
 	mon/Session.h \
 	mon/mon_types.h
-
diff --git a/src/msg/Makefile.am b/src/msg/Makefile.am
index a849a1c..c1c9514 100644
--- a/src/msg/Makefile.am
+++ b/src/msg/Makefile.am
@@ -7,6 +7,12 @@ libmsg_la_SOURCES = \
 	msg/SimpleMessenger.cc \
 	msg/msg_types.cc
 
+if WITH_BLKIN
+libmsg_la_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+libmsg_la_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+libmsg_la_LIBADD = $(BLKIN_LIBS)
+endif
+
 noinst_HEADERS += \
 	msg/Accepter.h \
 	msg/DispatchQueue.h \
diff --git a/src/os/Makefile.am b/src/os/Makefile.am
index 252c678..f69adae 100644
--- a/src/os/Makefile.am
+++ b/src/os/Makefile.am
@@ -29,6 +29,12 @@ if WITH_LIBZFS
 libos_la_SOURCES += os/ZFSFileStoreBackend.cc
 endif
 
+if WITH_BLKIN
+libos_la_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+libos_la_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+libos_la_LIBADD = $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libos.la
 
 noinst_HEADERS += \
diff --git a/src/osd/Makefile.am b/src/osd/Makefile.am
index 8a2cb2b..b8d9ef1 100644
--- a/src/osd/Makefile.am
+++ b/src/osd/Makefile.am
@@ -20,6 +20,13 @@ libosd_la_SOURCES = \
 	osd/ECUtil.cc \
 	objclass/class_api.cc
 libosd_la_LIBADD = $(LIBOSDC) $(LIBOS)
+
+if WITH_BLKIN
+libosd_la_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+libosd_la_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+libosd_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libosd.la
 
 noinst_HEADERS += \
diff --git a/src/osdc/Makefile.am b/src/osdc/Makefile.am
index 3a8a216..aac506f 100644
--- a/src/osdc/Makefile.am
+++ b/src/osdc/Makefile.am
@@ -4,6 +4,13 @@ libosdc_la_SOURCES = \
 	osdc/Filer.cc \
 	osdc/Striper.cc \
 	osdc/Journaler.cc
+
+if WITH_BLKIN
+libosdc_la_CPPFLAGS = -DWITH_BLKIN $(AM_CPPFLAGS)
+libosdc_la_CXXFLAGS = $(BLKIN_CFLAGS) $(AM_CXXFLAGS)
+libosdc_la_LIBADD = $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libosdc.la
 
 noinst_HEADERS += \
-- 
2.1.0

