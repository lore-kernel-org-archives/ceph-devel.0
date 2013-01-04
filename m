From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/29] mds: fix on-going two phrase commits tracking
Date: Fri,  4 Jan 2013 17:02:03 +0800
Message-ID: <1357290140-17044-13-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50946 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677Ab3ADJCl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:41 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The slaves for two phrase commit should be mdr->more()->witnessed
instead of mdr->more()->slaves. mdr->more()->slaves includes MDS
for remote auth pin and lock

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index e17f826..6700eda 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4076,11 +4076,11 @@ void Server::_link_remote(MDRequest *mdr, bool inc, CDentry *dn, CInode *targeti
   EUpdate *le = new EUpdate(mdlog, inc ? "link_remote":"unlink_remote");
   mdlog->start_entry(le);
   le->metablob.add_client_req(mdr->reqid, mdr->client_request->get_oldest_client_tid());
-  if (!mdr->more()->slaves.empty()) {
-    dout(20) << " noting uncommitted_slaves " << mdr->more()->slaves << dendl;
+  if (!mdr->more()->witnessed.empty()) {
+    dout(20) << " noting uncommitted_slaves " << mdr->more()->witnessed << dendl;
     le->reqid = mdr->reqid;
     le->had_slaves = true;
-    mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->slaves);
+    mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->witnessed);
   }
 
   if (inc) {
@@ -4655,11 +4655,11 @@ void Server::_unlink_local(MDRequest *mdr, CDentry *dn, CDentry *straydn)
   EUpdate *le = new EUpdate(mdlog, "unlink_local");
   mdlog->start_entry(le);
   le->metablob.add_client_req(mdr->reqid, mdr->client_request->get_oldest_client_tid());
-  if (!mdr->more()->slaves.empty()) {
-    dout(20) << " noting uncommitted_slaves " << mdr->more()->slaves << dendl;
+  if (!mdr->more()->witnessed.empty()) {
+    dout(20) << " noting uncommitted_slaves " << mdr->more()->witnessed << dendl;
     le->reqid = mdr->reqid;
     le->had_slaves = true;
-    mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->slaves);
+    mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->witnessed);
   }
 
   if (straydn) {
@@ -5493,13 +5493,13 @@ void Server::handle_client_rename(MDRequest *mdr)
   EUpdate *le = new EUpdate(mdlog, "rename");
   mdlog->start_entry(le);
   le->metablob.add_client_req(mdr->reqid, mdr->client_request->get_oldest_client_tid());
-  if (!mdr->more()->slaves.empty()) {
-    dout(20) << " noting uncommitted_slaves " << mdr->more()->slaves << dendl;
+  if (!mdr->more()->witnessed.empty()) {
+    dout(20) << " noting uncommitted_slaves " << mdr->more()->witnessed << dendl;
     
     le->reqid = mdr->reqid;
     le->had_slaves = true;
     
-    mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->slaves);
+    mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->witnessed);
   }
   
   _rename_prepare(mdr, &le->metablob, &le->client_map, srcdn, destdn, straydn);
-- 
1.7.11.7

