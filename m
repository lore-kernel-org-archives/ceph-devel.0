From: Sage Weil <sweil@redhat.com>
Subject: Re: Ceph cluster with single replica to be deployed
Date: Thu, 1 Dec 2016 19:48:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612011943420.2702@piezo.novalocal>
References: <B4FD1EB4-0189-43A8-9EE2-0D26522F13FC@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2103588610-1480621685=:2702"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753043AbcLATsG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 14:48:06 -0500
In-Reply-To: <B4FD1EB4-0189-43A8-9EE2-0D26522F13FC@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2103588610-1480621685=:2702
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

[adding ceph-devel]

On Thu, 1 Dec 2016, LIU, Fei wrote:
> Hi Sage,
> 
>    We have some workload that have requirements of latency and IOPS but
> don’t care that much of data persistency. We do care a lot of TCO. We are
> looking for a possible solution to deploy Ceph with single replica. We have
> tried and put one OSD down intensively , the whole cluster was ok as long as
> you don’t nee d to operate any data related to the down OSD. We need to be
> carefully setup crushmap within a pool. However, what data is going to be
> losed in the down OSD is very hard to track, any suggestions and adviced
> will be appreciated.

It of course depends on your application, but from teh ceph perspective, 
this is doable.  The key is to streamline the data-loss procedure.  If an 
OSD fails, you'll lose a random set of PGs, which will have a random 
subset of the overall set of objects in the cluster.  You can tell the 
system to give up and recreate a PG as empty (acknowleding that data was 
*permanently* lost and telling ceph to carry on without it) with

 ceph pg force_create_pg <pgid>

You'll want to have some automation to pick out which PGs are lost and 
recreate them.

Of course, your application has to tolerate that...

sage
--8323329-2103588610-1480621685=:2702--
