From: Sage Weil <sweil@redhat.com>
Subject: ceph-disk and 'make'
Date: Mon, 19 Sep 2016 00:40:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932596AbcISAkI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 18 Sep 2016 20:40:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic@dachary.org
Cc: ceph-devel@vger.kernel.org

I noticed that with the new cmake when I do a 'make' the ceph-disk target 
isn't built.  And ctest will fail most of its unit tests.  It looks like 
it is part of the 'tests' target, though.  Is it deliberate that a simple 
'make' doesn't build everything?

Thanks!
sage
