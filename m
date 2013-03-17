From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/39] mds: make sure table request id unique
Date: Sun, 17 Mar 2013 22:51:07 +0800
Message-ID: <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab3CQOwC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:02 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When a MDS becomes active, the table server re-sends 'agree' messages
for old prepared request. If the recoverd MDS starts a new table request
at the same time, The new request's ID can happen to be the same as old
prepared request's ID, because current table client assigns request ID
from zero after MDS restarts.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDS.cc            | 3 +++
 src/mds/MDSTableClient.cc | 5 +++++
 src/mds/MDSTableClient.h  | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index bb1c833..859782a 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1212,6 +1212,9 @@ void MDS::boot_start(int step, int r)
 	dout(2) << "boot_start " << step << ": opening snap table" << dendl;	
 	snapserver->load(gather.new_sub());
       }
+
+      anchorclient->init();
+      snapclient->init();
       
       dout(2) << "boot_start " << step << ": opening mds log" << dendl;
       mdlog->open(gather.new_sub());
diff --git a/src/mds/MDSTableClient.cc b/src/mds/MDSTableClient.cc
index ea021f5..beba0a3 100644
--- a/src/mds/MDSTableClient.cc
+++ b/src/mds/MDSTableClient.cc
@@ -34,6 +34,11 @@
 #undef dout_prefix
 #define dout_prefix *_dout << "mds." << mds->get_nodeid() << ".tableclient(" << get_mdstable_name(table) << ") "
 
+void MDSTableClient::init()
+{
+  // make reqid unique between MDS restarts
+  last_reqid = (uint64_t)mds->mdsmap->get_epoch() << 32;
+}
 
 void MDSTableClient::handle_request(class MMDSTableRequest *m)
 {
diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
index e15837f..78035db 100644
--- a/src/mds/MDSTableClient.h
+++ b/src/mds/MDSTableClient.h
@@ -63,6 +63,8 @@ public:
   MDSTableClient(MDS *m, int tab) : mds(m), table(tab), last_reqid(0) {}
   virtual ~MDSTableClient() {}
 
+  void init();
+
   void handle_request(MMDSTableRequest *m);
 
   void _prepare(bufferlist& mutation, version_t *ptid, bufferlist *pbl, Context *onfinish);
-- 
1.7.11.7

