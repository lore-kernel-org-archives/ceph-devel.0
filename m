From: Meng Zhao <mzhao@carbonite.cn>
Subject: Re: Replacing a failed disk/OSD: unfound object
Date: Tue, 12 Jul 2011 17:38:10 +0800
Message-ID: <620ab7bc3254ca105a1b91930afce314@carbonite.cn>
References: <739109542484ec419c72b1a0f941a54d@carbonite.cn>
 <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
 <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [218.240.156.147] ([218.240.156.147]:54447 "EHLO
	mail.carbonite.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1GLJiV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2011 05:38:21 -0400
In-Reply-To: <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Ceph devel <ceph-devel@vger.kernel.org>

Thanks Tommi.  I rebuilt the ceph cluster a few times just to reproduce=
=20
the situation. The result seems mixed, more likely btrfs failed (after=20
power reset). But it does happen anyway.

The big question is: However rare, unfound object situation makes the=20
*entire* ceph file system not mountable, leads to a total lost of all=20
data. That is quite a risk to take for production system.  Is there a=20
way to recover from such situation ?(e.g. remove the file associated=20
with the missing object)


On Fri, 8 Jul 2011 10:08:46 -0700, Tommi Virtanen wrote:
> [It seems I dropped the Cc: to ceph-devel, added it back.. Please
> reply to this message instead, and sorry about that. I'm starting to
> dislike Google Apps for mailing list traffic :( ]
>
> On Fri, Jul 8, 2011 at 10:07, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
>> On Fri, Jul 8, 2011 at 01:23, Meng Zhao <mzhao@carbonite.cn> wrote:
>>> I was trying to replace a disk for an osd by following instruction=20
>>> at:
>>> http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD
>>>
>>> Now, ceph -w getting
>>> 2011-07-08 15:52:39.702881 =C2=A0 =C2=A0pg v1602: 602 pgs: 49=20
>>> active+degraded, 553
>>> active+clean+degraded; 349 MB data, 333 MB used, 566 MB / 1023 MB=20
>>> avail;
>>> 167/224 degraded (74.554%); 55/112 unfound (49.107%)
>>>
>>> and a copy operation hang on the ceph client forever. I cannot kill=
=20
>>> (-9) the
>>> cp process. Is there any hope to recover my ceph filesystem?
>>
>> I'm pretty sure that the cp is hanging because Ceph chooses to wait=20
>> in
>> case the unfound objects do come back (e.g. an OSD comes back=20
>> online).
>>
>> Now, in the default configuration, losing a single OSD should not=20
>> have
>> caused unfound objects in the first place. Can you provide any more
>> information on how you got to that point?
>>
>>> My general question is: How are objects distributed among OSDs?=20
>>> Does
>>> duplication (2x) guarantee that a failure of a single OSD would not=
=20
>>> lose
>>> data? =C2=A0It appears to me that the objects are statistically=20
>>> redistributed and
>>> does not guarantee physical separation of replication data=20
>>> location.
>>
>> The CRUSH logic has a special case for that: when picking replicas,=20
>> if
>> it would pick an already used bucket, it tries again.
>>
>> My understanding is that with the default crushmap, replicas will go
>> to different OSDs, and this is what I see in practice. If you did
>> construct your crushmap, it's possible that you made one that allows
>> multiple replicas on the same drive. Or even configured Ceph to
>> maintain no replicas.
>>
>> It is also possible you got hit by a bug, most likely one not in the
>> placement rules but in the OSDs code.
>>
>> Can you provide more information on your setup and the steps you=20
>> took?
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
