From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore-Performance regression in the latest master
Date: Thu, 6 Oct 2016 21:04:56 +0000
Message-ID: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:15520
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933790AbcJFVE7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 17:04:59 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sage,
I am seeing the performance with the latest master is not stable compare to=
 3 days old master. The peak performance is higher but it is jumping up and=
 down. Analyzing further I suspect recent cache changes has an impact. Whil=
e the performance is high , I am seeing lower disk reads (probably because =
of cache hits) , but the low point is much lower when it is missing the cac=
he probably. You were saying on the standup about adding buffers in the cac=
he in the write path , is that merged into the master ?

The following pull request for cache that got merged seems reasonable.

https://github.com/ceph/ceph/pull/11295

Any hunch what is causing this degradation recently ? Otherwise, I need to =
dig down to find that out :-(

See the graph in the following link for the performance difference.

https://docs.google.com/spreadsheets/d/1JO3FaBbfT5jEdyYGB8EhHnAl5bAHe06ojLE=
85mPzsK4/edit?usp=3Dsharing

The left side graph is with old master and right one is with latest master.=
.Old one I ran for 10 hour and latest master I ran it for 2 hours.
The new one has *4X more* latency as well..

Thanks & Regards
Somnath



PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
