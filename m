From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] ceph_filestore_dump: introduce --type=premove to start multiple removals
Date: Sun, 18 May 2014 09:45:35 -0300
Message-ID: <ormwefxnkg.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:45690 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaERM7t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 May 2014 08:59:49 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s4ICohtl030192
	for <ceph-devel@vger.kernel.org>; Sun, 18 May 2014 12:50:43 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After a major crushmap reconfiguration, OSDs needed some help to speed
up recovery, freeing up space on nearly-full OSDs earlier than the
cluster would on its own, in some cases temporarily sacrificing some
redundancy.

Unfortunately, ceph_filestore_dump may take a long time to remove even
a single PG, let alone several PGs, and the OSD had to remain down for
the duration of the removal.

Part of the solution was enabling ceph_filestore_dump to just start
the removal of a PG, dropping the metadata and renaming the collection
so that the OSD will pick it up and complete the removal.  This patch
introduces --type=premove in ceph_filestore_dump to do this.

Another part of the solution was avoiding the huge startup overhead of
ceph_filestore_dump: mounting the filestore was taking longer than
removing the files proper, and I had more than a handful of PGs to
remove at once.  So, I arranged for premove to accept a list of PGs
instead of a single one, also in this patch.

The OSD would still clean everything up before it would join the
cluster; this was addressed in a separate patch.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/tools/ceph_filestore_dump.cc |   67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/src/tools/ceph_filestore_dump.cc b/src/tools/ceph_filestore_dump.cc
index 87a8387..1149622 100644
--- a/src/tools/ceph_filestore_dump.cc
+++ b/src/tools/ceph_filestore_dump.cc
@@ -482,6 +482,40 @@ int finish_remove_pgs(ObjectStore *store, uint64_t *next_removal_seq)
   return 0;
 }
 
+//Based on part of OSD::load_pgs()
+int compute_next_removal_seq(ObjectStore *store, uint64_t *next_removal_seq)
+{
+  vector<coll_t> ls;
+  int r = store->list_collections(ls);
+  if (r < 0) {
+    cout << "finish_remove_pgs: failed to list pgs: " << cpp_strerror(-r)
+      << std::endl;
+    return r;
+  }
+
+  for (vector<coll_t>::iterator it = ls.begin();
+       it != ls.end();
+       ++it) {
+    spg_t pgid;
+    snapid_t snap;
+
+    if (it->is_temp(pgid) ||
+	it->is_pg(pgid, snap)) {
+      continue;
+    }
+
+    uint64_t seq;
+    if (it->is_removal(&seq, &pgid)) {
+      if (seq >= *next_removal_seq)
+	*next_removal_seq = seq + 1;
+      continue;
+    }
+
+    //cout << "finish_remove_pgs ignoring unrecognized " << *it << std::endl;
+  }
+  return 0;
+}
+
 int initiate_new_remove_pg(ObjectStore *store, spg_t r_pgid,
     uint64_t *next_removal_seq)
 {
@@ -1088,7 +1122,7 @@ int main(int argc, char **argv)
     ("pgid", po::value<string>(&pgidstr),
      "PG id, mandatory except for import")
     ("type", po::value<string>(&type),
-     "Arg is one of [info, log, remove, export, or import], mandatory")
+     "Arg is one of [info, log, remove, premove, export, or import], mandatory")
     ("file", po::value<string>(&file),
      "path of file to export or import")
     ("debug", "Enable diagnostic output to stderr")
@@ -1122,7 +1156,7 @@ int main(int argc, char **argv)
     return 1;
   } 
   if (!vm.count("type")) {
-    cout << "Must provide type (info, log, remove, export, import)"
+    cout << "Must provide type (info, log, remove, premove, export, import)"
       << std::endl << desc << std::endl;
     return 1;
   } 
@@ -1158,8 +1192,9 @@ int main(int argc, char **argv)
   }
   
   if ((fspath.length() == 0 || jpath.length() == 0) ||
-      (type != "info" && type != "log" && type != "remove" && type != "export"
-        && type != "import") ||
+      (type != "info" && type != "log" &&
+       type != "remove" && type != "premove" &&
+       type != "export" && type != "import") ||
       (type != "import" && pgidstr.length() == 0)) {
     cerr << "Invalid params" << std::endl;
     exit(1);
@@ -1332,6 +1367,30 @@ int main(int argc, char **argv)
     goto out;
   }
 
+  if (type == "premove") {
+    uint64_t next_removal_seq = 0;	//My local seq
+    compute_next_removal_seq(fs, &next_removal_seq);
+    for (const char *next = pgidstr.c_str(); *next;) {
+      int r = initiate_new_remove_pg(fs, pgid, &next_removal_seq);
+      if (r) {
+	cout << "PG '" << pgid << "' not found" << std::endl;
+	ret = 1;
+      } else
+	cout << "Remove initiated" << std::endl;
+
+      while (*next && *next != ' ' && *next != '\n' && *next != ',')
+	next++;
+      while (*next && !(*next != ' ' && *next != '\n' && *next != ','))
+	next++;
+
+      if (*next && !pgid.parse(next))
+	break;
+      log_oid = OSD::make_pg_log_oid(pgid);
+      biginfo_oid = OSD::make_pg_biginfo_oid(pgid);
+    }
+    goto out;
+  }
+
   r = fs->list_collections(ls);
   if (r < 0) {
     cout << "failed to list pgs: " << cpp_strerror(-r) << std::endl;


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
