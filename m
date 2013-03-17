From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/39] mds: send table request when peer is in proper state.
Date: Sun, 17 Mar 2013 22:51:08 +0800
Message-ID: <1363531902-24909-6-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab3CQOwF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:05 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Table client/server should send request/reply when the peer is active.
Anchor query is an exception, because MDS in rejoin stage may need
fetch files before sending rejoin ack, the anchor server can also be
in rejoin stage.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/AnchorClient.cc   | 5 ++++-
 src/mds/MDSTableClient.cc | 9 ++++++---
 src/mds/MDSTableServer.cc | 3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/mds/AnchorClient.cc b/src/mds/AnchorClient.cc
index 455e97f..d7da9d1 100644
--- a/src/mds/AnchorClient.cc
+++ b/src/mds/AnchorClient.cc
@@ -80,9 +80,12 @@ void AnchorClient::lookup(inodeno_t ino, vector<Anchor>& trace, Context *onfinis
 
 void AnchorClient::_lookup(inodeno_t ino)
 {
+  int ts = mds->mdsmap->get_tableserver();
+  if (mds->mdsmap->get_state(ts) < MDSMap::STATE_REJOIN)
+    return;
   MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_QUERY, 0, 0);
   ::encode(ino, req->bl);
-  mds->send_message_mds(req, mds->mdsmap->get_tableserver());
+  mds->send_message_mds(req, ts);
 }
 
 
diff --git a/src/mds/MDSTableClient.cc b/src/mds/MDSTableClient.cc
index beba0a3..df0131f 100644
--- a/src/mds/MDSTableClient.cc
+++ b/src/mds/MDSTableClient.cc
@@ -149,9 +149,10 @@ void MDSTableClient::_prepare(bufferlist& mutation, version_t *ptid, bufferlist
 void MDSTableClient::send_to_tableserver(MMDSTableRequest *req)
 {
   int ts = mds->mdsmap->get_tableserver();
-  if (mds->mdsmap->get_state(ts) >= MDSMap::STATE_CLIENTREPLAY)
+  if (mds->mdsmap->get_state(ts) >= MDSMap::STATE_CLIENTREPLAY) {
     mds->send_message_mds(req, ts);
-  else {
+  } else {
+    req->put();
     dout(10) << " deferring request to not-yet-active tableserver mds." << ts << dendl;
   }
 }
@@ -193,7 +194,9 @@ void MDSTableClient::got_journaled_ack(version_t tid)
 void MDSTableClient::finish_recovery()
 {
   dout(7) << "finish_recovery" << dendl;
-  resend_commits();
+  int ts = mds->mdsmap->get_tableserver();
+  if (mds->mdsmap->get_state(ts) >= MDSMap::STATE_CLIENTREPLAY)
+    resend_commits();
 }
 
 void MDSTableClient::resend_commits()
diff --git a/src/mds/MDSTableServer.cc b/src/mds/MDSTableServer.cc
index 4f86ff1..07c7d26 100644
--- a/src/mds/MDSTableServer.cc
+++ b/src/mds/MDSTableServer.cc
@@ -159,7 +159,8 @@ void MDSTableServer::handle_mds_recovery(int who)
   for (map<version_t,mds_table_pending_t>::iterator p = pending_for_mds.begin();
        p != pending_for_mds.end();
        ++p) {
-    if (who >= 0 && p->second.mds != who)
+    if ((who >= 0 && p->second.mds != who) ||
+	mds->mdsmap->get_state(p->second.mds) < MDSMap::STATE_CLIENTREPLAY)
       continue;
     MMDSTableRequest *reply = new MMDSTableRequest(table, TABLESERVER_OP_AGREE, p->second.reqid, p->second.tid);
     mds->send_message_mds(reply, p->second.mds);
-- 
1.7.11.7

