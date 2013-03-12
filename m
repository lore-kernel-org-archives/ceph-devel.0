From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Tue, 12 Mar 2013 21:10:40 +0100
Message-ID: <CAOLwVUkBeu+=4XHv8NV+xRm7CaEvByO-uuo5eeZ+iHUg1XQ1sw@mail.gmail.com>
References: <7332688.5.1363110084349.JavaMail.dspano@it1> <2104584728.1783.1363111761558.JavaMail.root@optogenics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:63959 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932968Ab3CLULB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 16:11:01 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so289072oag.35
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 13:11:00 -0700 (PDT)
In-Reply-To: <2104584728.1783.1363111761558.JavaMail.root@optogenics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

Well to avoid un necessary data movement, there is also an
_experimental_ feature to change on fly the number of PGs in a pool.

ceph osd pool set <poolname> pg_num <numpgs> --allow-experimental-featu=
re

Cheers!
--
Regards,
S=E9bastien Han.


On Tue, Mar 12, 2013 at 7:09 PM, Dave Spano <dspano@optogenics.com> wro=
te:
> Disregard my previous question. I found my answer in the post below. =
Absolutely brilliant! I thought I was screwed!
>
> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/8924
>
> Dave Spano
> Optogenics
> Systems Administrator
>
>
>
> ----- Original Message -----
>
> From: "Dave Spano" <dspano@optogenics.com>
> To: "S=E9bastien Han" <han.sebastien@gmail.com>
> Cc: "Sage Weil" <sage@inktank.com>, "Wido den Hollander" <wido@42on.c=
om>, "Gregory Farnum" <greg@inktank.com>, "Sylvain Munaut" <s.munaut@wh=
atever-company.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel=
 Just" <sam.just@inktank.com>, "Vladislav Gorbunov" <vadikgo@gmail.com>
> Sent: Tuesday, March 12, 2013 1:41:21 PM
> Subject: Re: OSD memory leaks?
>
>
> If one were stupid enough to have their pg_num and pgp_num set to 8 o=
n two of their pools, how could you fix that?
>
>
> Dave Spano
>
>
>
> ----- Original Message -----
>
> From: "S=E9bastien Han" <han.sebastien@gmail.com>
> To: "Vladislav Gorbunov" <vadikgo@gmail.com>
> Cc: "Sage Weil" <sage@inktank.com>, "Wido den Hollander" <wido@42on.c=
om>, "Gregory Farnum" <greg@inktank.com>, "Sylvain Munaut" <s.munaut@wh=
atever-company.com>, "Dave Spano" <dspano@optogenics.com>, "ceph-devel"=
 <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.just@inktank.com>
> Sent: Tuesday, March 12, 2013 9:43:44 AM
> Subject: Re: OSD memory leaks?
>
>>Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph osd
>>dump | grep 'rep size'"
>
> Well it's still 450 each...
>
>>The default pg_num value 8 is NOT suitable for big cluster.
>
> Thanks I know, I'm not new with Ceph. What's your point here? I
> already said that pg_num was 450...
> --
> Regards,
> S=E9bastien Han.
>
>
> On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gorbunov <vadikgo@gmail.co=
m> wrote:
>> Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph os=
d
>> dump | grep 'rep size'"
>> The default pg_num value 8 is NOT suitable for big cluster.
>>
>> 2013/3/13 S=E9bastien Han <han.sebastien@gmail.com>:
>>> Replica count has been set to 2.
>>>
>>> Why?
>>> --
>>> Regards,
>>> S=E9bastien Han.
>>>
>>>
>>> On Tue, Mar 12, 2013 at 12:45 PM, Vladislav Gorbunov <vadikgo@gmail=
=2Ecom> wrote:
>>>>> FYI I'm using 450 pgs for my pools.
>>>> Please, can you show the number of object replicas?
>>>>
>>>> ceph osd dump | grep 'rep size'
>>>>
>>>> Vlad Gorbunov
>>>>
>>>> 2013/3/5 S=E9bastien Han <han.sebastien@gmail.com>:
>>>>> FYI I'm using 450 pgs for my pools.
>>>>>
>>>>> --
>>>>> Regards,
>>>>> S=E9bastien Han.
>>>>>
>>>>>
>>>>> On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.com> wrot=
e:
>>>>>>
>>>>>> On Fri, 1 Mar 2013, Wido den Hollander wrote:
>>>>>> > On 02/23/2013 01:44 AM, Sage Weil wrote:
>>>>>> > > On Fri, 22 Feb 2013, S?bastien Han wrote:
>>>>>> > > > Hi all,
>>>>>> > > >
>>>>>> > > > I finally got a core dump.
>>>>>> > > >
>>>>>> > > > I did it with a kill -SEGV on the OSD process.
>>>>>> > > >
>>>>>> > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11=
-0-0-20100-1361539008
>>>>>> > > >
>>>>>> > > > Hope we will get something out of it :-).
>>>>>> > >
>>>>>> > > AHA! We have a theory. The pg log isnt trimmed during scrub =
(because teh
>>>>>> > > old scrub code required that), but the new (deep) scrub can =
take a very
>>>>>> > > long time, which means the pg log will eat ram in the meanti=
me..
>>>>>> > > especially under high iops.
>>>>>> > >
>>>>>> >
>>>>>> > Does the number of PGs influence the memory leak? So my theory=
 is that when
