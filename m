From: Sage Weil <sage@newdream.net>
Subject: v0.26 released
Date: Tue, 5 Apr 2011 16:29:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104051628450.3702@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59120 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab1DEX0o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 19:26:44 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id ACC84BC7A9
	for <ceph-devel@vger.kernel.org>; Tue,  5 Apr 2011 16:29:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 72C00BC7A9
	for <ceph-devel@vger.kernel.org>; Tue,  5 Apr 2011 16:29:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We tagged v0.26 a few days ago.  Changes since the last release include:

 * misc build, configure, rpm build fixes
 * crypto: support for libnss (which exists in RHEL environments)
 * osd: improved throttling
 * osd: scrub no longer blocks requests
 * osd: vastly improved map update performance
 * osd: recovery fixes
 * librados, osd: support for object locator strings
 * librados: API fixes, extensions
 * mds: recovery fix for large directories
 * mds: journaling fixes
 * mds: rstats fixes
 * radosgw: Swift API support.  many fixes

For v0.27 we're continuing to focus on stabilizing the OSD and radosgw.  
There have also been a flurry of bugs found (and fixed!) in the MDS with 
fsstress from LTP (which, BTW, is a pretty great tool).  As part of this 
we're chipping away at the clustered MDS problems as well.  See the 
current roadmap for the next few intermediate releases and current set of 
desired 1.0 features.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.26.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian
