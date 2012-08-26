From: Sage Weil <sage@inktank.com>
Subject: v0.51 released
Date: Sun, 26 Aug 2012 08:58:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208260858010.11218@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42932 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2HZP6h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 11:58:37 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0D19380079
	for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 08:58:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D7FC880079
	for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 08:58:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The latest development release v0.51 is ready. Notable changes include:

 * crush: tunables documented; feature bit now present and enforced
 * osd: various fixes for out-of-order op replies
 * osd: several rare peering cases fixed
 * osd: fixed detection of EIO errors from fs on read
 * osd: new 'lock' rados class for generic object locking
 * librbd: fixed memory leak on discard
 * librbd: image layering/cloning
 * radosgw: fix range header for large objects, ETag quoting, GMT dates, 
   other compatibility fixes
 * mkcephfs: fix for default keyring, osd data/journal locations
 * wireshark: ceph protocol dissector patch updated
 * ceph.spec: fixed packaging problem with crush headers

Full RBD cloning support will be in place in v0.52, as will a refactor of 
the messenger code with many bug fixes in the socket failure handling. 
This is available for testing now in 'next' for the adventurous. Improved 
OSD scrubbing is also coming soon. We should (finally) be building some 
release RPMs for v0.52 as well.

You can get v0.51 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball athttp://ceph.newdream.net/download/ceph-0.51.tar.gz
 * For Debian/Ubuntu packages, seehttp://ceph.newdream.net/docs/master/install/debian
