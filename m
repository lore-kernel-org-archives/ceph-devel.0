From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V6 1/5] Build support for BlkKin (LTTng + Zipkin) tracing
Date: Tue, 10 Mar 2015 19:43:26 -0700
Message-ID: <1426041810-3942-2-git-send-email-agshew@gmail.com>
References: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33562 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbCKCoF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 22:44:05 -0400
Received: by padet14 with SMTP id et14so7439731pad.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2015 19:44:05 -0700 (PDT)
In-Reply-To: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

 * Adds --with-blkin to autoconf (default without)
 * Adds BLKIN_LIBS to necessary automake files
 * Adds documentation for testing BlkKin tracing
 * Adds ztrace initialization

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Chendi.Xue <chendi.xue@intel.com>
---
 configure.ac             |   11 +++
 do_autogen.sh            |    5 +
 doc/dev/blkin.rst        |  168 +++++++++++++++++++++++++++++++++++++++++++++++
 src/Makefile-env.am      |    6 +
 src/Makefile.am          |   14 +++
 src/ceph_mds.cc          |    2 
 src/ceph_mon.cc          |    2 
 src/ceph_osd.cc          |    2 
 src/librados/Makefile.am |    9 ++
 src/librbd/Makefile.am   |   10 ++
 src/mon/Makefile.am      |   11 ++-
 src/msg/Makefile.am      |    8 ++
 src/os/Makefile.am       |    8 ++
 src/osd/Makefile.am      |    9 ++
 src/osdc/Makefile.am     |    9 ++
 15 files changed, 271 insertions(+), 3 deletions(-)
 create mode 100644 doc/dev/blkin.rst

diff --git a/configure.ac b/configure.ac
index 05f0cf9..78d431d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -333,6 +333,17 @@ if test "x$enable_coverage" != xno; then
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
index 7df1c93..0e50654 100755
--- a/do_autogen.sh
+++ b/do_autogen.sh
@@ -5,6 +5,7 @@ usage() {
 do_autogen.sh: make a ceph build by running autogen, etc.
 
 -h:                              this help message
+-b                               blkin tracing
 -d <level>                       debug build
                                  level 0: no debug
                                  level 1: -g
@@ -32,9 +33,11 @@ debug_level=0
 verbose=0
 profile=0
 CONFIGURE_FLAGS="--disable-static --with-lttng"
-while getopts  "d:e:hHrTPJLjpcvO:" flag
+while getopts  "bd:e:hHrTPJLjpcvO:" flag
 do
     case $flag in
+    b) CONFIGURE_FLAGS="$CONFIGURE_FLAGS --with-blkin";;
+
     d) debug_level=$OPTARG;;
 
     O) CFLAGS="${CFLAGS} -O$OPTARG";;
