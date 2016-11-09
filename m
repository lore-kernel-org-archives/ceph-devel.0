From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore with rocksdb vs ZS
Date: Wed, 9 Nov 2016 23:39:30 +0000
Message-ID: <BY2PR02MB396475AD2EA210858957AD8F4B90@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB39674DF9B9B8848C6A17C8AF4B90@BY2PR02MB396.namprd02.prod.outlook.com>
 <fe4d4d36-693b-76b5-6cc2-a2b57a24173f@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:2191
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752576AbcKIXjd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 9 Nov 2016 18:39:33 -0500
In-Reply-To: <fe4d4d36-693b-76b5-6cc2-a2b57a24173f@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sure, it is running on SanDisk Infiniflash HW. Each Drive BW while test is =
running was ~400 MB/s and iops is ~20K , 100% 4K random write.
In case of 16 OSD test, it was 16 drive Infiniflash JBOF with 2 hosts attac=
hed to it. The hosts were HW zoned to 8 drives each.
The entire box BW is limited to max 12GB/s read/write, when it is fully pop=
ulated i.e 64 drives . Since it is 16 drives , box will give 16 X 400 MB/s =
=3D ~6.4 GB/s.
100% Read iops for this 16 drive box is ~800K and 100% write iops is ~300K =
iops.
Drives were having separate partition for Bluestore data/wal/db.

Thanks & Regards
Somnath

-----Original Message-----
From: Igor Fedotov [mailto:ifedotov@mirantis.com]=20
Sent: Wednesday, November 09, 2016 3:26 PM
To: Somnath Roy; ceph-devel@vger.kernel.org
Subject: Re: Bluestore with rocksdb vs ZS

Hi Somnath,

could you please describe the storage hardware used in your
benchmarking: what drives, how are they organized, etc... What are the perf=
ormance characteristics of the storage subsystem without Ceph?

Thanks in advance,

Igor


On 11/10/2016 1:57 AM, Somnath Roy wrote:
> Hi,
> Here is the slide we presented in today's performance meeting.
>
> https://drive.google.com/file/d/0B7W-S0z_ymMJZXI3bkZLX3Z2U0E/view?usp=3D
> sharing
>
> Feel free to come back if anybody has any query.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html

