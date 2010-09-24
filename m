From: Sage Weil <sage@newdream.net>
Subject: roadmap
Date: Fri, 24 Sep 2010 15:48:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009241526010.17668@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50097 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0IXWqF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Sep 2010 18:46:05 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 83EDABC728
	for <ceph-devel@vger.kernel.org>; Fri, 24 Sep 2010 15:48:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 593F2BC728
	for <ceph-devel@vger.kernel.org>; Fri, 24 Sep 2010 15:48:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been working on keeping the roadmap in the project tracker up to date 
with the current release schedule and the features targetting each 
version.  That can be found at

	http://tracker.newdream.net/projects/ceph/roadmap

The main exception is that many bugs end up accumulating with the next 
stable release as a target (e.g., v0.21.4), and then (when they're not 
resolved) get pushed off to the next release.  And as releases get further 
into the future the picture gets a bit for hazy.

Those caveats aside, the basic schedule and goals are:

v0.22 (1-2 weeks away)
 - Stable and usable clustered MDS in non-failure conditions.  We will 
encourage anybody to test the clustered MDS for correctness, performance, 
and stability, and to report any and all issue.
 - Background OSD scrubbing.  This will help us catch remaining object 
replication/recovery problems sooner rather than later.
 - Stable RBD.

v0.23 (6 weeks away)
 - Stable clustered MDS failure recovery.
 - Stable directory fragmentation and defragmetnation.  (Fragmentation is 
what faciliates very large directories and the distribution of large 
directories over multiple nodes in the MDS cluster.)
 - RBD image locking.
 - Stable radosgw (S3 compatible REST proxy)

v1.0 (Christmas!)
 - Some basic fsck functionality
 - Cautious use in production setting.

This is all, of course, subject to change depending on what issues come up 
as we ramp up our testing and QA.  

I'm also interested in hearing from you what features or issues you are 
most interested in seeing us focus on.  What are your use cases?  If you 
have done any testing, what problems have you run into?  If you haven't, 
what is preventing you from testing (besides some promise of stability or 
production readiness)?

sage
