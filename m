From: Sage Weil <sage@newdream.net>
Subject: v0.32 released
Date: Mon, 1 Aug 2011 13:30:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108011329280.5415@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43067 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab1HAU0F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 16:26:05 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7A59FBC764
	for <ceph-devel@vger.kernel.org>; Mon,  1 Aug 2011 13:30:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2E2DABC764
	for <ceph-devel@vger.kernel.org>; Mon,  1 Aug 2011 13:30:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've released v0.32. Notable in this release:

 * common: perfcounter instrumentation now accessible via unix domain 
   socket
 * mon: dump cluster state in json format
 * client: fix a few stalls, ref count links, clustered mds misbehaviors
 * mds: many many clustering fixes, getting closer
 * mds: fix for O_APPEND behavior
 * osd: bug fixes in clone overlap tracking, accounting
 * osd: bug fixes in recovery code when clones/snapshots are present
 * radosgw: multithreaded fastcgi mode
 * radosgw: many small fixes
 * radosgw: consistent cache of bucket objects (ACLs)
 * CodingStyle document

For v0.33, we are working on more MDS clustering issues, collectd plugins 
(for per-daemon and cluster stats), better management of the internal 
directory structure on OSDs to facilitate PG splitting (scaling of object 
pools), the radosgw, and of course teuthology, our qa framework.

v0.32 can be found in the usual places:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.32.tar.gz
 * For Debian/Ubuntu packages see: http://ceph.newdream.net/wiki/Debian

