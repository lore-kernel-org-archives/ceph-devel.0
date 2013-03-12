From: Dave Spano <dspano@optogenics.com>
Subject: Re: OSD memory leaks?
Date: Tue, 12 Mar 2013 14:09:21 -0400 (EDT)
Message-ID: <2104584728.1783.1363111761558.JavaMail.root@optogenics.com>
References: <7332688.5.1363110084349.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:35289 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab3CLSJX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 14:09:23 -0400
In-Reply-To: <7332688.5.1363110084349.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>

Disregard my previous question. I found my answer in the post below. Ab=
solutely brilliant! I thought I was screwed!=20

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/8924=20

Dave Spano=20
Optogenics=20
Systems Administrator=20



----- Original Message -----=20

=46rom: "Dave Spano" <dspano@optogenics.com>=20
To: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
Cc: "Sage Weil" <sage@inktank.com>, "Wido den Hollander" <wido@42on.com=
>, "Gregory Farnum" <greg@inktank.com>, "Sylvain Munaut" <s.munaut@what=
ever-company.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel J=
ust" <sam.just@inktank.com>, "Vladislav Gorbunov" <vadikgo@gmail.com>=20
Sent: Tuesday, March 12, 2013 1:41:21 PM=20
Subject: Re: OSD memory leaks?=20


If one were stupid enough to have their pg_num and pgp_num set to 8 on =
two of their pools, how could you fix that?=20


Dave Spano=20



----- Original Message -----

=46rom: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
To: "Vladislav Gorbunov" <vadikgo@gmail.com>=20
Cc: "Sage Weil" <sage@inktank.com>, "Wido den Hollander" <wido@42on.com=
>, "Gregory Farnum" <greg@inktank.com>, "Sylvain Munaut" <s.munaut@what=
ever-company.com>, "Dave Spano" <dspano@optogenics.com>, "ceph-devel" <=
ceph-devel@vger.kernel.org>, "Samuel Just" <sam.just@inktank.com>=20
Sent: Tuesday, March 12, 2013 9:43:44 AM=20
Subject: Re: OSD memory leaks?=20

>Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph osd=20
>dump | grep 'rep size'"=20

Well it's still 450 each...=20

>The default pg_num value 8 is NOT suitable for big cluster.=20

Thanks I know, I'm not new with Ceph. What's your point here? I=20
already said that pg_num was 450...=20
--=20
Regards,=20
S=C3=A9bastien Han.=20


On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gorbunov <vadikgo@gmail.com>=
 wrote:=20
> Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph osd=
=20
> dump | grep 'rep size'"=20
> The default pg_num value 8 is NOT suitable for big cluster.=20
>=20
> 2013/3/13 S=C3=A9bastien Han <han.sebastien@gmail.com>:=20
>> Replica count has been set to 2.=20
>>=20
>> Why?=20
>> --=20
>> Regards,=20
>> S=C3=A9bastien Han.=20
>>=20
>>=20
>> On Tue, Mar 12, 2013 at 12:45 PM, Vladislav Gorbunov <vadikgo@gmail.=
com> wrote:=20
>>>> FYI I'm using 450 pgs for my pools.=20
>>> Please, can you show the number of object replicas?=20
>>>=20
>>> ceph osd dump | grep 'rep size'=20
>>>=20
>>> Vlad Gorbunov=20
>>>=20
>>> 2013/3/5 S=C3=A9bastien Han <han.sebastien@gmail.com>:=20
>>>> FYI I'm using 450 pgs for my pools.=20
>>>>=20
>>>> --=20
>>>> Regards,=20
>>>> S=C3=A9bastien Han.=20
>>>>=20
>>>>=20
>>>> On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.com> wrote=
:=20
>>>>>=20
>>>>> On Fri, 1 Mar 2013, Wido den Hollander wrote:=20
>>>>> > On 02/23/2013 01:44 AM, Sage Weil wrote:=20
>>>>> > > On Fri, 22 Feb 2013, S?bastien Han wrote:=20
>>>>> > > > Hi all,=20
>>>>> > > >=20
>>>>> > > > I finally got a core dump.=20
>>>>> > > >=20
>>>>> > > > I did it with a kill -SEGV on the OSD process.=20
>>>>> > > >=20
>>>>> > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-=
0-0-20100-1361539008=20
>>>>> > > >=20
>>>>> > > > Hope we will get something out of it :-).=20
>>>>> > >=20
>>>>> > > AHA! We have a theory. The pg log isnt trimmed during scrub (=
because teh=20
>>>>> > > old scrub code required that), but the new (deep) scrub can t=
ake a very=20
>>>>> > > long time, which means the pg log will eat ram in the meantim=
e..=20
>>>>> > > especially under high iops.=20
>>>>> > >=20
>>>>> >=20
>>>>> > Does the number of PGs influence the memory leak? So my theory =
is that when=20
>>>>> > you have a high number of PGs with a low number of objects per =
PG you don't=20
>>>>> > see the memory leak.=20
>>>>> >=20
>>>>> > I saw the memory leak on a RBD system where a pool had just 8 P=
Gs, but after=20
>>>>> > going to 1024 PGs in a new pool it seemed to be resolved.=20
>>>>> >=20
>>>>> > I've asked somebody else to try your patch since he's still see=
ing it on his=20
>>>>> > systems. Hopefully that gives us some results.=20
>>>>>=20
>>>>> The PGs were active+clean when you saw the leak? There is a probl=
em (that=20
>>>>> we just fixed in master) where pg logs aren't trimmed for degrade=
d PGs.=20
>>>>>=20
>>>>> sage=20
>>>>>=20
>>>>> >=20
>>>>> > Wido=20
>>>>> >=20
>>>>> > > Can you try wip-osd-log-trim (which is bobtail + a simple pat=
ch) and see=20
>>>>> > > if that seems to work? Note that that patch shouldn't be run =
in a mixed=20
>>>>> > > argonaut+bobtail cluster, since it isn't properly checking if=
 the scrub is=20
