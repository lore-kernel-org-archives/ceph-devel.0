From: Martin Bukatovic <mbukatov@redhat.com>
Subject: ceph-mgr and tendrl
Date: Wed, 14 Sep 2016 11:50:51 +0200
Message-ID: <678aa95f-73de-f309-c821-495c446e25f4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbcINJuy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 05:50:54 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26C80C05678F
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 09:50:53 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tendrl-devel@redhat.com, ceph-devel@vger.kernel.org

Dear all,

we may need to check the current plans of the ceph community
to introduce a new component of the ceph stack: ceph-mgr

The original idea has been shared some time ago here:

 * https://www.spinics.net/lists/ceph-devel/msg28047.html
 * http://pad.ceph.com/p/ceph-mgr

While this service seems to be concerned with additional
features which may not be the best fit for adding into the
MON daemons and as such there seems to be no or little
overlap with what tendrl will to be doing, it's clear
that both tendrl and ceph-mgr components need to cooperate,
and so the dev teams would benefit from discussing their
ideas from the early on.

-- 
Martin Bukatovic
USM QE team
