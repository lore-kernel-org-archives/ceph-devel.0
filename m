From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Reshard is not stabilizing in latest master
Date: Fri, 9 Dec 2016 02:44:40 +0000
Message-ID: <BY2PR02MB396DC43832DA107A62066B0F4870@BY2PR02MB396.namprd02.prod.outlook.com>
References: <DM2PR02MB398ED2929DBD480C2CCFC88F4840@DM2PR02MB398.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1612090059480.32281@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:34567
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754046AbcLICom (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Dec 2016 21:44:42 -0500
In-Reply-To: <alpine.DEB.2.11.1612090059480.32281@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
Please find it in the following location , it's a zipped file.

https://drive.google.com/open?id=3D0B7W-S0z_ymMJd0V1XzVhQWR4ak0


What I found that the following shard length always comes below bluestore_e=
xtent_map_shard_min_size and triggering reshard.

2016-12-08 20:07:56.950527 7fe9140f7700 20 bluestore.extentmap(0x557183546d=
48) update shard 0x3ff000 is 25 bytes (was 25) from 1 extents

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Thursday, December 08, 2016 5:00 PM
To: Somnath Roy
Cc: ceph-devel
Subject: Re: Reshard is not stabilizing in latest master

On Thu, 8 Dec 2016, Somnath Roy wrote:
> Sage,
> I am seeing reshard is not stabilizing even after I precondition an image=
 with 4K seq. It was happening with 2 weeks old master. Anything change on =
that part of the code base recently ? Otherwise I need to debug.

Nope.  If you have a cluster where it isn't stabilizing just turn on debug =
bluestore =3D 20 for a minute and send me the log.

sage
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
