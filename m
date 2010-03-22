From: "Martin Ettl" <ettl.martin@gmx.de>
Subject: [cppcheck] suggested a few performance improvements
Date: Mon, 22 Mar 2010 21:35:02 +0100
Message-ID: <20100322203502.295370@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMX295371269290102856509"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--========GMX295371269290102856509
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello,

i have checked the current git head with cppcheck ( a static code analysis tool, http://sourceforge.net/projects/cppcheck/). It is an allready very powerfull tool that makes some suggestions, how to improve performance of the code.

Here is a snipped of the scan:
....
[./src/mds/MDSMap.h:236]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/mds/MDSMap.h:256]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/mds/MDSMap.h:263]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/mds/MDSMap.h:280]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/mds/MDSMap.h:291]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/include/LogEntry.h:100]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/ceph.cc:317]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[./src/mds/MDSMap.h:247]: (possible style) Use failed.empty() instead of failed.size() to guarantee fast code.
....


Please refer the attached patch that chanes a few of this suggestions.
What do you think about this? Does it boost the performance?

Best regards

Ettl Martin

-- 
GMX.at - Österreichs FreeMail-Dienst mit über 2 Mio Mitgliedern
E-Mail, SMS & mehr! Kostenlos: http://portal.gmx.net/de/go/atfreemail

--========GMX295371269290102856509
Content-Type: text/x-patch; charset="iso-8859-15";
	name="Performance_improvements_cppcheck.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="Performance_improvements_cppcheck.patch"

diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index 6afbe98..571e50e 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -183,7 +183,7 @@ public:
   }
   void _calc_issued() {
     _issued = _pending;
-    for (list<revoke_info>::iterator p = _revokes.begin(); p != _revokes.end(); p++)
+    for (list<revoke_info>::iterator p = _revokes.begin(); p != _revokes.end(); ++p)
       _issued |= p->before;
   }
   void confirm_receipt(ceph_seq_t seq, unsigned caps) {
diff --git a/src/mds/MDSMap.h b/src/mds/MDSMap.h
index 533ec4f..2def085 100644
--- a/src/mds/MDSMap.h
+++ b/src/mds/MDSMap.h
@@ -220,7 +220,7 @@ public:
     unsigned n = 0;
     for (map<__u64,mds_info_t>::const_iterator p = mds_info.begin();
 	 p != mds_info.end();
-	 p++)
+	 ++p)
       if (p->second.state == state) ++n;
     return n;
   }
@@ -234,7 +234,7 @@ public:
   void get_up_mds_set(set<int>& s) {
     for (map<int32_t,__u64>::const_iterator p = up.begin();
 	 p != up.end();
-	 p++)
+	 ++p)
       s.insert(p->first);
   }
   void get_active_mds_set(set<int>& s) {
@@ -244,7 +244,7 @@ public:
     s = failed;
   }
   int get_failed() {
-    if (failed.size()) return *failed.begin();
+    if (!failed.empty()) return *failed.begin();
     return -1;
   }
   void get_stopped_mds_set(set<int>& s) {
@@ -254,14 +254,14 @@ public:
     s = failed;
     for (map<__u64,mds_info_t>::const_iterator p = mds_info.begin();
 	 p != mds_info.end();
-	 p++)
+	 ++p)
       if (p->second.state >= STATE_REPLAY && p->second.state <= STATE_STOPPING)
 	s.insert(p->second.rank);
   }
   void get_mds_set(set<int>& s, int state) {
     for (map<__u64,mds_info_t>::const_iterator p = mds_info.begin();
 	 p != mds_info.end();
-	 p++)
+	 ++p)
       if (p->second.state == state)
 	s.insert(p->second.rank);
   } 
@@ -278,7 +278,7 @@ public:
   __u64 find_standby_for(int mds, string& name) {
     for (map<__u64,mds_info_t>::const_iterator p = mds_info.begin();
 	 p != mds_info.end();
-	 p++) {
+	 ++p) {
       if (p->second.rank == -1 &&
 	  (p->second.standby_for_rank == mds ||
 	   p->second.standby_for_name == name) &&
@@ -289,7 +289,7 @@ public:
     }
     for (map<__u64,mds_info_t>::const_iterator p = mds_info.begin();
 	 p != mds_info.end();
-	 p++) {
+	 ++p) {
       if (p->second.rank == -1 &&
 	  p->second.standby_for_rank < 0 &&
 	  p->second.standby_for_name.length() == 0 &&
diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index ca8b9ae..465defc 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -385,7 +385,7 @@ struct inode_t {
     __u64 max = 0;
       for (map<client_t,byte_range_t>::const_iterator p = client_ranges.begin();
 	   p != client_ranges.end();
-	   p++)
+	   ++p)
 	if (p->second.last > max)
 	  max = p->second.last;
       return max;
@@ -396,7 +396,7 @@ struct inode_t {
     } else {
       for (map<client_t,byte_range_t>::iterator p = client_ranges.begin();
 	   p != client_ranges.end();
-	   p++)
+	   ++p)
 	p->second.last = new_max;
     }
   }
@@ -1331,7 +1331,7 @@ protected:
     }
     for (multimap<__u64,Context*>::iterator p = waiting.lower_bound(min);
 	 p != waiting.end();
-	 p++) {
+	 ++p) {
       if (p->first & mask) return true;
       if (p->first > mask) return false;
     }

--========GMX295371269290102856509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--========GMX295371269290102856509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--========GMX295371269290102856509--
