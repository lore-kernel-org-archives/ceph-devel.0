From: Sage Weil <sage@newdream.net>
Subject: v0.29 released
Date: Wed, 8 Jun 2011 10:58:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106081057430.1694@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47685 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1FHR4P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 13:56:15 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E2F8ABC6C4
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jun 2011 10:58:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C07C2BC6C4
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jun 2011 10:58:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph v0.29 is ready.  Notable changes since v0.28.2 include

 * mds: some fixes for multiple clients accessing the same directory
 * obsync: supports rados/rgw backend
 * osd: fix bug causing recovering objects to be excluded from object listing
 * rados: import/export support for xattrs, incremental updates
 * radosgw: misc fixes
 * libceph: readdir bug fixes
 * osd: fix for various heartbeat failures

Mainly we saw continued stabilization of the OSD peering code, which is 
now working quite well for us.  For v0.30 we're continuing to clean up a 
few OSD corner cases and working on clustered MDS problems.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/downloads/ceph-0.29.tar.gz
 * Debian and Ubuntu packages: http://ceph.newdream.net/wiki/Debian

