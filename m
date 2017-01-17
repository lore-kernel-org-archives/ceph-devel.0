From: Sage Weil <sweil@redhat.com>
Subject: IMPORTANT: removing clone_range, assert_src_version, src_cmpxattr
Date: Tue, 17 Jan 2017 18:23:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701171819060.1661@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdAQSas (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Jan 2017 13:30:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C71C288E60
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2017 18:23:05 +0000 (UTC)
Received: from ovpn-112-25.rdu2.redhat.com (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0HIN4oj000626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2017 13:23:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We plan to remove the librados clone_range, assert_src_version, and 
src_cmpxattr operations.  These operations were introduced in 
distant past in order to support an early design of RGW, but are not 
longer used by anything in the tree, are largely untested, and are 
difficult to continue to support.  These are the only operations that allo 
a single librados operation to operate on multiple objects.

I think it is pretty unlikely that there are any users for these 
operations, but if you are out there, speak up now!

Note that there is a proposed rados extension that adds support for 
multi-object transactions.  These are *much* more powerful than this older 
capability, which is fragile and hard to use.  The proposed extension has 
a PR that is open for review, but it is still not clear whether this is 
the design path we want to take (or whether it is worth the cost of 
complexity in the OSD to support it at all).  Any librados API user 
feedback would be helpful.

Thanks!
sage

