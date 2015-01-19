From: Sage Weil <sweil@redhat.com>
Subject: ./os/ObjectStore.h: 598: FAILED assert(op->oid < om.size())
Date: Mon, 19 Jan 2015 07:41:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501190739500.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51520 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbASPlx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Jan 2015 10:41:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yuandong1222@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi,

This has come up a couple times in QA since we merged the fast transaction 
code.  Can you take a look?

	http://tracker.ceph.com/issues/10517

Ping me if it will help to get access to the test cluster.  Haomai has 
access, and you can get the logs via http (linked from pulpito.ceph.com), 
but it is less convenient.

Thanks!
sage
