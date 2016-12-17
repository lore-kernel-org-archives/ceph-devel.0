From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore performance bottleneck
Date: Sat, 17 Dec 2016 03:22:32 +0000
Message-ID: <5E3E05AED7F0F044904275810D0CB465039482@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:32990
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750780AbcLQDhQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Dec 2016 22:37:16 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
Some update on this. Without decode_some within fault_range() I am able to =
drive Bluestore + rocksdb close to ~38K iops compare to ~20K iops with deco=
de_some. I had to disable data write because I am skipping decode but in th=
is device data write is not a bottleneck. I have seen enabling/disabling da=
ta write is giving similar result. So, in NVME device if we can optimize de=
code_some() for performance Bluestore performance should bump up by ~2X.
I did some print around decode_some() and it seems it is taking ~60-121 mic=
ro sec to finish depending on bytes to decode.

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy
Sent: Thursday, December 15, 2016 7:30 PM
To: Sage Weil (sweil@redhat.com)
Cc: ceph-devel
Subject: Bluestore performance bottleneck

Sage,
Today morning I was talking about 2x performance drop for Bluestore without=
 data/db writes for 1G vs 60G volumes and it turn out the decode_some() is =
the culprit for that. Presently, I am drilling down that function to identi=
fy what exactly causing this issue, but, most probably it is blob decode an=
d le->blob->get_ref() combination. Will confirm that soon. If we can fix th=
at we should be able to considerably bump up end-to-end pick performance wi=
th rocks/ZS on faster NVME. Slower devices most likely we will not be able =
to see any benefits other than saving some cpu cost.

Thanks & Regards
Somnath



________________________________

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).

