From: Sage Weil <sweil@redhat.com>
Subject: osd/*PG* code cleanup
Date: Tue, 22 Nov 2016 03:22:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611220318580.5480@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755039AbcKVDWd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 21 Nov 2016 22:22:33 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C77D281222
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 03:22:32 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey Sam,

I think now is the time to do a cleanup the PG class and file names--right 
after a big refactor that is effectively a backport-barrier anyway.  If we 
do it after kraken it will make it hard to backport to kraken, and the 
recent changes have just drastically cut the probability that anything 
post-kraken will be backported to jewel without care anyway.

I think we should

 - rename ReplicatedPG -> PrimaryLogPG
 - PGBackend and *Backend -> PLPG[*]Backend

Eventually we also need to move most of PG into PrimaryLogPG, but it's 
less important that that happens now...

What do you think?

sage
