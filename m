From: Sage Weil <sweil@redhat.com>
Subject: v9.0.2 is tagged, next branch is updated
Date: Thu, 16 Jul 2015 09:06:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507160905000.8878@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39981 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627AbbGPQG3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jul 2015 12:06:29 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 5AA0C8E67E
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2015 16:06:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-48.phx2.redhat.com [10.3.112.48])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6GG6RfN007742
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2015 12:06:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v9.0.2 is tagged and build (release notes will be out later today).

I've merged next into master and fast-forwarded next to current master on 
ceph.git and ceph-qa-suite.git.

Time to pay attention to the test suites against next again and make sure 
they stabilize!

sage
