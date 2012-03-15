From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Wed, 14 Mar 2012 21:38:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203142130410.19048@cobra.newdream.net>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
 <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
 <A0D9F03B-8FA9-4731-9BCF-3207166ECC23@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52603 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab2COEiW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 00:38:22 -0400
In-Reply-To: <A0D9F03B-8FA9-4731-9BCF-3207166ECC23@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org

On Wed, 14 Mar 2012, Noah Watkins wrote:
> On Mar 7, 2012, at 10:02 AM, Noah Watkins wrote:
> 
> > As for producing an upstream patch, I think the two biggest concerns are:
> > 
> > 1. Reporting hostname/racks rather than IPs for object location.
> > 2. Address (or at least document) the time synchronization issue.
> 
> Regarding (1), my last comment in this ticket (http://tracker.newdream.net/issues/1666) seems to indicate that a stat occurs on a client and the mtime in the cached inode is returned, but the client is expecting the mtime in the updated inode in the OSD.
> 
> Is there an easy way to invalidate the the inodes in a client to at 
> least verify the problem?

Well, you can kludge the code to do it with

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 4a9ae3c..2bb24b7 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -3858,7 +3858,7 @@ int Client::readlink(const char *relpath, char *buf, loff_t size)
 
 int Client::_getattr(Inode *in, int mask, int uid, int gid)
 {
-  bool yes = in->caps_issued_mask(mask);
+  bool yes = false; //in->caps_issued_mask(mask);
 
   ldout(cct, 10) << "_getattr mask " << ccap_string(mask) << " issued=" << yes << dendl;
   if (yes)

A less intrusive workaround would be to do a readdir on the containing 
directory, which will refresh the client inode.

I'm still not sure what a graceful solution to the problem is... :(

sage
