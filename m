From: Sage Weil <sweil@redhat.com>
Subject: master branch merges must pass unit tests
Date: Tue, 8 Nov 2016 21:49:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753391AbcKHVuZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 16:50:25 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C32680F99
        for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2016 21:49:44 +0000 (UTC)
Received: from ovpn-112-71.phx2.redhat.com (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA8LngBI008151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Tue, 8 Nov 2016 16:49:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I enabled the github check that the unit tests pass in order to merge to 
master.  These tests still aren't completely reliable, but they're close, 
and we'll make better progress if we start enforcing it now.

Note that core developers can still override the check to merge if 
it's necessary, but I encourage you to avoid doing so!

sage
