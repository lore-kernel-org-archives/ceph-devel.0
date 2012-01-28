From: Sage Weil <sage@newdream.net>
Subject: v0.41 released
Date: Sat, 28 Jan 2012 15:29:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201281528570.28466@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43316 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab2A1X33 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jan 2012 18:29:29 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4D567BC7EC
	for <ceph-devel@vger.kernel.org>; Sat, 28 Jan 2012 15:29:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1231FBC7EC
	for <ceph-devel@vger.kernel.org>; Sat, 28 Jan 2012 15:29:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.41 is ready!  There are a few key things in this release:

 * osd: new 'backfill' recovery code (less memory, faster)
 * osd: misc bug fixes (scrub, out of order replies)
 * radosgw: better logging
 * librados: improved api for compound operations

For v0.42 we're working on improved journal performance for the OSD, 
better encoding for data structures (to ease upgrades and downgrades), rgw 
performance improvements, and an efficient key/value object interface.

You can download v0.41 from the usual places:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.41.tar.gz
 * For Debian/Ubuntu packages, see
   http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#installing-the-packages
 
sage
