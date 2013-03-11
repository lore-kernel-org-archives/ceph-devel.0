From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Mon, 11 Mar 2013 23:23:53 +0100
Message-ID: <CAOLwVUnOtDwPPqWuX7n5FbQDC_hEZ-m_zmSHJ09rUNt=XPu5wg@mail.gmail.com>
References: <CAOLwVUnVJABHAqaSechu5=4kDhft4wf7LNQVddp-J+miuu=qiQ@mail.gmail.com>
 <13183200.155.1363027427897.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48479 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3CKWYO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 18:24:14 -0400
Received: by mail-ob0-f170.google.com with SMTP id wc20so3890938obb.15
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 15:24:14 -0700 (PDT)
In-Reply-To: <13183200.155.1363027427897.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: Wido den Hollander <wido@42on.com>, Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>, Sage Weil <sage@inktank.com>

Dave,

It still a production platform so no I didn't try it. I've also found
that now ceph-mon are constantly leaking... I truly hope your log max
recent =3D 10000 will help.

Cheers.
--
Regards,
S=E9bastien Han.


On Mon, Mar 11, 2013 at 7:43 PM, Dave Spano <dspano@optogenics.com> wro=
te:
> Sebastien,
>
> Did the patch that Sage mentioned work for you? I've found that this =
behavior is happening more frequently with my first osd during deep scr=
ubbing on version 0.56.3. OOM Killer now goes after the ceph-osd proces=
s after a couple of days.
>
> Sage,
> Yesterday after following the OSD memory requirements thread, I added=
 log max recent =3D 10000 to ceph.conf, and osd.0 seems to have returne=
d to a state of normalcy. If it makes it through a deep scrubbing with =
no problem, I'll be very happy.
>
>
>>> sage@inktank.com said:
>>>> - pg log trimming (probably a conservative subset) to avoid memory=
 bloat
>>>
>>> Anything that reduces the size of OSD processes would be appreciate=
d.
>>> You can probably do this with just
>>>  log max recent =3D 1000
>>> By default it's keeping 100k lines of logs in memory, which can eat=
 a lot  of
>>> ram (but is great when debugging issues).
>
> Dave Spano
>
>
>
>
> ----- Original Message -----
> From: "S=E9bastien Han" <han.sebastien@gmail.com>
> To: "Sage Weil" <sage@inktank.com>
> Cc: "Wido den Hollander" <wido@42on.com>, "Gregory Farnum" <greg@inkt=
ank.com>, "Sylvain Munaut" <s.munaut@whatever-company.com>, "Dave Spano=
" <dspano@optogenics.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "=
Samuel Just" <sam.just@inktank.com>
> Sent: Monday, March 4, 2013 12:11:22 PM
> Subject: Re: OSD memory leaks?
>
> FYI I'm using 450 pgs for my pools.
>
> --
> Regards,
> S=E9bastien Han.
>
>
> On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.com> wrote:
>>
>> On Fri, 1 Mar 2013, Wido den Hollander wrote:
>> > On 02/23/2013 01:44 AM, Sage Weil wrote:
>> > > On Fri, 22 Feb 2013, S?bastien Han wrote:
>> > > > Hi all,
>> > > >
>> > > > I finally got a core dump.
>> > > >
>> > > > I did it with a kill -SEGV on the OSD process.
>> > > >
>> > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0=
-20100-1361539008
>> > > >
>> > > > Hope we will get something out of it :-).
>> > >
>> > > AHA!  We have a theory.  The pg log isnt trimmed during scrub (b=
ecause teh
>> > > old scrub code required that), but the new (deep) scrub can take=
 a very
>> > > long time, which means the pg log will eat ram in the meantime..
>> > > especially under high iops.
>> > >
>> >
>> > Does the number of PGs influence the memory leak? So my theory is =
that when
>> > you have a high number of PGs with a low number of objects per PG =
you don't
>> > see the memory leak.
>> >
>> > I saw the memory leak on a RBD system where a pool had just 8 PGs,=
 but after
>> > going to 1024 PGs in a new pool it seemed to be resolved.
>> >
>> > I've asked somebody else to try your patch since he's still seeing=
 it on his
>> > systems. Hopefully that gives us some results.
>>
>> The PGs were active+clean when you saw the leak?  There is a problem=
 (that
>> we just fixed in master) where pg logs aren't trimmed for degraded P=
Gs.
>>
>> sage
>>
>> >
>> > Wido
>> >
>> > > Can you try wip-osd-log-trim (which is bobtail + a simple patch)=
 and see
>> > > if that seems to work?  Note that that patch shouldn't be run in=
 a mixed
>> > > argonaut+bobtail cluster, since it isn't properly checking if th=
e scrub is
>> > > class or chunky/deep.
>> > >
>> > > Thanks!
>> > > sage
>> > >
>> > >
>> > >   > --
>> > > > Regards,
>> > > > S?bastien Han.
>> > > >
>> > > >
>> > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inktank.=
com> wrote:
>> > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebastie=
n@gmail.com>
>> > > > > wrote:
>> > > > > > > Is osd.1 using the heap profiler as well? Keep in mind t=
hat active
>> > > > > > > use
>> > > > > > > of the memory profiler will itself cause memory usage to=
 increase ?
>> > > > > > > this sounds a bit like that to me since it's staying sta=
ble at a
>> > > > > > > large
>> > > > > > > but finite portion of total memory.
>> > > > > >
>> > > > > > Well, the memory consumption was already high before the p=
rofiler was
>> > > > > > started. So yes with the memory profiler enable an OSD mig=
ht consume
>> > > > > > more memory but this doesn't cause the memory leaks.
>> > > > >
>> > > > > My concern is that maybe you saw a leak but when you restart=
ed with
>> > > > > the memory profiling you lost whatever conditions caused it.
>> > > > >
>> > > > > > Any ideas? Nothing to say about my scrumbing theory?
>> > > > > I like it, but Sam indicates that without some heap dumps wh=
ich
>> > > > > capture the actual leak then scrub is too large to effective=
ly code
>> > > > > review for leaks. :(
>> > > > > -Greg
>> > > > --
>> > > > To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> > > > the body of a message to majordomo@vger.kernel.org
>> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>> > > >
>> > > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>> > >
>> >
>> >
>> > --
>> > Wido den Hollander
>> > 42on B.V.
>> >
>> > Phone: +31 (0)20 700 9902
>> > Skype: contact42on
>> >
>> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
