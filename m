From: Sage Weil <sweil@redhat.com>
Subject: filestore_fiemap is bad, memstore is buggy.
Date: Thu, 15 Sep 2016 21:48:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609152142570.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754029AbcIOVsM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Sep 2016 17:48:12 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0843C785F
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 21:48:11 +0000 (UTC)
Received: from ovpn-112-101.phx2.redhat.com (ovpn-112-101.phx2.redhat.com [10.3.112.101])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8FLm91B006141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 17:48:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I was adding tests for clone_range in preparation for improving the 
bluestore implementation and got stuck on memstore and filestore bugs!

The most alarming is that filestore very quickly fails the tests if 
filestore_fiemap is enabled.  It's off by default (phew!) but the 
ceph_test_objectstore test was explicitly enabling it to get better 
coverage.  For now I've just removed that so we stick with the default (no 
fiemap == good).  I wonder if we should consider removing fiemap from the 
code entirely, though, since it is clearly buggy, even on a modern kernel 
(I'm running 4.4 and XFS).

I also hit bugs in memstore.  I fixed the one in the BufferlistObject 
implementation, but the PageSet one I couldn't figure out after 20 
minutes, so I changed the default config to memstore_page_set = false for 
now.  Perhaps Casey or Adam or whoever wrote that can take a look?  It's 
very easy to reproduce.

See this PR:

	https://github.com/ceph/ceph/pull/11103

Thanks!
sage

