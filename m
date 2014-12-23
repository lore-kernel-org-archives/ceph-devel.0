From: Sage Weil <sweil@redhat.com>
Subject: full osdmaps in mon txns
Date: Tue, 23 Dec 2014 13:10:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412231306170.28630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaLWVKY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Dec 2014 16:10:24 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBNLAOX5004140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 23 Dec 2014 16:10:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: joao@redhat.com, gfarnum@redhat.com
Cc: ceph-devel@vger.kernel.org

This fun issue came up again in the form of 10422:

	http://tracker.ceph.com/issues/10422

I think we have 3 main options:

1. Ask users to do a mon scrub prior to upgrade to 
ensure it is safe.  If a mon is out of sync, manually kick it out, blow it 
away, and resync.

2. Do a one-time broadcast of the full osdmap across mons to ensure they 
are consistent after upgrade.  Bleh.

3. Include full encoded OSDMap in txns on updates going forward.

I like 3 because it solves this and all related problems going forward.  
The local encoding of full osdmaps has proven to be a huge headache.  
And, the patch to do it is remarkably simple

	https://github.com/ceph/ceph/pull/3247/files

and dovetails well with the new CRC.

What do you think?
sage
