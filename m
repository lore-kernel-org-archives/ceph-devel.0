From: Sage Weil <sage@newdream.net>
Subject: v0.24.2 released
Date: Tue, 25 Jan 2011 08:39:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38146 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1AYQjJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 11:39:09 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7825CBC75B
	for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 08:39:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 454E3BC75B
	for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 08:39:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a bugfix release.  Changes since v0.24.1 include:

 * osd: fix journal ordering bug/crash
 * osd: fix long sync delay
 * osd: don't overflow journal size
 * osd: snapshot trimming bugs
 * osd: fix messenger connection issues after restart
 * osd: don't crash on no-journal case
 * mds: fix double-pinning of stray inodes (crash)
 * mds: don't block signals after restart
 * mds: fix journaling of root inode layout policy
 * mds: fix journal dump
 * mds: C_Gather locking fix
 * msgr: fix connection cleanup on non-daemons
 * monclient: fix locking

Relevant URLs:

 * Direct download at: http://ceph.newdream.net/download/ceph-0.24.2.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian
