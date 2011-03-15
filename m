From: Sage Weil <sage@newdream.net>
Subject: v0.25.1 released
Date: Mon, 14 Mar 2011 21:38:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103141645040.21728@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43304 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab1COEfm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2011 00:35:42 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 79F1ABC7A7
	for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2011 21:38:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 488D4BC7A7
	for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2011 21:38:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This a bugfix release.  If you're using librados or librbd, please 
upgrade, as there are some small API fixes.  If not, there isn't anything 
too critical here aside from some OSD recovery corner cases.

 * librados: some size_t -> uint64_t type conversions to support large 
   objects
 * librbd: lots of size_t -> uint64_t conversions for 32-bit systems
 * cfuse: daemonize fixed
 * debian: rbd udev rules
 * time conversions fixed for some cases (off by factor of 10)
 * osd: pool creation faster
 * osd: some recovery fixes
 * mds: fixed a mds failover bug (corrupted journal)
 * misc small fixes

We're trying to do a quicker major release cycle as we move toward 1.0, 
and are aiming for v0.26 in another week and a half.

As always, the thing we are most interested in is help with testing.  
Please send bug reports to the list or stick them directly in the tracker 
at http://tracker.newdream.net.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.25.1.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian
