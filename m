From: Sage Weil <sweil@redhat.com>
Subject: security roadmap
Date: Mon, 14 Nov 2016 18:36:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611141701000.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932458AbcKNSg0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 14 Nov 2016 13:36:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09F8D34A6
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 18:36:26 +0000 (UTC)
Received: from ovpn-112-71.phx2.redhat.com (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uAEIaOn9022460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 13:36:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now seems like a good time to review our security roadmap.

I've updated the trello board[1] to have a separate security list and 
moved the relevant cards there.  They include:

- resurrect coverity ci at scan.coverity.com.  This stopped sending out 
useful emails a while ago and the cron job has probably died; I'll try 
to get it going again.

- coverity backlog: there is a big backlog of issues in coverity that 
should be addressed.  Many of them are low priority (e.g., exceptions 
not caught in test code), but those issues obscure the real problems.

- hybrid kerberos/cephx auth mode: We've discussed this recently during 
CDM, notes here:

 http://pad.ceph.com/p/kerberos

- on the wire encryption: this is currently blocked by the msgr2 wire 
protocol revamp.

- librbd: client-side encryption.  The idea is to provide a key to librbd 
so that it encrypts all data before it is sent to rados.  This has to 
happen in librbd and not qemu in order to support cloning of 
encrypted images.

- ceph-disk: revamp boostrap process.  This just came up on ceph-devel 
today.  I think moving the bootstrap code into the monitor will simplify 
issues like this and be easier to maintain/use going forward...

- rgw: encryption.  This is work in progress to implement the S3 
encryption APIs.

Are there items we're missing that should go on this list?

Perhaps we should dedicate some time during the next CDM to go over the 
security roadmap as a whole and any specific issues that are not well 
defined.

Thanks!
sage

