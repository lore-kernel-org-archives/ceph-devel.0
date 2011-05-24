From: Sage Weil <sage@newdream.net>
Subject: v0.28.1 released
Date: Tue, 24 May 2011 07:36:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105240735390.31474@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58067 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab1EXOfG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 10:35:06 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0B4D3BC69F
	for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 07:36:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C8828BC69F
	for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 07:36:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I tagged and uploaded v0.28 a week ago but forgot to blog and email about 
it. That may be just as well, as there were a number of issues that got 
fixed last week. I'll separate out the main items.

Changes for v0.28:
 * osd: peering code refactor
 * osd: long object name support
 * osd: removed fragile class distribution mechanism (now left to admin to 
   distribute .so's)
 * mds: many clustered mds fixes
 * libceph: xattr operations, api update
 * mon: 'health' command more robust
 * obsync: many improvements (ACL translation, content-type, attrs, 
   packages)
 * rbd: map/unmap kernel devices via 'rbd map' and 'rbd unmap' commands
 * crush: allow - and _ in names, fixed whitespace during compile
 * radosgw: many many fixes

Changes for v0.28.1:
 * osd: heartbeat exchange fixes (for many 'wrongly marked down')
 * osd: peering fixes
 * daemons: reopen log file on SIGHUP fixed
 * mds: fix journal expire crash (after mds restart)
 * libceph/cfuse: fix sync write crash

The focus for v0.29 is mainly stability.  The only new features are for 
obsync (so it can sync directly to rados) and some usability improvements 
for programatically managing CRUSH maps for larger clusters.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.28.1.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian

sage
