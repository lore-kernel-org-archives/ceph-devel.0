From: Sage Weil <sweil@redhat.com>
Subject: bind_addr bug
Date: Thu, 20 Jul 2017 17:04:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707201559200.14061@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934523AbdGTREj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Jul 2017 13:04:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam.Tabbara@Quantum.com, Travis.Nielsen@Quantum.com
Cc: ceph-devel@vger.kernel.org

Hi Bassam, Travis,

The change in bf4938567943c80345966f9c5a3bdc75a913175b to tolerate a peer 
addr that is wrong indirectly led to

	http://tracker.ceph.com/issues/20667

The direct bug there should be fixed by

	https://github.com/ceph/ceph/pull/16455

but I think the behavior change in your commit is still problematic.  And 
looking at this again, I'm not quite sure why we need it.  Once we do 
the set_addr, can't we just advertise that addr during the handshake so 
that there is no change in behavior in that regard?

Thanks-
sage

