From: Sage Weil <sage@newdream.net>
Subject: v0.22 released
Date: Fri, 15 Oct 2010 16:50:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010151648220.30297@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34815 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab0JOXsL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Oct 2010 19:48:11 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 40E46BC704
	for <ceph-devel@vger.kernel.org>; Fri, 15 Oct 2010 16:50:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1F10FBC704
	for <ceph-devel@vger.kernel.org>; Fri, 15 Oct 2010 16:50:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

It's a bit late, but v0.22 is here.  The original goal for this release 
was to have a stable clustered MDS that we can encourage users to test.  
Unfortunately, we did not quite make that mark: there are still a couple 
significant bugs we're working on, and I don't want to push this release 
back any farther.  In retrospect, having such an infrequent release 
schedule to begin with (>2 months since v0.21!) makes our life harder 
because we are tracking bug fixes in both branches, and end up with a long 
delay between a new feature being merged and most users testing it.  For 
the next release (and the immediate future), we will be aiming for more 
frequent releases, and will stick as close as possible to the original 
timeline.

Notable changes in v0.22 include:
 * mon: improved naming
 * osd: support separate interface for cluster-internal traffic
 * mds: many many snapshot, recursive accounting fixes
 * mon: back off on clock drift errors/warnings
 * mds: fix xattr bugs
 * cfuse: readdir caching, readdir fixes
 * mon: trim laggy standby mds's from map
 * osd: data integrity fixes
 * osd: fix hang during mkfs/journal creation
 * improved debug logging on crash
 * cdebugpack: new debug information capture tool
 * mon: improve osd failure logic
 * mds/osd: use tcmalloc (faster, more memory efficient)
 * mds: set file layout/striping policy on directory/subtree basis
 * cfuse: mount subdir
 * mds: respawn on failure

At a high level, the goals for v0.23 are a stable clustered MDS and 
directory fragmentation.  We are also continuing to work on hardening the 
OSD cluster recovery, particularly given the level of interest in RBD.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.22.tar.gz
 * For Debian packages, see http://ceph.newdream.net/wiki/Debian

sage
