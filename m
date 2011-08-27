From: Sage Weil <sage@newdream.net>
Subject: v0.34 released
Date: Sat, 27 Aug 2011 09:54:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108270953210.14206@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33735 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1H0QtS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Aug 2011 12:49:18 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D0061BC6C2
	for <ceph-devel@vger.kernel.org>; Sat, 27 Aug 2011 09:54:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A4018BC6C2
	for <ceph-devel@vger.kernel.org>; Sat, 27 Aug 2011 09:54:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Another 2 weeks, another release. Notable changes in v0.34:

 * radosgw: atomic GET and PUT (and some groundwork for supporting 
   versioning)
 * librados: API tests
 * mon: fix for data corruption for certain crashes
 * cfuse/libceph: many many many bug fixes
 * osd: fix for various races during pool/pg creation
 * osd: fix for a few peering crashes
 * mds: misc fixes

For v0.35 the focus remains on testing and stability. The FileStore 
changes should land in the next release, and will include an on-disk 
format change and a slightly-manual upgrade process (sorry!). These will 
let the object store efficiently scale pool sizes (PG counts). Eventually 
automatically. There is also work on RBD, librbd, libvirt, collectd 
plugins, and of course ongoing improvements to radosgw.

We're having an increasingly difficult time breaking the OSDs, cfuse, 
and a (single-node) MDS. Any bug reports are most welcome!

We've also been working on some Chef cookbooks internally, and hope to 
share those in the next couple weeks.

Where to get v0.34:

 * Git: git://ceph.newdream.net/git/ceph.git
 * Release tarball: http://ceph.newdream.net/downloads/ceph-0.34.tar.gz
 * For Debian/Ubuntu packages see: http://ceph.newdream.net/wiki/Debian
