From: Sage Weil <sage@newdream.net>
Subject: lookuphash
Date: Thu, 31 Mar 2011 18:23:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103311819510.28788@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37394 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab1DABUY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 21:20:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: brchrisman@gmail.com
Cc: ceph-devel@vger.kernel.org

Hey Brian,

I just pushed some improvements to the MDS lookuphash that should fix the 
NFS issues.  The first piece will search for an ino in other MDS's caches 
(this actually needed for cross-mds unlink/rename as well).  The other 
piece looks at the on-disk directory objects to discover the ino path and 
then does a traverse.  Both methods are now wired up to lookuphash.

Once you have a test case that can reliably reproduce the NFS ESTALE, 
let's see if this fixes it!  (You may have to disable it with something 
like the below to get the test case right.  The improvements are now in 
the master branch of ceph.git.)

Thanks!
sage


diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 58be710..0b36011 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2065,8 +2065,9 @@ void Server::handle_client_lookup_hash(MDRequest 
*mdr)
     // try the directory
     CInode *diri = mdcache->get_inode(req->get_filepath2().get_ino());
     if (!diri) {
-      mdcache->find_ino_peers(req->get_filepath2().get_ino(),
-                             new C_MDS_LookupHash(this, mdr), -1);
+      reply_request(mdr, -ESTALE);
+      /*      mdcache->find_ino_peers(req->get_filepath2().get_ino(),
+             new C_MDS_LookupHash(this, mdr), -1);*/
       return;
     }
     if (diri->state_test(CInode::STATE_PURGING)) {





