From: Sage Weil <sage@newdream.net>
Subject: v0.36 released
Date: Fri, 30 Sep 2011 19:58:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109301957240.4335@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38601 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab1JAC6w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Sep 2011 22:58:52 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C44B2BC6C2
	for <ceph-devel@vger.kernel.org>; Fri, 30 Sep 2011 19:58:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8E11BBC6C2
	for <ceph-devel@vger.kernel.org>; Fri, 30 Sep 2011 19:58:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's been three weeks and v0.36 is ready.  The most visible change this 
time around is that the daemons and tools have been renamed.  Everything 
that used to start with 'c' now starts with 'ceph-', and libceph is now 
libcephfs.  Nothing earth shattering, but we're trying to clean these 
things up where we can and deal with the pain sooner rather than later.  
(If you have any naming or tool usage pet peeves, let us know.)

Notable changes since v0.35:

 * librbd: api supports progress callbacks
 * librbd: python bindings (enabling our Openstack integration)
 * librbd: async writes (big write performance improvement)
 * libceph/cfuse: many fixes
 * osd: many fixes

The biggest item here is probably the librbd async write change, which 
affects qemu/KVM virtual machines using the RBD virtual disks.  Typical 
physical disk have a write cache and don't actually ensure your data is 
physically written to the platter until you issue a flush command (which 
modern file systems are now careful to do at critical points).  In 
contrast, RBD wouldn't acknowledge a write until it was written to the 
backend storage (all N replicas), which meant high latency writes and 
seemingly poor performance (even though throughput was theoretically very 
good).  librbd now buffers writes so that it behaves more like a disk, 
resulting in vastly improved performance for most typical workloads (like 
dd).  You still need to use the latest upstream qemu version to ensure 
that flush commands are properly handled, so this is still off by default; 
see this post for more information.  We haven't made the same change to 
the Linux kernel RBD driver, but it's coming soon.

We took an extra week this cycle due to a few trips (Yehuda, Bryan, and I 
were in Israel for a few days, and then I was at SDC last week), and may 
do that again this sprint.  Tommi and Bryan will be at the Openstack 
conference and design summit (don't miss Tommi's talk on RBD on Friday!) 
next week, and you'll see us in the Dell booth with a demo of Ceph, Chef, 
and barclamp.

For v0.37, the focus is on Chef cookbooks, Openstack integration, radosgw 
scalability improvements, and libvirt integration.

You can get v0.36 from:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at http://ceph.newdream.net/downloads/ceph-0.36.tar.gz
 * For Debian/Ubuntu/RedHat packages see http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#installing-the-packages

sage
