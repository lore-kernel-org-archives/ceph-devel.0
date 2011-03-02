From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: fix build with tcmalloc on Freed-ora 13
Date: Wed, 02 Mar 2011 15:24:00 -0300
Message-ID: <orwrkh8jpb.fsf@oliva.athome.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:39801 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756065Ab1CBS4l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 13:56:41 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p22IO2JJ020107
	for <ceph-devel@vger.kernel.org>; Wed, 2 Mar 2011 15:24:02 -0300
Received: from localhost.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p22IO20i012778
	for <ceph-devel@vger.kernel.org>; Wed, 2 Mar 2011 15:24:02 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G++ complains about the difference between the return type of tcmalloc's
IsHeapProfilerRunning (int) and the return type of the function that
g_conf.profiler_running is supposed to point to (bool).  We could
probably get away with a type-cast, but as a compiler developer and
former C++ language lawyer, I'd rather not take the risk of destroying
the universe by invoking undefined behavior ;-)

The one thing I'm not sure about is whether the type of profiler_running
is always going to be bool.  If you know otherwise, let me know, and
I'll come up with some C++ template trickery to infer the appropriate
type.

        Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

diff --git a/src/cmds.cc b/src/cmds.cc
index 4264f36..f4adf9d 100644
--- a/src/cmds.cc
+++ b/src/cmds.cc
@@ -46,6 +46,13 @@ void usage()
   generic_server_usage();
 }
 
+#ifdef HAVE_LIBTCMALLOC
+/* Adjust the return type.  */
+static bool isHeapProfilerRunning(void) {
+  return IsHeapProfilerRunning();
+}
+#endif
+
 int main(int argc, const char **argv) 
 {
   vector<const char*> args;
@@ -58,7 +65,7 @@ int main(int argc, const char **argv)
   common_set_defaults(true);
 #ifdef HAVE_LIBTCMALLOC
   g_conf.profiler_start = HeapProfilerStart;
-  g_conf.profiler_running = IsHeapProfilerRunning;
+  g_conf.profiler_running = isHeapProfilerRunning;
   g_conf.profiler_stop = HeapProfilerStop;
   g_conf.profiler_dump = HeapProfilerDump;
   g_conf.tcmalloc_have = true;
diff --git a/src/cosd.cc b/src/cosd.cc
index 7e77799..28730ce 100644
--- a/src/cosd.cc
+++ b/src/cosd.cc
@@ -42,6 +42,12 @@ void usage()
   generic_server_usage();
 }
 
+#ifdef HAVE_LIBTCMALLOC
+/* Adjust the return type.  */
+static bool isHeapProfilerRunning(void) {
+  return IsHeapProfilerRunning();
+}
+#endif
 
 int main(int argc, const char **argv) 
 {
@@ -62,7 +68,7 @@ int main(int argc, const char **argv)
   common_set_defaults(true);
 #ifdef HAVE_LIBTCMALLOC
   g_conf.profiler_start = HeapProfilerStart;
-  g_conf.profiler_running = IsHeapProfilerRunning;
+  g_conf.profiler_running = isHeapProfilerRunning;
   g_conf.profiler_stop = HeapProfilerStop;
   g_conf.profiler_dump = HeapProfilerDump;
   g_conf.tcmalloc_have = true;


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