diff --git a/doc/dev/blkin.rst b/doc/dev/blkin.rst
new file mode 100644
index 0000000..bf14142
--- /dev/null
+++ b/doc/dev/blkin.rst
@@ -0,0 +1,168 @@
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
+
+Installing Blkin
+================
+
+You can install Markos Kogias' upstream Blkin_ by hand.::
+
+  cd blkin/
+  make && make install
+
+ or build
+distribution packages using DistroReadyBlkin_, which also comes
+with pkgconfig support. If you choose the latter, then you must
+generate the configure and make files first.::
+
+  cd blkin
+  autoreconf -i
+
+.. _Blkin: https://github.com/marioskogias/blkin
+.. _DistroReadyBlkin: https://github.com/agshew/blkin
+
+
+Configuring Ceph with Blkin
+===========================
+
+If you built and installed Blkin by hand, rather than building and
+installing packages, then set these variables before configuring
+Ceph.::
+
+  export BLKIN_CFLAGS=-Iblkin/
+  export BLKIN_LIBS=-lzipkin-cpp
+
+Since there are separate lttng and blkin changes to Ceph, you may
+want to configure with something like::
+
+  ./configure --with-blkin --without-lttng --with-debug
+
+
+Testing Blkin
+=============
+
+It's easy to test Ceph's Blkin tracing. Let's assume you don't have
+Ceph already running, and you compiled Ceph with Blkin support but
+you did't install it. Then launch Ceph with the ``vstart.sh`` script
+in Ceph's src directgory so you can see the possible tracepoints.::
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
+  ./rados mkpool test-blkin
+  ./rados put test-object-1 ./vstart.sh --pool=test-blkin
+  ./rados -p test-blkin ls
+  ./ceph osd map test-blkin test-object-1
+  ./rados get test-object-1 ./vstart-copy.sh --pool=test-blkin
+  md5sum vstart*
+  ./rados rm test-object-1 --pool=test-blkin
+
+You could also use the example in ``examples/librados/`` or ``rados bench``.
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
+
+
+Install  Zipkin
+===============
+One of the points of using Blkin is so that you can look at the traces
+using Zipkin. Users should run Zipkin as a tracepoints collector and
+also a web service, which means users need to run three services,
+zipkin-collector, zipkin-query and zipkin-web.::
+
+Download Zipkin Package::
+
+  wget https://github.com/twitter/zipkin/archive/1.1.0.tar.gz
+  tar zxf 1.1.0.tar.gz
+  cd zipkin-1.1.0
+  bin/collector cassandra &
+  bin/query cassandra &
+  bin/web &
+
+Check Zipkin::
+
+  bin/test
+  Browse http://${zipkin-web-ip}:8080
+
+
+Show Ceph's Blkin Traces in Zipkin-web
+======================================
+Blkin provides a script which translates lttng result to Zipkin
+(Dapper) semantics.::
+
+Send lttng data to Zipkin::
+
+  python3 babeltrace_zipkin.py ${lttng-traces-dir}/${blkin-test}/ust/uid/0/64-bit/ -p ${zipkin-collector-port(9410 by default)} -s ${zipkin-collector-ip}
+
+Example::
+
+  python3 babeltrace_zipkin.py ~/lttng-traces-dir/blkin-test-20150225-160222/ust/uid/0/64-bit/ -p 9410 -s 127.0.0.1
+
+Check Ceph traces on webpage::
+
+  Browse http://${zipkin-web-ip}:8080
+  Click "Find traces"
diff --git a/src/Makefile-env.am b/src/Makefile-env.am
index 8716f15..dea5565 100644
--- a/src/Makefile-env.am
+++ b/src/Makefile-env.am
@@ -190,6 +190,12 @@ if ENABLE_COVERAGE
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
index 116be9d..1a5035a 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -40,11 +40,25 @@ include tools/Makefile.am
 # core daemons
 
 ceph_mon_SOURCES = ceph_mon.cc
+ceph_mon_CPPFLAGS = $(AM_CPPFLAGS)
+ceph_mon_CXXFLAGS = $(AM_CXXFLAGS)
 ceph_mon_LDADD = $(LIBMON) $(LIBOS) $(CEPH_GLOBAL) $(LIBCOMMON)
+if WITH_BLKIN
+ceph_mon_CPPFLAGS += -DWITH_BLKIN
+ceph_mon_CXXFLAGS += $(BLKIN_CFLAGS)
+ceph_mon_LDADD += $(BLKIN_LIBS)
+endif
 bin_PROGRAMS += ceph-mon
 
 ceph_osd_SOURCES = ceph_osd.cc
+ceph_osd_CPPFLAGS = $(AM_CPPFLAGS)
+ceph_osd_CXXFLAGS = $(AM_CXXFLAGS)
 ceph_osd_LDADD = $(LIBOSD) $(CEPH_GLOBAL) $(LIBCOMMON)
+if WITH_BLKIN
+ceph_osd_CPPFLAGS += -DWITH_BLKIN
+ceph_osd_CXXFLAGS += $(BLKIN_CFLAGS)
+ceph_osd_LDADD += $(BLKIN_LIBS)
+endif
 bin_PROGRAMS += ceph-osd
 
 ceph_mds_SOURCES = ceph_mds.cc
diff --git a/src/ceph_mds.cc b/src/ceph_mds.cc
index 06269fb..182bd9d 100644
--- a/src/ceph_mds.cc
+++ b/src/ceph_mds.cc
@@ -198,6 +198,8 @@ int main(int argc, const char **argv)
 
   msgr->start();
 
+  BLKIN_ZTRACE_INIT();
+
   // start mds
   mds = new MDS(g_conf->name.get_id().c_str(), msgr, &mc);
 
diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
index e0ca6e2..6c3f03f 100644
--- a/src/ceph_mon.cc
+++ b/src/ceph_mon.cc
@@ -509,6 +509,8 @@ int main(int argc, const char **argv)
       prefork.exit(1);
   }
 
+  BLKIN_ZTRACE_INIT();
+
   MonitorDBStore *store = new MonitorDBStore(g_conf->mon_data);
   err = store->open(std::cerr);
   if (err < 0) {
diff --git a/src/ceph_osd.cc b/src/ceph_osd.cc
index 884b7ed..469468f 100644
--- a/src/ceph_osd.cc
+++ b/src/ceph_osd.cc
@@ -186,6 +186,8 @@ int main(int argc, const char **argv)
     usage();
   }
 
+  BLKIN_ZTRACE_INIT();
+
   // the store
   ObjectStore *store = ObjectStore::create(g_ceph_context,
 					   g_conf->osd_objectstore,
diff --git a/src/librados/Makefile.am b/src/librados/Makefile.am
index 8e6de3f..59ee46d 100644
--- a/src/librados/Makefile.am
+++ b/src/librados/Makefile.am
@@ -14,6 +14,8 @@ librados_la_SOURCES = \
 	common/buffer.cc \
 	librados/librados.cc
 
+librados_la_CPPFLAGS = $(AM_CPPFLAGS)
+
 # We need this to avoid basename conflicts with the librados build tests in test/Makefile.am
 librados_la_CXXFLAGS = ${AM_CXXFLAGS}
 
@@ -25,6 +27,13 @@ LIBRADOS_DEPS += $(LIBRADOS_TP)
 endif
 
 librados_la_LIBADD = $(LIBRADOS_DEPS) $(PTHREAD_LIBS) $(CRYPTO_LIBS) $(EXTRALIBS)
+
+if WITH_BLKIN
+librados_la_CPPFLAGS += -DWITH_BLKIN
+librados_la_CXXFLAGS += $(BLKIN_CXXFLAGS)
+librados_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 librados_la_LDFLAGS = ${AM_LDFLAGS} -version-info 2:0:0
 if LINUX
 librados_la_CXXFLAGS += -fvisibility=hidden -fvisibility-inlines-hidden
diff --git a/src/librbd/Makefile.am b/src/librbd/Makefile.am
index a4b21d9..9cc6460 100644
--- a/src/librbd/Makefile.am
+++ b/src/librbd/Makefile.am
@@ -37,11 +37,19 @@ if WITH_LTTNG
 librbd_la_LIBADD += $(LIBRBD_TP)
 endif
 
+librbd_la_CPPFLAGS = $(AM_CPPFLAGS)
+librbd_la_CXXFLAGS = $(AM_CXXFLAGS)
 librbd_la_LDFLAGS = ${AM_LDFLAGS} -version-info 1:0:0
 if LINUX
-librbd_la_CXXFLAGS = -fvisibility=hidden -fvisibility-inlines-hidden
+librbd_la_CXXFLAGS += -fvisibility=hidden -fvisibility-inlines-hidden
 librbd_la_LDFLAGS += -Xcompiler -Xlinker -Xcompiler '--exclude-libs=ALL'
 endif
+
+if WITH_BLKIN
+librbd_la_CPPFLAGS += -DWITH_BLKIN
+librbd_la_CXXFLAGS += $(BLKIN_CFLAGS)
+librbd_la_LIBADD += $(BLKIN_LIBS)
+endif
 lib_LTLIBRARIES += librbd.la
 
 noinst_HEADERS += \
diff --git a/src/mon/Makefile.am b/src/mon/Makefile.am
index 6016355..8ab5063 100644
--- a/src/mon/Makefile.am
+++ b/src/mon/Makefile.am
@@ -17,7 +17,17 @@ libmon_la_SOURCES = \
 	mon/HealthMonitor.cc \
 	mon/DataHealthService.cc \
 	mon/ConfigKeyService.cc
+
+libmon_la_CPPFLAGS = $(AM_CPPFLAGS)
+libmon_la_CXXFLAGS = $(AM_CXXFLAGS)
 libmon_la_LIBADD = $(LIBAUTH) $(LIBCOMMON) $(LIBOS) $(LIBMON_TYPES)
+
+if WITH_BLKIN
+libmon_la_CPPFLAGS += -DWITH_BLKIN
+libmon_la_CXXFLAGS += $(BLKIN_CFLAGS)
+libmon_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libmon.la
 
 noinst_HEADERS += \
@@ -46,4 +56,3 @@ noinst_HEADERS += \
 	mon/QuorumService.h \
 	mon/Session.h \
 	mon/mon_types.h
-
diff --git a/src/msg/Makefile.am b/src/msg/Makefile.am
index 6ef821b..2230789 100644
--- a/src/msg/Makefile.am
+++ b/src/msg/Makefile.am
@@ -3,6 +3,14 @@ libmsg_la_SOURCES = \
 	msg/Messenger.cc \
 	msg/msg_types.cc
 
+libmsg_la_CPPFLAGS = $(AM_CPPFLAGS)
+libmsg_la_CXXFLAGS = $(AM_CXXFLAGS)
+if WITH_BLKIN
+libmsg_la_CPPFLAGS += -DWITH_BLKIN
+libmsg_la_CXXFLAGS += $(BLKIN_CFLAGS)
+libmsg_la_LIBADD = $(BLKIN_LIBS)
+endif
+
 noinst_HEADERS += \
 	msg/Connection.h \
 	msg/Dispatcher.h \
diff --git a/src/os/Makefile.am b/src/os/Makefile.am
index d12adba..77aa56a 100644
--- a/src/os/Makefile.am
+++ b/src/os/Makefile.am
@@ -36,12 +36,20 @@ if WITH_LIBZFS
 libos_la_SOURCES += os/ZFSFileStoreBackend.cc
 endif
 
+libos_la_CPPFLAGS = $(AM_CPPFLAGS)
 libos_la_CXXFLAGS = ${AM_CXXFLAGS}
 libos_la_LIBADD = $(LIBOS_TYPES)
+
 if WITH_LTTNG
 libos_la_LIBADD += $(LIBOS_TP)
 endif
 
+if WITH_BLKIN
+libos_la_CPPFLAGS += -DWITH_BLKIN
+libos_la_CXXFLAGS += $(BLKIN_CFLAGS)
+libos_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libos.la
 
 noinst_HEADERS += \
diff --git a/src/osd/Makefile.am b/src/osd/Makefile.am
index 2338f18..4371ba6 100644
--- a/src/osd/Makefile.am
+++ b/src/osd/Makefile.am
@@ -24,11 +24,20 @@ libosd_la_SOURCES = \
 	osd/SnapMapper.cc \
 	objclass/class_api.cc
 
+libosd_la_CPPFLAGS = $(AM_CPPFLAGS)
 libosd_la_CXXFLAGS = ${AM_CXXFLAGS}
 libosd_la_LIBADD = $(LIBOSDC) $(LIBOS) $(LIBOSD_TYPES) $(LIBOS_TYPES)
+
 if WITH_LTTNG
 libosd_la_LIBADD += $(LIBOSD_TP)
 endif
+
+if WITH_BLKIN
+libosd_la_CPPFLAGS += -DWITH_BLKIN
+libosd_la_CXXFLAGS += $(BLKIN_CFLAGS)
+libosd_la_LIBADD += $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libosd.la
 
 noinst_HEADERS += \
diff --git a/src/osdc/Makefile.am b/src/osdc/Makefile.am
index 3ba446b..7b56637 100644
--- a/src/osdc/Makefile.am
+++ b/src/osdc/Makefile.am
@@ -4,6 +4,15 @@ libosdc_la_SOURCES = \
 	osdc/Filer.cc \
 	osdc/Striper.cc \
 	osdc/Journaler.cc
+
+libosdc_la_CPPFLAGS = $(AM_CPPFLAGS)
+libosdc_la_CXXFLAGS = $(AM_CXXFLAGS)
+if WITH_BLKIN
+libosdc_la_CPPFLAGS += -DWITH_BLKIN
+libosdc_la_CXXFLAGS += $(BLKIN_CFLAGS)
+libosdc_la_LIBADD = $(BLKIN_LIBS)
+endif
+
 noinst_LTLIBRARIES += libosdc.la
 
 noinst_HEADERS += \