>>>>>> > you have a high number of PGs with a low number of objects per=
 PG you don't
>>>>>> > see the memory leak.
>>>>>> >
>>>>>> > I saw the memory leak on a RBD system where a pool had just 8 =
PGs, but after
>>>>>> > going to 1024 PGs in a new pool it seemed to be resolved.
>>>>>> >
>>>>>> > I've asked somebody else to try your patch since he's still se=
eing it on his
>>>>>> > systems. Hopefully that gives us some results.
>>>>>>
>>>>>> The PGs were active+clean when you saw the leak? There is a prob=
lem (that
>>>>>> we just fixed in master) where pg logs aren't trimmed for degrad=
ed PGs.
>>>>>>
>>>>>> sage
>>>>>>
>>>>>> >
>>>>>> > Wido
>>>>>> >
>>>>>> > > Can you try wip-osd-log-trim (which is bobtail + a simple pa=
tch) and see
>>>>>> > > if that seems to work? Note that that patch shouldn't be run=
 in a mixed
>>>>>> > > argonaut+bobtail cluster, since it isn't properly checking i=
f the scrub is
>>>>>> > > class or chunky/deep.
>>>>>> > >
>>>>>> > > Thanks!
>>>>>> > > sage
>>>>>> > >
>>>>>> > >
>>>>>> > > > --
>>>>>> > > > Regards,
>>>>>> > > > S?bastien Han.
>>>>>> > > >
>>>>>> > > >
>>>>>> > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inkt=
ank.com> wrote:
>>>>>> > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.seba=
stien@gmail.com>
>>>>>> > > > > wrote:
>>>>>> > > > > > > Is osd.1 using the heap profiler as well? Keep in mi=
nd that active
>>>>>> > > > > > > use
>>>>>> > > > > > > of the memory profiler will itself cause memory usag=
e to increase ?
>>>>>> > > > > > > this sounds a bit like that to me since it's staying=
 stable at a
>>>>>> > > > > > > large
>>>>>> > > > > > > but finite portion of total memory.
>>>>>> > > > > >
>>>>>> > > > > > Well, the memory consumption was already high before t=
he profiler was
>>>>>> > > > > > started. So yes with the memory profiler enable an OSD=
 might consume
>>>>>> > > > > > more memory but this doesn't cause the memory leaks.
>>>>>> > > > >
>>>>>> > > > > My concern is that maybe you saw a leak but when you res=
tarted with
>>>>>> > > > > the memory profiling you lost whatever conditions caused=
 it.
>>>>>> > > > >
>>>>>> > > > > > Any ideas? Nothing to say about my scrumbing theory?
>>>>>> > > > > I like it, but Sam indicates that without some heap dump=
s which
>>>>>> > > > > capture the actual leak then scrub is too large to effec=
tively code
>>>>>> > > > > review for leaks. :(
>>>>>> > > > > -Greg
>>>>>> > > > --
>>>>>> > > > To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>>>>> > > > the body of a message to majordomo@vger.kernel.org
>>>>>> > > > More majordomo info at http://vger.kernel.org/majordomo-in=
fo.html
>>>>>> > > >
>>>>>> > > >
>>>>>> > > --
>>>>>> > > To unsubscribe from this list: send the line "unsubscribe ce=
ph-devel" in
>>>>>> > > the body of a message to majordomo@vger.kernel.org
>>>>>> > > More majordomo info at http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>> > >
>>>>>> >
>>>>>> >
>>>>>> > --
>>>>>> > Wido den Hollander
>>>>>> > 42on B.V.
>>>>>> >
>>>>>> > Phone: +31 (0)20 700 9902
>>>>>> > Skype: contact42on
>>>>>> >
>>>>>> >
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
