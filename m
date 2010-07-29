From: Sage Weil <sage@newdream.net>
Subject: v0.21 released
Date: Thu, 29 Jul 2010 13:04:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007291303220.799@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57740 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0G2UCH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jul 2010 16:02:07 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 29E43BC940
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 13:04:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EC0E7BC940
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 13:04:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's been a while, but v0.21 is ready.  Most of the work this time 
around has been on stability. There is one key new feature, however: RBD, 
the rados block device, which let you create a virtual disk backed by 
objects stored in the Ceph cluster.  The images can be mapped natively by 
the ceph kernel module or via a driver in qemu/KVM.  Although neither of 
those drivers is upstream yet, the server side functionality and admin 
tools are in place.

Changes since v0.20 include:

    * improved logging infrastructure
    * log rotate
    * mkfs improvements
    * rbd tool, and rados class
    * mds: return ENOTEMPTY when removing directory with snapshots
    * mds: lazy io support (experimental)
    * msgr: send messages directory to connection handles (more efficient)
    * faster atomic_t via libatomic-ops
    * mon: recovery improvements, fixes (e.g. when one mon is down for a 
long time)
    * mon: warn on monitor clock drift
    * osd: large object support
    * osd: heartbeat improvements, fixes
    * osd: journaling fixes, improvements (bugs, better use of direct io)
    * osd: snapshot rollback op (for rbd)
    * radosgw fixes, improvements
    * many memory leaks and other bugs fixed

The project roadmap has been updated and is available via the issue 
tracker at

	http://tracker.newdream.net/projects/ceph/roadmap

Relevant URLs:

    * Direct download at http://ceph.newdream.net/download/ceph-0.21.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

sage
