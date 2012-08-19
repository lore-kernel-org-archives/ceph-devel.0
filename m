From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Sun, 19 Aug 2012 00:00:46 -0300
Message-ID: <orzk5ra8m9.fsf@livre.localdomain>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
	<ork43bbbbb.fsf@livre.localdomain>
	<Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
	<ora9xsbm9w.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:47227 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753600Ab2HSDBO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 18 Aug 2012 23:01:14 -0400
In-Reply-To: <ora9xsbm9w.fsf@livre.localdomain> (Alexandre Oliva's message of
	"Sat, 18 Aug 2012 06:08:11 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Aug 18, 2012, Alexandre Oliva <oliva@lsd.ic.unicamp.br> wrote:

> I've looked further into this tonight, and I found out what modifies
> the timestamps in the inode is (re)issuing caps to a client.

> So, how can we stop pre_cow_old_inode from messing with the old_inode?
> Any suggestions?

This patch seems to avoid the problem, but is it correct, or is it just
papering over a problem elsewhere?

Subject: mds: Don't modify already-created old_inode

In cow_old_inode, do not modify an old_inode that was created before.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/mds/CInode.cc |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 53f9e69..fdff86c 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2030,12 +2030,16 @@ old_inode_t& CInode::cow_old_inode(snapid_t follows, bool cow_head)
   inode_t *pi = cow_head ? get_projected_inode() : get_previous_projected_inode();
   map<string,bufferptr> *px = cow_head ? get_projected_xattrs() : get_previous_projected_xattrs();
 
+  bool found = old_inodes.find(follows) != old_inodes.end();
   old_inode_t &old = old_inodes[follows];
-  old.first = first;
-  old.inode = *pi;
-  old.xattrs = *px;
-  
-  dout(10) << " " << px->size() << " xattrs cowed, " << *px << dendl;
+
+  if (!found) {
+    old.first = first;
+    old.inode = *pi;
+    old.xattrs = *px;
+
+    dout(10) << " " << px->size() << " xattrs cowed, " << *px << dendl;
+  }
 
   old.inode.trim_client_ranges(follows);
 
-- 
1.7.7.6



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