>>>>> > > class or chunky/deep.=20
>>>>> > >=20
>>>>> > > Thanks!=20
>>>>> > > sage=20
>>>>> > >=20
>>>>> > >=20
>>>>> > > > --=20
>>>>> > > > Regards,=20
>>>>> > > > S?bastien Han.=20
>>>>> > > >=20
>>>>> > > >=20
>>>>> > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inkta=
nk.com> wrote:=20
>>>>> > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebas=
tien@gmail.com>=20
>>>>> > > > > wrote:=20
>>>>> > > > > > > Is osd.1 using the heap profiler as well? Keep in min=
d that active=20
>>>>> > > > > > > use=20
>>>>> > > > > > > of the memory profiler will itself cause memory usage=
 to increase ?=20
>>>>> > > > > > > this sounds a bit like that to me since it's staying =
stable at a=20
>>>>> > > > > > > large=20
>>>>> > > > > > > but finite portion of total memory.=20
>>>>> > > > > >=20
>>>>> > > > > > Well, the memory consumption was already high before th=
e profiler was=20
>>>>> > > > > > started. So yes with the memory profiler enable an OSD =
might consume=20
>>>>> > > > > > more memory but this doesn't cause the memory leaks.=20
>>>>> > > > >=20
>>>>> > > > > My concern is that maybe you saw a leak but when you rest=
arted with=20
>>>>> > > > > the memory profiling you lost whatever conditions caused =
it.=20
>>>>> > > > >=20
>>>>> > > > > > Any ideas? Nothing to say about my scrumbing theory?=20
>>>>> > > > > I like it, but Sam indicates that without some heap dumps=
 which=20
>>>>> > > > > capture the actual leak then scrub is too large to effect=
ively code=20
>>>>> > > > > review for leaks. :(=20
>>>>> > > > > -Greg=20
>>>>> > > > --=20
>>>>> > > > To unsubscribe from this list: send the line "unsubscribe c=
eph-devel" in=20
>>>>> > > > the body of a message to majordomo@vger.kernel.org=20
>>>>> > > > More majordomo info at http://vger.kernel.org/majordomo-inf=
o.html=20
>>>>> > > >=20
>>>>> > > >=20
>>>>> > > --=20
>>>>> > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in=20
>>>>> > > the body of a message to majordomo@vger.kernel.org=20
>>>>> > > More majordomo info at http://vger.kernel.org/majordomo-info.=
html=20
>>>>> > >=20
>>>>> >=20
>>>>> >=20
>>>>> > --=20
>>>>> > Wido den Hollander=20
>>>>> > 42on B.V.=20
>>>>> >=20
>>>>> > Phone: +31 (0)20 700 9902=20
>>>>> > Skype: contact42on=20
>>>>> >=20
>>>>> >=20
>>>> --=20
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in=20
>>>> the body of a message to majordomo@vger.kernel.org=20
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
