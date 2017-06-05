From: Sage Weil <sweil@redhat.com>
Subject: health checks and logging
Date: Mon, 5 Jun 2017 21:21:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706052112360.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbdFEVVj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 17:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AC6A3DBC8
        for <ceph-devel@vger.kernel.org>; Mon,  5 Jun 2017 21:21:39 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: john.spray@redhat.com
Cc: ceph-devel@vger.kernel.org

I took a quick look at the get_health() methods in the Monitor after our 
discussion this morning:

- OSDMonitor::get_health() looks at the pool stats for a few things; I 
think these can be safely/easily moved to PGMap::get_health() (so that 
they will run in ceph-mgr)
- Then it'll be an easy change to calculate the health and detail sets in 
encoding_pending as each OSDMap in published.
- MgrStatMonitor is already persisting the mgr health messages.
- MDSMonitor is also strictly a fundion of the FSMap so it'd be easy to 
move to encode_pending.
- Monitor::get_health() has some odds and ends we can either leave in 
place or improve (e.g, time skew checks).  Not sure it matters much.

My main question is whether you had specific thoughts about how to 
identify warnings so that we can note when they appear and disappear.  We 
can just go by the unique strings but then you'll see something like

 1 osd(s) down
 ...
 1 osd(s) down cleared
 2 osd(s) down
 ...

(or whatever we make the messages for cleared warnings look like).  Should 
we associate a 'tag' for each message that is used to identify it, so 
that, for example, "%d osd down" for any number of OSDs is considered the 
"same" message and we log when it changes but don't say it has cleared?

sage
