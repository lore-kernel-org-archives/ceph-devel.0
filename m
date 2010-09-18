From: Sage Weil <sage@newdream.net>
Subject: v0.21.3 released
Date: Sat, 18 Sep 2010 14:09:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009181408590.20343@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41564 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0IRVHy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Sep 2010 17:07:54 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6F786BC670
	for <ceph-devel@vger.kernel.org>; Sat, 18 Sep 2010 14:09:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4142DBC670
	for <ceph-devel@vger.kernel.org>; Sat, 18 Sep 2010 14:09:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The v0.21.3 release is out.  Changes since v0.21.2 include:

 - cfuse: fix readdir for large directories
 - cfuse: fixed truncation (now passes fsx)
 - radosgw: fixed some info leakage between users
 - radosgw: support wildcard dns for bucketname.domain/object access
 - mon: less log noise
 - mds: fixed snap bug with directory renames
 - mds: fixed journal replay bug with reconnecting clients
 - mds: fixed journal replay bug with inconsistent lock state, subsequent 
   crash

Nothing groundbreaking, but v0.21.2 users experiencing any problems should 
upgrade.

This will likely be the last v0.21 series release; v0.22 is due in about 
two weeks (see the roadmap).

Relevant URLs:

 - Direct download at: http://ceph.newdream.net/download/ceph-0.21.3.tar.gz
 - For Debian packages, see http://ceph.newdream.net/wiki/Debian

sage
