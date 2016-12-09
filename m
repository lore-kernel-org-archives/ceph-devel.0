From: Sage Weil <sweil@redhat.com>
Subject: Re: Reshard is not stabilizing in latest master
Date: Fri, 9 Dec 2016 01:00:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612090059480.32281@piezo.novalocal>
References: <DM2PR02MB398ED2929DBD480C2CCFC88F4840@DM2PR02MB398.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbcLIBAr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Dec 2016 20:00:47 -0500
In-Reply-To: <DM2PR02MB398ED2929DBD480C2CCFC88F4840@DM2PR02MB398.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 8 Dec 2016, Somnath Roy wrote:
> Sage,
> I am seeing reshard is not stabilizing even after I precondition an image with 4K seq. It was happening with 2 weeks old master. Anything change on that part of the code base recently ? Otherwise I need to debug.

Nope.  If you have a cluster where it isn't stabilizing just turn on debug 
bluestore = 20 for a minute and send me the log.

sage
