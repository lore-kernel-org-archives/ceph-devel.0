From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: objecter incremental osdmap crc check
Date: Wed, 3 Feb 2016 09:00:08 -0800
Message-ID: <CAJ4mKGYLs1nKOnU24s5Xh3SBPeCf=RUd-=hky02-q2FYPwf3Fw@mail.gmail.com>
References: <CANE=7sVATveDWRxv_X=jprzcJW50ssu0zojQgHLOUDP5aGF5Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36428 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648AbcBCRAJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 12:00:09 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so174738003wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 09:00:09 -0800 (PST)
In-Reply-To: <CANE=7sVATveDWRxv_X=jprzcJW50ssu0zojQgHLOUDP5aGF5Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 3, 2016 at 5:54 AM, Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz=
@gmail.com> wrote:
> hi, all:
>
>       When osd update the osdmap, it would apply the
> OSDMap::Incremental and get the crc for the new osdmap. If the crc is
> not the same as define in Incremental osd would request the full
> osdmap. I think the logic is quite well.
>
>      But in the client, the objecter do not check the crc. I do not
> know why not client do the same logic as osd.
>
>     Could anyone explain this? Thanks.

Two things:
1) The client doesn't necessarily have the full OSDMap that the OSDs
do, so the CRC won't match. (You can see this in the encoding family
of functions; there are sections which are server-only.) I suppose the
monitors could include a client-only CRC as well...
2) Nobody bothered since it seemed less important for "ephemeral"
clients versus OSDs that persist their maps and share them with peers.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
