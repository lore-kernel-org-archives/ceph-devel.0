From: Sage Weil <sage@newdream.net>
Subject: v0.23 released
Date: Fri, 12 Nov 2010 10:02:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011121001420.14310@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44324 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab0KLR6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 12:58:16 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 96D0ABC715
	for <ceph-devel@vger.kernel.org>; Fri, 12 Nov 2010 10:02:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6C0A1BC715
	for <ceph-devel@vger.kernel.org>; Fri, 12 Nov 2010 10:02:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Another month, and v0.23 is out.  The main milestone here is that 
clustered MDS is pretty stable.  Stable enough that, if you're interested 
and willing, we'd like you to try it and let us know what problems you 
have.  Notably, clustered recovery is not yet well tested (that's v0.24), 
so don't do this unless you're feeling adventurous.  Directory 
fragmentation (splitting and merging) is also working, although still off 
by default.  If you'd like to try that too, add 'mds bal frag = true' to 
your [mds] section.

Other notable changes this time around:
 * osd: use new btrfs snapshot ioctls (2.6.37), parallel journaling
 * mds: clustering, replay fixes
 * mon: better commit batches, lower latency updates
 * objecter: bug fixes
 * osd: spread data across multiple xattrs; assert on io/enospc errors
 * osd: start up despite corrupt pg logs
 * ceph: new gui (ceph -g)

The general focus for v0.24 will be continuing OSD stability and clustered 
MDS recovery.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.23.tar.gz
 * For Debian packages, see http://ceph.newdream.net/wiki/Debian

sage
