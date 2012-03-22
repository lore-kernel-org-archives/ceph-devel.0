From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Theoretical questions
Date: Wed, 21 Mar 2012 17:06:10 -0700
Message-ID: <CACLRD_093zadirQSkC+z4ec6ULs3JGBVgB=Bo2x-k4QrLiUVWQ@mail.gmail.com>
References: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
	<CAGEBRh176DeZ_sj0hMsBSXs+tKm52D+iCCRZew+XUDpTL7Kf6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:42641 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2CVAGL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 20:06:11 -0400
Received: by wibhr17 with SMTP id hr17so102688wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 17:06:10 -0700 (PDT)
In-Reply-To: <CAGEBRh176DeZ_sj0hMsBSXs+tKm52D+iCCRZew+XUDpTL7Kf6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?0JHQvtGA0L7QtNC40L0g0JLQu9Cw0LTQuNC80LjRgA==?= <volk@xakep.ru>
Cc: ceph-devel@vger.kernel.org

=46irst, an object is hashed into a pg.  The pg is then moved between
osds as osds are added and removed (or fail).

Once enough other osds report an osd as failed, the monitors will mark
the osd as down.  During this time,
pgs with that osd as a replica will continue to serve writes in a
degraded state writing to the remaining
replicas.  Some time later, that osd will be marked out causing the pg
to be remapped to different osds,
at which point the degraded objects will re-replicate.  The time
between being marked down and being
marked out is controlled by mon_osd_down_out_interval.  Note that
setting that option to 0 prevents the
down osd from ever being marked out.  I have created a bug to allow
the user to force a down osd to
be immediately marked out (#2198).
-Sam Just

On Wed, Mar 21, 2012 at 11:44 AM, =D0=91=D0=BE=D1=80=D0=BE=D0=B4=D0=B8=D0=
=BD =D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D0=BC=D0=B8=D1=80 <volk@xakep.ru> wr=
ote:
> Thank you, Samuel.
>
> Here is what I meant in fourth question:
> We have pool "data" and in the crushmap there is a rule like this:
> rule data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ruleset 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0type replicated
> =C2=A0 =C2=A0 =C2=A0 =C2=A0min_size 3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0max_size 3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0step take root
> =C2=A0 =C2=A0 =C2=A0 =C2=A0step chooseleaf firstn 0 type rack
> =C2=A0 =C2=A0 =C2=A0 =C2=A0step emit
> }
> The client tries to write an object to pool "data". Ceph selects PG
> where to put the object. The object is then written to the buffer of
> the primary OSD. Primary OSD then tries to write copies to buffer of
> two replica OSDs and fails (perhaps, they are marked as down). Does
> client recieve ack? Or will ceph try to write the object into another
> PG?
> Primary OSD then writes object from buffer to disk. Two replicas are
> still down. Does client receive commit?
> Is there a way to write always 3 successfull copies of an object and
> then return ack to client?
>
> 21.03.2012, 21:12, "Samuel Just" <sam.just@dreamhost.com>:
>> 1. The standby mds does not maintain cached metadata in memory or
>> serve reads. =C2=A0When taking over from a failed mds, it reads the
>> primary's journal, which does warm up its cache somewhat. =C2=A0Opti=
onally,
>> you can put an mds into standby-replay for an active mds. =C2=A0In t=
his case,
>> the standby-replay mds will continually replay the primary's journal=
 in
>> order to more quickly take over in the case of a crash.
>>
>> 2. Primary-copy is the only strategy currently implemented.
>>
>> 3. On a sync, we wait for commits to ensure data safety.
>>
>> 4. I don't quite understand this question.
>>
>> 5. =C2=A0Currently, there is not a good way to accomplish this using=
 only
>> ceph. =C2=A0Replication is synchronous on writes, so you would be pa=
ying
>> the latency cost between data centers on each write if you wanted to
>> replicate between data centers. =C2=A0We don't currently support rea=
ding from
>> the closest replica.
>>
>> On Wed, Mar 21, 2012 at 2:22 AM, Borodin Vladimir <v.a.borodin@gmail=
=2Ecom> wrote:
>>
>>> =C2=A0Hi all.
>>>
>>> =C2=A0I've read everything in ceph.newdream.net/docs and
>>> =C2=A0ceph.newdream.net/wiki. I've also read some articles from
>>> =C2=A0ceph.newdream.net/publications. But I haven't found answers o=
n some
>>> =C2=A0questions:
>>> =C2=A01. there is one active MDS and one in standby mode. Active MD=
S caches
>>> =C2=A0all metadata in RAM. Does standby MDS copy this information t=
o RAM?
>>> =C2=A0Will it take metadata from OSDs on every request after primar=
y MDS
>>> =C2=A0failure? Do read requests come to standby MDS?
>>> =C2=A02. what replication strategy on OSDs (primary-copy, chain or =
splay) is
>>> =C2=A0turned on by default?
>>> =C2=A03. when does kernel client understand that the write was succ=
essfull
>>> =C2=A0(when it recieves ack or commit from primary OSD)?
>>> =C2=A04. I want to have 3 copies of each object. By default there i=
s a way
>>> =C2=A0to write only one successfull copy (and two others give a fai=
lure),
>>> =C2=A0isn't that? Is there a way to turn this off (even if one of t=
hree
>>> =C2=A0copies failed, the object will be placed to another PG)?
>>> =C2=A05. if I have several data centers with good network connectio=
n, what
>>> =C2=A0is the way to provide data locality? For example, most of wri=
te and
>>> =C2=A0read requests from Spain come to Spanish DC and most of write=
 and read
>>> =C2=A0requests from Russia come to Russian DC. Is it posible?
>>>
>>> =C2=A0Regards,
>>> =C2=A0Vladimir.
>>> =C2=A0--
>>> =C2=A0To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
>>> =C2=A0the body of a message to majordomo@vger.kernel.org
>>> =C2=A0More majordomo info at =C2=A0http://vger.kernel.org/majordomo=
-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
