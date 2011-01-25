From: Ravi Pinjala <pstatic@gmail.com>
Subject: Re: log messages about inconsistent data
Date: Tue, 25 Jan 2011 01:00:19 -0800
Message-ID: <AANLkTi=ZCjMTU-2DnZJFsbfsH3JGJ5Z3LzUY9Ct_uEi2@mail.gmail.com>
References: <AANLkTin=qOdFjTWz8sMQ3hmUvwyrnmEd3_zo6LPbaK3r@mail.gmail.com>
	<4D3DC794.5090604@hq.newdream.net>
	<AANLkTi=y0KcoerXLdfoeaHan8C5FVopuQYZp8hVg6o=Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32776 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1AYJAV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 04:00:21 -0500
Received: by bwz15 with SMTP id 15so2990bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 01:00:20 -0800 (PST)
In-Reply-To: <AANLkTi=y0KcoerXLdfoeaHan8C5FVopuQYZp8hVg6o=Z@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A follow-up question to this: After repairing those PGs, my cluster
seems to have come to rest in this state.

2011-01-25 00:26:58.447007    pg v130979: 270 pgs: 8 active, 262
active+clean; 822 GB data, 1762 GB used, 1265 GB / 3036 GB avail;
25/556114 degraded (0.004%)

I don't know whether or not it's in a functional state, since I'm
having MDS issues [1], so I can't actually mount it and poke around.
Still, should I be worried that those 8 PGs aren't being marked
'clean'?

[1] http://tracker.newdream.net/issues/733

On Mon, Jan 24, 2011 at 7:45 PM, Ravi Pinjala <pstatic@gmail.com> wrote=
:
> That seems to be working. Thanks!
>
> --Ravi
>
> On Mon, Jan 24, 2011 at 10:40 AM, Samuel Just <samuelj@hq.newdream.ne=
t> wrote:
>> =C2=A0ceph pg repair <pgid> should cause the osd to repair the
>> inconsistency in most cases. =C2=A0You can get the pgid by grepping
>> ceph pg dump for the inconsistent pg.
>> -Sam
>>
>> On 01/23/2011 11:18 PM, Ravi Pinjala wrote:
>>>
>>> Do I need to be worried about this?
>>>
>>> 2011-01-23 23:12:06.328866 =C2=A0 log 2011-01-23 23:12:05.316993 os=
d1
>>> 192.168.1.11:6801/9447 45 : [ERR] 1.1 scrub osd0 missing
>>> 10000017737.00000000/head
>>> 2011-01-23 23:12:06.328866 =C2=A0 log 2011-01-23 23:12:05.317429 os=
d1
>>> 192.168.1.11:6801/9447 46 : [ERR] 1.1 scrub stat mismatch, got 7/13=
6
>>> objects, 0/0 clones, 12356/8682277 bytes, 17/8550 kb.
>>> 2011-01-23 23:12:08.230768 =C2=A0 =C2=A0pg v129643: 270 pgs: 262 ac=
tive+clean, 8
>>> active+clean+inconsistent; 877 GB data, 1707 GB used, 1320 GB / 303=
6
>>> GB avail
>>>
>>> I would expect ceph to fix the inconsistent PGs at this point, but =
it
>>> just continues background scrubbing. Does inconsistent data get
>>> cleaned up automatically from other replicas, or is there something
>>> that I need to fix manually here?
>>>
>>> --Ravi
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
