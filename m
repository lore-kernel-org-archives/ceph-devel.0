From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Reshard is not stabilizing in latest master
Date: Mon, 12 Dec 2016 18:03:10 +0000
Message-ID: <BY2PR02MB396968E5056460170608E6BF4980@BY2PR02MB396.namprd02.prod.outlook.com>
References: <DM2PR02MB398ED2929DBD480C2CCFC88F4840@DM2PR02MB398.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1612090059480.32281@piezo.novalocal>
 <BY2PR02MB396DC43832DA107A62066B0F4870@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1612121738050.25581@piezo.novalocal>
 <8276d3ed-f169-b4d8-5301-f3d25347b502@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:53157
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750763AbcLLSDM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Dec 2016 13:03:12 -0500
In-Reply-To: <8276d3ed-f169-b4d8-5301-f3d25347b502@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Make sense , but, any idea why it is showing up now as it is not happening =
with old master ? What possibly I did to reproduce it, just curious.

Thanks & Regards
Somnath

-----Original Message-----
From: Igor Fedotov [mailto:ifedotov@mirantis.com]=20
Sent: Monday, December 12, 2016 9:46 AM
To: Sage Weil; Somnath Roy
Cc: ceph-devel
Subject: Re: Reshard is not stabilizing in latest master

yeah, I've got the same explanation 10 min ago.
PR is ready too:
https://github.com/ceph/ceph/pull/12447

On 12.12.2016 20:39, Sage Weil wrote:
> On Fri, 9 Dec 2016, Somnath Roy wrote:
>> Sage,
>> Please find it in the following location , it's a zipped file.
>>
>> https://drive.google.com/open?id=3D0B7W-S0z_ymMJd0V1XzVhQWR4ak0
>>
>>
>> What I found that the following shard length always comes below bluestor=
e_extent_map_shard_min_size and triggering reshard.
>>
>> 2016-12-08 20:07:56.950527 7fe9140f7700 20=20
>> bluestore.extentmap(0x557183546d48) update shard 0x3ff000 is 25 bytes=20
>> (was 25) from 1 extents
> All of the instances are at offset 0x3ff000, which is right at the end=20
> of the object.  I think we just need some special case code to handle=20
> when the last little bit ends up being small, and pull it into the=20
> previous shard (probably).
>
> sage
>
>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sweil@redhat.com]
>> Sent: Thursday, December 08, 2016 5:00 PM
>> To: Somnath Roy
>> Cc: ceph-devel
>> Subject: Re: Reshard is not stabilizing in latest master
>>
>> On Thu, 8 Dec 2016, Somnath Roy wrote:
>>> Sage,
>>> I am seeing reshard is not stabilizing even after I precondition an ima=
ge with 4K seq. It was happening with 2 weeks old master. Anything change o=
n that part of the code base recently ? Otherwise I need to debug.
>> Nope.  If you have a cluster where it isn't stabilizing just turn on deb=
ug bluestore =3D 20 for a minute and send me the log.
>>
>> sage
>> PLEASE NOTE: The information contained in this electronic mail message i=
s intended only for the use of the designated recipient(s) named above. If =
the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, di=
ssemination, distribution, or copying of this message is strictly prohibite=
d. If you have received this communication in error, please notify the send=
er by telephone or e-mail (as shown above) immediately and destroy any and =
all copies of this message in your possession (whether hard copies or elect=
ronically stored copies).
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html

