From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Tue, 12 Mar 2013 14:43:44 +0100
Message-ID: <CAOLwVUmNY_j9_dEaW-XaWh61EeLSopFPXzUU_z_DgWT9_3-d_A@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
 <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
 <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com>
 <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com>
 <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com>
 <alpine.DEB.2.00.1302221642570.5703@cobra.newdream.net> <5130CE65.7050606@42on.com>
 <alpine.DEB.2.00.1303011110120.22593@cobra.newdream.net> <CAOLwVUnVJABHAqaSechu5=4kDhft4wf7LNQVddp-J+miuu=qiQ@mail.gmail.com>
 <CAD+Ap5YvhqTwNS+vGrktKmbNCmVf0nd_zzRSPRi2pwUaP_T3MA@mail.gmail.com>
 <CAOLwVUn3Zjv9woM7nbLaD-WVgXfSNkxS5vrMvf8zrg90pjgweA@mail.gmail.com> <CAD+Ap5ayBkMZu4m_=H_G1+tZf9pi__Norud7Jf6TD+e7B6eqHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34059 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab3CLNoF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 09:44:05 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so4408307obc.4
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 06:44:04 -0700 (PDT)
In-Reply-To: <CAD+Ap5ayBkMZu4m_=H_G1+tZf9pi__Norud7Jf6TD+e7B6eqHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladislav Gorbunov <vadikgo@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

>Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph osd
>dump | grep 'rep size'"

Well it's still 450 each...

>The default pg_num value 8 is NOT suitable for big cluster.

Thanks I know, I'm not new with Ceph. What's your point here? I
already said that pg_num was 450...
--
Regards,
S=E9bastien Han.


On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gorbunov <vadikgo@gmail.com>=
 wrote:
> Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph osd
> dump | grep 'rep size'"
> The default pg_num value 8 is NOT suitable for big cluster.
>
> 2013/3/13 S=E9bastien Han <han.sebastien@gmail.com>:
>> Replica count has been set to 2.
>>
>> Why?
>> --
>> Regards,
>> S=E9bastien Han.
>>
>>
>> On Tue, Mar 12, 2013 at 12:45 PM, Vladislav Gorbunov <vadikgo@gmail.=
com> wrote:
>>>> FYI I'm using 450 pgs for my pools.
>>> Please, can you show the number of object replicas?
>>>
>>> ceph osd dump | grep 'rep size'
>>>
>>> Vlad Gorbunov
>>>
>>> 2013/3/5 S=E9bastien Han <han.sebastien@gmail.com>:
>>>> FYI I'm using 450 pgs for my pools.
>>>>
>>>> --
>>>> Regards,
>>>> S=E9bastien Han.
>>>>
>>>>
>>>> On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.com> wrote=
:
>>>>>
>>>>> On Fri, 1 Mar 2013, Wido den Hollander wrote:
>>>>> > On 02/23/2013 01:44 AM, Sage Weil wrote:
>>>>> > > On Fri, 22 Feb 2013, S?bastien Han wrote:
>>>>> > > > Hi all,
>>>>> > > >
>>>>> > > > I finally got a core dump.
>>>>> > > >
>>>>> > > > I did it with a kill -SEGV on the OSD process.
>>>>> > > >
>>>>> > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-=
0-0-20100-1361539008
>>>>> > > >
>>>>> > > > Hope we will get something out of it :-).
>>>>> > >
>>>>> > > AHA!  We have a theory.  The pg log isnt trimmed during scrub=
 (because teh
>>>>> > > old scrub code required that), but the new (deep) scrub can t=
ake a very
>>>>> > > long time, which means the pg log will eat ram in the meantim=
e..
>>>>> > > especially under high iops.
>>>>> > >
>>>>> >
>>>>> > Does the number of PGs influence the memory leak? So my theory =
is that when
>>>>> > you have a high number of PGs with a low number of objects per =
PG you don't
>>>>> > see the memory leak.
>>>>> >
>>>>> > I saw the memory leak on a RBD system where a pool had just 8 P=
Gs, but after
>>>>> > going to 1024 PGs in a new pool it seemed to be resolved.
>>>>> >
>>>>> > I've asked somebody else to try your patch since he's still see=
ing it on his
>>>>> > systems. Hopefully that gives us some results.
>>>>>
>>>>> The PGs were active+clean when you saw the leak?  There is a prob=
lem (that
>>>>> we just fixed in master) where pg logs aren't trimmed for degrade=
d PGs.
>>>>>
>>>>> sage
>>>>>
>>>>> >
>>>>> > Wido
>>>>> >
>>>>> > > Can you try wip-osd-log-trim (which is bobtail + a simple pat=
ch) and see
>>>>> > > if that seems to work?  Note that that patch shouldn't be run=
 in a mixed
>>>>> > > argonaut+bobtail cluster, since it isn't properly checking if=
 the scrub is
>>>>> > > class or chunky/deep.
>>>>> > >
>>>>> > > Thanks!
>>>>> > > sage
>>>>> > >
>>>>> > >
>>>>> > >   > --
>>>>> > > > Regards,
>>>>> > > > S?bastien Han.
>>>>> > > >
>>>>> > > >
>>>>> > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inkta=
nk.com> wrote:
>>>>> > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebas=
tien@gmail.com>
>>>>> > > > > wrote:
>>>>> > > > > > > Is osd.1 using the heap profiler as well? Keep in min=
d that active
>>>>> > > > > > > use
>>>>> > > > > > > of the memory profiler will itself cause memory usage=
 to increase ?
>>>>> > > > > > > this sounds a bit like that to me since it's staying =
stable at a
>>>>> > > > > > > large
>>>>> > > > > > > but finite portion of total memory.
>>>>> > > > > >
>>>>> > > > > > Well, the memory consumption was already high before th=
e profiler was
>>>>> > > > > > started. So yes with the memory profiler enable an OSD =
might consume
>>>>> > > > > > more memory but this doesn't cause the memory leaks.
>>>>> > > > >
>>>>> > > > > My concern is that maybe you saw a leak but when you rest=
arted with
>>>>> > > > > the memory profiling you lost whatever conditions caused =
it.
>>>>> > > > >
>>>>> > > > > > Any ideas? Nothing to say about my scrumbing theory?
>>>>> > > > > I like it, but Sam indicates that without some heap dumps=
 which
>>>>> > > > > capture the actual leak then scrub is too large to effect=
ively code
>>>>> > > > > review for leaks. :(
>>>>> > > > > -Greg
>>>>> > > > --
>>>>> > > > To unsubscribe from this list: send the line "unsubscribe c=
eph-devel" in
>>>>> > > > the body of a message to majordomo@vger.kernel.org
>>>>> > > > More majordomo info at  http://vger.kernel.org/majordomo-in=
fo.html
>>>>> > > >
>>>>> > > >
>>>>> > > --
>>>>> > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
>>>>> > > the body of a message to majordomo@vger.kernel.org
>>>>> > > More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>> > >
>>>>> >
>>>>> >
>>>>> > --
>>>>> > Wido den Hollander
>>>>> > 42on B.V.
>>>>> >
>>>>> > Phone: +31 (0)20 700 9902
>>>>> > Skype: contact42on
>>>>> >
>>>>> >
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
