From: Ming Lin <minggr@gmail.com>
Subject: PGLog: optimize trim/rollback with pointer stored in list
Date: Wed, 5 Jul 2017 23:10:35 -0700
Message-ID: <2263ff96-b9eb-fceb-8257-300f47a65491@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35503 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdGFGKj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 02:10:39 -0400
Received: by mail-qt0-f179.google.com with SMTP id b40so7719868qtb.2
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jul 2017 23:10:38 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

I didn't send a PR for this patch since it's only for version 10.x.
Could you help to review it? Then we'll see whether it's ok to apply it
to our production system or not.

I'm tracking tail latency hot spot and below is one that I have found.

Test setup:
60 OSDs(5 servers each 12 OSDs)
128 fio clients with 16k randwrite

Thanks,
Ming

------
From 6b9a101e15b8baad45f581022c6aa8f20a8d82b2 Mon Sep 17 00:00:00 2001
From: Ming Lin <ming.lin@alibaba-inc.com>
Date: Thu, 6 Jul 2017 13:21:46 +0800
Subject: [PATCH] PGLog: optimize trim/rollback with pointer stored in list

Summary:
More than 20ms was measured in below push_back().

 981   struct PGLogEntryHandler : public PGLog::LogEntryHandler {
 982     list<pg_log_entry_t> to_rollback;
 983     set<hobject_t, hobject_t::BitwiseComparator> to_remove;
 984     list<pg_log_entry_t> to_trim;
 985     list<pair<hobject_t, version_t> > to_stash;
....
 997     void trim(const pg_log_entry_t &entry) {
 998       to_trim.push_back(entry);
 999     }

Seems it's heavy to copy the whole pg_log_entry_t to the list container.
This patch stores "const pg_log_entry_t *", instead of "pg_log_entry_t"
to the list container to optimize push_back performance.

Signed-off-by: Ming Lin <ming.lin@alibaba-inc.com>
---
 src/osd/PG.h              | 24 ++++++++++++------------
 src/osd/PGLog.cc          |  6 +++---
 src/osd/PGLog.h           |  4 ++--
 src/test/osd/TestPGLog.cc | 12 ++++++------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/src/osd/PG.h b/src/osd/PG.h
index 5456f12..c52bb2b 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -979,9 +979,9 @@ public:
   };

   struct PGLogEntryHandler : public PGLog::LogEntryHandler {
-    list<pg_log_entry_t> to_rollback;
+    list<const pg_log_entry_t *> to_rollback;
     set<hobject_t, hobject_t::BitwiseComparator> to_remove;
-    list<pg_log_entry_t> to_trim;
+    list<const pg_log_entry_t *> to_trim;
     list<pair<hobject_t, version_t> > to_stash;

     // LogEntryHandler
@@ -991,21 +991,21 @@ public:
     void try_stash(const hobject_t &hoid, version_t v) {
       to_stash.push_back(make_pair(hoid, v));
     }
-    void rollback(const pg_log_entry_t &entry) {
+    void rollback(const pg_log_entry_t *entry) {
       to_rollback.push_back(entry);
     }
-    void trim(const pg_log_entry_t &entry) {
+    void trim(const pg_log_entry_t *entry) {
       to_trim.push_back(entry);
     }

     void apply(PG *pg, ObjectStore::Transaction *t) {
-      for (list<pg_log_entry_t>::iterator j = to_rollback.begin();
+      for (list<const pg_log_entry_t *>::iterator j = to_rollback.begin();
 	   j != to_rollback.end();
 	   ++j) {
-	assert(j->mod_desc.can_rollback());
-	pg->get_pgbackend()->rollback(j->soid, j->mod_desc, t);
-	SnapRollBacker rollbacker(j->soid, pg, t);
-	j->mod_desc.visit(&rollbacker);
+	assert((*j)->mod_desc.can_rollback());
+	pg->get_pgbackend()->rollback((*j)->soid, (*j)->mod_desc, t);
+	SnapRollBacker rollbacker((*j)->soid, pg, t);
+	(*j)->mod_desc.visit(&rollbacker);
       }
       for (list<pair<hobject_t, version_t> >::iterator i = to_stash.begin();
 	   i != to_stash.end();
@@ -1018,11 +1018,11 @@ public:
 	pg->get_pgbackend()->rollback_create(*i, t);
 	pg->remove_snap_mapped_object(*t, *i);
       }
-      for (list<pg_log_entry_t>::reverse_iterator i = to_trim.rbegin();
+      for (list<const pg_log_entry_t *>::reverse_iterator i = to_trim.rbegin();
 	   i != to_trim.rend();
 	   ++i) {
-	LogEntryTrimmer trimmer(i->soid, pg, t);
-	i->mod_desc.visit(&trimmer);
+	LogEntryTrimmer trimmer((*i)->soid, pg, t);
+	(*i)->mod_desc.visit(&trimmer);
       }
     }
   };
diff --git a/src/osd/PGLog.cc b/src/osd/PGLog.cc
index ac3403c..2fb6a9d 100644
--- a/src/osd/PGLog.cc
+++ b/src/osd/PGLog.cc
@@ -46,7 +46,7 @@ void PGLog::IndexedLog::advance_rollback_info_trimmed_to(
       ++rollback_info_trimmed_to_riter;
       break;
     }
-    h->trim(*rollback_info_trimmed_to_riter);
+    h->trim(&(*rollback_info_trimmed_to_riter));
   }
 }

@@ -368,7 +368,7 @@ void PGLog::_merge_object_divergent_entries(
     last = i->version;

     if (rollbacker)
-      rollbacker->trim(*i);
+      rollbacker->trim(&(*i));
   }

   const eversion_t prior_version = entries.begin()->prior_version;
@@ -475,7 +475,7 @@ void PGLog::_merge_object_divergent_entries(
       ldpp_dout(dpp, 10) << __func__ << ": hoid " << hoid
 			 << " rolling back " << *i << dendl;
       if (rollbacker)
-	rollbacker->rollback(*i);
+	rollbacker->rollback(&(*i));
     }
     ldpp_dout(dpp, 10) << __func__ << ": hoid " << hoid
 		       << " rolled back" << dendl;
diff --git a/src/osd/PGLog.h b/src/osd/PGLog.h
index 098bab6..6fc8583 100644
--- a/src/osd/PGLog.h
+++ b/src/osd/PGLog.h
@@ -46,14 +46,14 @@ struct PGLog : DoutPrefixProvider {
   ////////////////////////////// sub classes //////////////////////////////
   struct LogEntryHandler {
     virtual void rollback(
-      const pg_log_entry_t &entry) = 0;
+      const pg_log_entry_t *entry) = 0;
     virtual void remove(
       const hobject_t &hoid) = 0;
     virtual void try_stash(
       const hobject_t &entry,
       version_t v) = 0;
     virtual void trim(
-      const pg_log_entry_t &entry) = 0;
+      const pg_log_entry_t *entry) = 0;
     virtual ~LogEntryHandler() {}
   };

diff --git a/src/test/osd/TestPGLog.cc b/src/test/osd/TestPGLog.cc
index 34d1313..5afe21d 100644
--- a/src/test/osd/TestPGLog.cc
+++ b/src/test/osd/TestPGLog.cc
@@ -156,10 +156,10 @@ public:

   struct LogHandler : public PGLog::LogEntryHandler {
     set<hobject_t, hobject_t::BitwiseComparator> removed;
-    list<pg_log_entry_t> rolledback;
+    list<const pg_log_entry_t *> rolledback;

     void rollback(
-      const pg_log_entry_t &entry) {
+      const pg_log_entry_t *entry) {
       rolledback.push_back(entry);
     }
     void remove(
@@ -170,7 +170,7 @@ public:
       // lost/unfound cases are not tested yet
     }
     void trim(
-      const pg_log_entry_t &entry) {}
+      const pg_log_entry_t *entry) {}
   };

   void verify_missing(
@@ -195,9 +195,9 @@ public:

     {
       list<pg_log_entry_t>::const_iterator titer = tcase.torollback.begin();
-      list<pg_log_entry_t>::const_iterator hiter = handler.rolledback.begin();
+      list<const pg_log_entry_t *>::const_iterator hiter = handler.rolledback.begin();
       for (; titer != tcase.torollback.end(); ++titer, ++hiter) {
-	EXPECT_EQ(titer->version, hiter->version);
+	EXPECT_EQ(titer->version, (*hiter)->version);
       }
     }

@@ -282,7 +282,7 @@ struct TestHandler : public PGLog::LogEntryHandler {
     // lost/unfound cases are not tested yet
   }
   void trim(
-    const pg_log_entry_t &entry) {}
+    const pg_log_entry_t *entry) {}
 };

 TEST_F(PGLogTest, rewind_divergent_log) {
-- 
1.9.1

