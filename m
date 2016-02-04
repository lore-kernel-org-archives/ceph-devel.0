From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: objecter incremental osdmap crc check
Date: Thu, 4 Feb 2016 19:25:22 +0800
Message-ID: <CANE=7sWpPkxByTyNWXV3ka+DhhAAGP8KdxJF9PM45LUVUOLDFg@mail.gmail.com>
References: <CANE=7sVATveDWRxv_X=jprzcJW50ssu0zojQgHLOUDP5aGF5Pw@mail.gmail.com>
	<CAJ4mKGYLs1nKOnU24s5Xh3SBPeCf=RUd-=hky02-q2FYPwf3Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34443 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869AbcBDLZX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 06:25:23 -0500
Received: by mail-ob0-f174.google.com with SMTP id wb13so62966990obb.1
        for <ceph-devel@vger.kernel.org>; Thu, 04 Feb 2016 03:25:22 -0800 (PST)
In-Reply-To: <CAJ4mKGYLs1nKOnU24s5Xh3SBPeCf=RUd-=hky02-q2FYPwf3Fw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I wonder when the client receive OSDMap::Incremental and
apply_incremental, why not compare the OSDMap.crc with inc.full_crc,
like this https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L6456

The OSDMonitor also check the crc when update OSMap, like this
https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L247

2016-02-04 1:00 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Wed, Feb 3, 2016 at 5:54 AM, Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxc=
xz@gmail.com> wrote:
>> hi, all:
>>
>>       When osd update the osdmap, it would apply the
>> OSDMap::Incremental and get the crc for the new osdmap. If the crc i=
s
>> not the same as define in Incremental osd would request the full
>> osdmap. I think the logic is quite well.
>>
>>      But in the client, the objecter do not check the crc. I do not
>> know why not client do the same logic as osd.
>>
>>     Could anyone explain this? Thanks.
>
> Two things:
> 1) The client doesn't necessarily have the full OSDMap that the OSDs
> do, so the CRC won't match. (You can see this in the encoding family
> of functions; there are sections which are server-only.) I suppose th=
e
> monitors could include a client-only CRC as well...
> 2) Nobody bothered since it seemed less important for "ephemeral"
> clients versus OSDs that persist their maps and share them with peers=
=2E
> -Greg



--=20
Regards,
Xinze Chi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
