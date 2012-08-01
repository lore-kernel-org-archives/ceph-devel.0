From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: PG stuck stale
Date: Wed, 1 Aug 2012 17:12:32 +0200
Message-ID: <CAF6-1L5R9DaP778-Wdcpni6C6KpYMd0t3zF9t91CLd5oqAW7ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33912 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab2HAPMd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 11:12:33 -0400
Received: by vcbfk26 with SMTP id fk26so7130935vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 08:12:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm doing a few tests on ceph (radosgw more precisely).

One of the scenario I'm testing is:
 - A radogw bucket stored in a rados pool with size=1 (so no replication)
 - Complete/Irrecoverable failure of an OSD ( osd.0 )

Now obviously in that situation, some of the placement groups will be
completely lost and there will be no way to get the data back and I'm
OK with that.

But my current issue is that after rebuilding a new osd.0 from
scratch, the PG that were previously on it and nowhere else are "stuck
stale" and I can't figure out how to tell it that it's OK to loose
those data but come back to HEALTHY ...

I tried doing 'ceph osd lost 0' after I shut it down and before I
start it up from scratch again but that didn't change anything.

So how can I make the cluster HEALTHY again ?

Cheers,

    Sylvain
