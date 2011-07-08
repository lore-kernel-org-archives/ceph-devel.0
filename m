From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Replacing a failed disk/OSD: unfound object
Date: Fri, 8 Jul 2011 10:08:46 -0700
Message-ID: <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
References: <739109542484ec419c72b1a0f941a54d@carbonite.cn> <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34184 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1GHRJH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 13:09:07 -0400
Received: by ewy4 with SMTP id 4so737788ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2011 10:09:06 -0700 (PDT)
In-Reply-To: <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Meng Zhao <mzhao@carbonite.cn>
Cc: Ceph devel <ceph-devel@vger.kernel.org>

[It seems I dropped the Cc: to ceph-devel, added it back.. Please
reply to this message instead, and sorry about that. I'm starting to
dislike Google Apps for mailing list traffic :( ]

On Fri, Jul 8, 2011 at 10:07, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Jul 8, 2011 at 01:23, Meng Zhao <mzhao@carbonite.cn> wrote:
>> I was trying to replace a disk for an osd by following instruction a=
t:
>> http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD
>>
>> Now, ceph -w getting
>> 2011-07-08 15:52:39.702881 =C2=A0 =C2=A0pg v1602: 602 pgs: 49 active=
+degraded, 553
>> active+clean+degraded; 349 MB data, 333 MB used, 566 MB / 1023 MB av=
ail;
>> 167/224 degraded (74.554%); 55/112 unfound (49.107%)
>>
>> and a copy operation hang on the ceph client forever. I cannot kill =
(-9) the
>> cp process. Is there any hope to recover my ceph filesystem?
>
> I'm pretty sure that the cp is hanging because Ceph chooses to wait i=
n
> case the unfound objects do come back (e.g. an OSD comes back online)=
=2E
>
> Now, in the default configuration, losing a single OSD should not hav=
e
> caused unfound objects in the first place. Can you provide any more
> information on how you got to that point?
>
>> My general question is: How are objects distributed among OSDs? Does
>> duplication (2x) guarantee that a failure of a single OSD would not =
lose
>> data? =C2=A0It appears to me that the objects are statistically redi=
stributed and
>> does not guarantee physical separation of replication data location.
>
> The CRUSH logic has a special case for that: when picking replicas, i=
f
> it would pick an already used bucket, it tries again.
>
> My understanding is that with the default crushmap, replicas will go
> to different OSDs, and this is what I see in practice. If you did
> construct your crushmap, it's possible that you made one that allows
> multiple replicas on the same drive. Or even configured Ceph to
> maintain no replicas.
>
> It is also possible you got hit by a bug, most likely one not in the
> placement rules but in the OSDs code.
>
> Can you provide more information on your setup and the steps you took=
?
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
