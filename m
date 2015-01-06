From: Sage Weil <sweil@redhat.com>
Subject: hammer timing
Date: Tue, 6 Jan 2015 09:42:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501060938110.6168@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43639 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbbAFRmN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Jan 2015 12:42:13 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t06HgDuZ004526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 6 Jan 2015 12:42:13 -0500
Received: from redhat.com ([10.3.112.19])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t06HgCm2028761
	for <ceph-devel@vger.kernel.org>; Tue, 6 Jan 2015 12:42:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Things were pretty slow over the holidays, so here's the current plan.

- Extend the current sprint (v0.92) until the end of this week (1/11).  
At that time the already-frozen v0.91 will get released and v0.92 will 
freeze.

- Do one more two week sprint (v0.93) from 1/12 to 1/25.  v0.92 will 
release and v0.93 will freeze.  This will effectively be the feature 
freeze for hammer.

- Two weeks after that we'll release v0.93, the first hammer release 
candidate.

- Hopefully two weeks after that v0.94 (final hammer) will follow.  This 
will depend on how things look stability-wise, though; we may want to do a 
second release candidate and make v0.95 hammer final.

Sound okay?
sage

