From: Sage Weil <sweil@redhat.com>
Subject: There is no next; only jewel
Date: Mon, 9 Nov 2015 14:03:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511091400130.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbbKIWDz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Nov 2015 17:03:55 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id B67E88F4E6
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2015 22:03:55 +0000 (UTC)
Received: from redhat.com ([10.3.112.10])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tA9M3sFN020049
	for <ceph-devel@vger.kernel.org>; Mon, 9 Nov 2015 17:03:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey everyone,

Just a reminder that now that infernalis is out and we're back to focusing 
on jewel, we should send all bug fixes to the 'jewel' branch (which 
functions the same way the old 'next' branch did).  That is,

 bug fixes -> jewel
 new features -> master

Every dev release (hopefully we'll get back on a 2 week shedule) we'll 
slurp master into jewel for the next sprint.  And during each sprint we'll 
test/stabilize the jewel branch.

Expect feature freeze to be February-ish.

Thanks!
sage
