From: Sage Weil <sweil@redhat.com>
Subject: hammer timing
Date: Mon, 30 Mar 2015 10:00:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503300951420.31431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbbC3RAN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Mar 2015 13:00:13 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id C6C4B8E7B7
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2015 17:00:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-30.phx2.redhat.com [10.3.112.30])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2UH0CA4029022
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2015 13:00:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The fix for #11177 (s/ceph.default.log/ceph.log/) uncovered a bunch of 
errors that have been showing up in the cluster (like scrub errors) that 
teuthology was missing.  Sam has squashed most of them already, but there 
is at least one still outstanding.  This will push out the hammer release 
until next Monday, most likely.

In the meantime, we can continue to validate the upgrade test results 
and/or work on post-hammer stuff.

sage
