From: Sage Weil <sage@redhat.com>
Subject: unclean pgs health warning
Date: Mon, 23 Oct 2017 21:28:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710232118070.4984@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbdJWV2x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Oct 2017 17:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFB97C04B94A
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 21:28:52 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jspray@redhat.com

I'm frustrated by health output like this:

    id:     98463a16-36f5-4a1e-a232-64f4e987b5a2
    health: HEALTH_WARN
            16671/54990 objects misplaced (30.316%)
            Degraded data redundancy: 8 pgs unclean
...
    pgs:     16671/54990 objects misplaced (30.316%)
             6 active+remapped+backfill_wait
             2 active+remapped+backfilling

The PGs are 'unclean' because they don't have the 'clean' flag.  But they 
aren't degraded; just misplaced, and we already report that in the 
misplaced health message.

I tried changing it to a different health message:

    health: HEALTH_WARN
            14948/54990 objects misplaced (27.183%)
            Unclean state: 7 pgs unclean
...
    pgs:     14948/54990 objects misplaced (27.183%)
             6 active+remapped+backfill_wait
             1 active+remapped+backfilling
             1 active+clean

...but that looks like it'd be just as confusing to an administrator.  
(What does "unclean" mean?  What do I do about it?)

Perhaps we should just ignore the 'clean' state?  I'm having a hard time 
coming up with a reason the PG would be unclean that isn't reflected by 
another message.  I think the only example I can come up with is the 
permanently 'remapped' state.. but even there we set 'clean'.

Can we just drop it?

	https://github.com/ceph/ceph/pull/18493	

sage
