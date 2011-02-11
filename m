From: Sage Weil <sage@newdream.net>
Subject: v0.24.3
Date: Fri, 11 Feb 2011 11:35:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102111129160.15922@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57009 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab1BKTeR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Feb 2011 14:34:17 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 379E9BC69F
	for <ceph-devel@vger.kernel.org>; Fri, 11 Feb 2011 11:35:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D3A4ABC69F
	for <ceph-devel@vger.kernel.org>; Fri, 11 Feb 2011 11:35:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've released v0.24.3 with more bug fixes, including one that loses data 
in certain cases when OSDs restart during recovery.  It's pretty much all 
OSD stuff, which is where we're focusing our testing efforts currently.

 * osd: misc crashes, slowness
 * osd: fix bug that loses backlog (and potentially data)
 * osd: scrub fixes
 * osd: snap_trimmer fixes
 * mds: fix bug with multi-client interaction/slowness

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.24.3.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian

sage

