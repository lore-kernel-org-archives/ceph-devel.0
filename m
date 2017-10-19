From: David Galloway <dgallowa@redhat.com>
Subject: 1.chacra.ceph.com outage
Date: Thu, 19 Oct 2017 10:08:53 -0400
Message-ID: <d36611d7-46c1-4435-0d27-a115e2f2dbe4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbdJSOIy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 10:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C747A806C1
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 14:08:54 +0000 (UTC)
Received: from [10.10.121.132] (ovpn-121-132.rdu2.redhat.com [10.10.121.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9348EB906B
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 14:08:54 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The SSD 1.chacra.ceph.com's root drive ran off of died last night in
OVH's public cloud.

We lost the host around 21:15 UTC.

OVH brought up a fresh VM with the same IP this morning and I was able
to re-attach whatever existing binaries and repos the host was
previously serving.

What this means for devs:

  - There's a slight chance a repo or two may be incomplete if a build
was in the middle of pushing packages to that node
  - Some teuthology jobs may have failed overnight due to missing repos

I'll leave the host as-is for now.  In a couple weeks, I'll wipe out its
repos and re-add it to the shaman/CI rotation so new builds start
getting pushed to it again.

Big thanks to Alfredo & Andrew for designing such a resilient CI system.

-- 
David Galloway
Systems Administrator, RDU
Ceph Engineering
IRC: dgalloway
