From: Sage Weil <sage@newdream.net>
Subject: v0.24 released
Date: Mon, 20 Dec 2010 18:28:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012201828110.29684@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55716 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933484Ab0LUCX0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 21:23:26 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 60088BC80F
	for <ceph-devel@vger.kernel.org>; Mon, 20 Dec 2010 18:28:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2F7C2BC80F
	for <ceph-devel@vger.kernel.org>; Mon, 20 Dec 2010 18:28:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've released v0.24, just in time for the holidays!  Big changes this 
time around include:

 * mds: many fixes with clustered failure recovery
 * mds: bloom filter to reduce directory reads
 * mds: configurable directory hash functions (for fragmentation)
 * rbd: import/export tools are smart about holes (i.e., use FIEMAP)
 * osd: many recovery improvements, mostly making data available more 
   quickly
 * osd: automatic background scrubbing when load is low
 * osd: fixes with dedicated backend replication network
 * osd: use new (2.6.37) btrfs ioctls for async snapshot creation
 * replaced openssl dependency with libcrypto++ (licensing issue)
 * librados: "zero-copy" reads
 * misc bug fixes, man pages, and code cleanup

The focus for the next release (v0.25) is on OSD and MDS stability, 
directory fragmentation recovery, and fsck preliminaries; see the roadmap 
for more details.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.24.tar.gz
 * For Debian packages, see http://ceph.newdream.net/wiki/Debian

sage
