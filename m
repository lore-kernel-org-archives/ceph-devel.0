From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Wed, 13 Mar 2013 20:59:03 +0100
Message-ID: <CAOLwVUm_ViY_sY9cZ4=5rVi-bLWs1VO8vSz_FE=n2bsjjiDRPw@mail.gmail.com>
References: <9F9CA4292FC9418AAC3368044C8CBA5E@inktank.com> <18163498.32.1363180362051.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:58069 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934224Ab3CMT7X convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 15:59:23 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so1504295oag.7
        for <ceph-devel@vger.kernel.org>; Wed, 13 Mar 2013 12:59:23 -0700 (PDT)
In-Reply-To: <18163498.32.1363180362051.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

Dave,

Just to be sure, did the log max recent=3D10000 _completely_ stod the
memory leak or did it slow it down?

Thanks!
--
Regards,
S=E9bastien Han.


On Wed, Mar 13, 2013 at 2:12 PM, Dave Spano <dspano@optogenics.com> wro=
te:
> Lol. I'm totally fine with that. My glance images pool isn't used too=
 often. I'm going to give that a try today and see what happens.
>
> I'm still crossing my fingers, but since I added log max recent=3D100=
00 to ceph.conf, I've been okay despite the improper pg_num, and a lot =
of scrubbing/deep scrubbing yesterday.
>
> Dave Spano
>
>
>
>
> ----- Original Message -----
>
> From: "Greg Farnum" <greg@inktank.com>
> To: "Dave Spano" <dspano@optogenics.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage@inkt=
ank.com>, "Wido den Hollander" <wido@42on.com>, "Sylvain Munaut" <s.mun=
aut@whatever-company.com>, "Samuel Just" <sam.just@inktank.com>, "Vladi=
slav Gorbunov" <vadikgo@gmail.com>, "S=E9bastien Han" <han.sebastien@gm=
ail.com>
> Sent: Tuesday, March 12, 2013 5:37:37 PM
> Subject: Re: OSD memory leaks?
>
> Yeah. There's not anything intelligent about that cppool mechanism. :=
)
> -Greg
>
> On Tuesday, March 12, 2013 at 2:15 PM, Dave Spano wrote:
>
>> I'd rather shut the cloud down and copy the pool to a new one than t=
ake any chances of corruption by using an experimental feature. My gues=
s is that there cannot be any i/o to the pool while copying, otherwise =
you'll lose the changes that are happening during the copy, correct?
>>
>> Dave Spano
>> Optogenics
>> Systems Administrator
>>
>>
>>
>> ----- Original Message -----
>>
>> From: "Greg Farnum" <greg@inktank.com (mailto:greg@inktank.com)>
>> To: "S=E9bastien Han" <han.sebastien@gmail.com (mailto:han.sebastien=
@gmail.com)>
>> Cc: "Dave Spano" <dspano@optogenics.com (mailto:dspano@optogenics.co=
m)>, "ceph-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.k=
ernel.org)>, "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, =
"Wido den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Sylvain M=
unaut" <s.munaut@whatever-company.com (mailto:s.munaut@whatever-company=
=2Ecom)>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.=
com)>, "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmail.co=
m)>
>> Sent: Tuesday, March 12, 2013 4:20:13 PM
>> Subject: Re: OSD memory leaks?
>>
>> On Tuesday, March 12, 2013 at 1:10 PM, S=E9bastien Han wrote:
>> > Well to avoid un necessary data movement, there is also an
>> > _experimental_ feature to change on fly the number of PGs in a poo=
l.
>> >
>> > ceph osd pool set <poolname> pg_num <numpgs> --allow-experimental-=
feature
>> Don't do that. We've got a set of 3 patches which fix bugs we know a=
bout that aren't in bobtail yet, and I'm sure there's more we aren't aw=
are of=85
>> -Greg
>>
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>> >
>> > Cheers!
>> > --
>> > Regards,
>> > S=E9bastien Han.
>> >
>> >
>> > On Tue, Mar 12, 2013 at 7:09 PM, Dave Spano <dspano@optogenics.com=
 (mailto:dspano@optogenics.com)> wrote:
>> > > Disregard my previous question. I found my answer in the post be=
low. Absolutely brilliant! I thought I was screwed!
>> > >
>> > > http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/89=
24
>> > >
>> > > Dave Spano
>> > > Optogenics
>> > > Systems Administrator
>> > >
>> > >
>> > >
>> > > ----- Original Message -----
>> > >
>> > > From: "Dave Spano" <dspano@optogenics.com (mailto:dspano@optogen=
ics.com)>
>> > > To: "S=E9bastien Han" <han.sebastien@gmail.com (mailto:han.sebas=
tien@gmail.com)>
>> > > Cc: "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, "W=
ido den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Gregory Far=
num" <greg@inktank.com (mailto:greg@inktank.com)>, "Sylvain Munaut" <s.=
munaut@whatever-company.com (mailto:s.munaut@whatever-company.com)>, "c=
eph-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.o=
rg)>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.com)=
>, "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmail.com)>
>> > > Sent: Tuesday, March 12, 2013 1:41:21 PM
>> > > Subject: Re: OSD memory leaks?
>> > >
>> > >
>> > > If one were stupid enough to have their pg_num and pgp_num set t=
o 8 on two of their pools, how could you fix that?
>> > >
>> > >
>> > > Dave Spano
>> > >
>> > >
>> > >
>> > > ----- Original Message -----
>> > >
>> > > From: "S=E9bastien Han" <han.sebastien@gmail.com (mailto:han.seb=
astien@gmail.com)>
>> > > To: "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmai=
l.com)>
>> > > Cc: "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, "W=
ido den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Gregory Far=
num" <greg@inktank.com (mailto:greg@inktank.com)>, "Sylvain Munaut" <s.=
munaut@whatever-company.com (mailto:s.munaut@whatever-company.com)>, "D=
ave Spano" <dspano@optogenics.com (mailto:dspano@optogenics.com)>, "cep=
h-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org=
)>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.com)>
>> > > Sent: Tuesday, March 12, 2013 9:43:44 AM
>> > > Subject: Re: OSD memory leaks?
>> > >
>> > > > Sorry, i mean pg_num and pgp_num on all pools. Shown by the "c=
eph osd
>> > > > dump | grep 'rep size'"
>> > >
>> > >
>> > >
>> > >
>> > >
>> > > Well it's still 450 each...
>> > >
>> > > > The default pg_num value 8 is NOT suitable for big cluster.
>> > >
>> > > Thanks I know, I'm not new with Ceph. What's your point here? I
>> > > already said that pg_num was 450...
>> > > --
>> > > Regards,
>> > > S=E9bastien Han.
>> > >
>> > >
>> > > On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gorbunov <vadikgo@gma=
il.com (mailto:vadikgo@gmail.com)> wrote:
>> > > > Sorry, i mean pg_num and pgp_num on all pools. Shown by the "c=
eph osd
>> > > > dump | grep 'rep size'"
>> > > > The default pg_num value 8 is NOT suitable for big cluster.
>> > > >
>> > > > 2013/3/13 S=E9bastien Han <han.sebastien@gmail.com (mailto:han=
=2Esebastien@gmail.com)>:
>> > > > > Replica count has been set to 2.
>> > > > >
>> > > > > Why?
>> > > > > --
>> > > > > Regards,
>> > > > > S=E9bastien Han.
>> > > > >
>> > > > >
>> > > > > On Tue, Mar 12, 2013 at 12:45 PM, Vladislav Gorbunov <vadikg=
o@gmail.com (mailto:vadikgo@gmail.com)> wrote:
>> > > > > > > FYI I'm using 450 pgs for my pools.
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > Please, can you show the number of object replicas?
>> > > > > >
>> > > > > > ceph osd dump | grep 'rep size'
>> > > > > >
>> > > > > > Vlad Gorbunov
>> > > > > >
>> > > > > > 2013/3/5 S=E9bastien Han <han.sebastien@gmail.com (mailto:=
han.sebastien@gmail.com)>:
>> > > > > > > FYI I'm using 450 pgs for my pools.
>> > > > > > >
>> > > > > > > --
>> > > > > > > Regards,
>> > > > > > > S=E9bastien Han.
>> > > > > > >
>> > > > > > >
>> > > > > > > On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.=
com (mailto:sage@inktank.com)> wrote:
>> > > > > > > >
>> > > > > > > > On Fri, 1 Mar 2013, Wido den Hollander wrote:
>> > > > > > > > > On 02/23/2013 01:44 AM, Sage Weil wrote:
>> > > > > > > > > > On Fri, 22 Feb 2013, S?bastien Han wrote:
>> > > > > > > > > > > Hi all,
>> > > > > > > > > > >
>> > > > > > > > > > > I finally got a core dump.
>> > > > > > > > > > >
>> > > > > > > > > > > I did it with a kill -SEGV on the OSD process.
>> > > > > > > > > > >
>> > > > > > > > > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-c=
eph-osd-11-0-0-20100-1361539008
>> > > > > > > > > > >
>> > > > > > > > > > > Hope we will get something out of it :-).
>> > > > > > > > > >
>> > > > > > > > > > AHA! We have a theory. The pg log isnt trimmed dur=
ing scrub (because teh
>> > > > > > > > > > old scrub code required that), but the new (deep) =
scrub can take a very
>> > > > > > > > > > long time, which means the pg log will eat ram in =
the meantime..
>> > > > > > > > > > especially under high iops.
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > Does the number of PGs influence the memory leak? So=
 my theory is that when
>> > > > > > > > > you have a high number of PGs with a low number of o=
bjects per PG you don't
>> > > > > > > > > see the memory leak.
>> > > > > > > > >
>> > > > > > > > > I saw the memory leak on a RBD system where a pool h=
ad just 8 PGs, but after
>> > > > > > > > > going to 1024 PGs in a new pool it seemed to be reso=
lved.
>> > > > > > > > >
>> > > > > > > > > I've asked somebody else to try your patch since he'=
s still seeing it on his
>> > > > > > > > > systems. Hopefully that gives us some results.
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > > The PGs were active+clean when you saw the leak? There=
 is a problem (that
>> > > > > > > > we just fixed in master) where pg logs aren't trimmed =
for degraded PGs.
>> > > > > > > >
>> > > > > > > > sage
>> > > > > > > >
>> > > > > > > > >
>> > > > > > > > > Wido
>> > > > > > > > >
>> > > > > > > > > > Can you try wip-osd-log-trim (which is bobtail + a=
 simple patch) and see
>> > > > > > > > > > if that seems to work? Note that that patch should=
n't be run in a mixed
>> > > > > > > > > > argonaut+bobtail cluster, since it isn't properly =
checking if the scrub is
>> > > > > > > > > > class or chunky/deep.
>> > > > > > > > > >
>> > > > > > > > > > Thanks!
>> > > > > > > > > > sage
>> > > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > > > --
>> > > > > > > > > > > Regards,
>> > > > > > > > > > > S?bastien Han.
>> > > > > > > > > > >
>> > > > > > > > > > >
>> > > > > > > > > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum =
<greg@inktank.com (mailto:greg@inktank.com)> wrote:
>> > > > > > > > > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han=
 <han.sebastien@gmail.com (mailto:han.sebastien@gmail.com)>
>> > > > > > > > > > > > wrote:
>> > > > > > > > > > > > > > Is osd.1 using the heap profiler as well? =
Keep in mind that active
>> > > > > > > > > > > > > > use
>> > > > > > > > > > > > > > of the memory profiler will itself cause m=
emory usage to increase ?
>> > > > > > > > > > > > > > this sounds a bit like that to me since it=
's staying stable at a
>> > > > > > > > > > > > > > large
>> > > > > > > > > > > > > > but finite portion of total memory.
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > Well, the memory consumption was already hig=
h before the profiler was
>> > > > > > > > > > > > > started. So yes with the memory profiler ena=
ble an OSD might consume
>> > > > > > > > > > > > > more memory but this doesn't cause the memor=
y leaks.
>> > > > > > > > > > > >
>> > > > > > > > > > > >
>> > > > > > > > > > > >
>> > > > > > > > > > > >
>> > > > > > > > > > > >
>> > > > > > > > > > > > My concern is that maybe you saw a leak but wh=
en you restarted with
>> > > > > > > > > > > > the memory profiling you lost whatever conditi=
ons caused it.
>> > > > > > > > > > > >
>> > > > > > > > > > > > > Any ideas? Nothing to say about my scrumbing=
 theory?
>> > > > > > > > > > > > I like it, but Sam indicates that without some=
 heap dumps which
>> > > > > > > > > > > > capture the actual leak then scrub is too larg=
e to effectively code
>> > > > > > > > > > > > review for leaks. :(
>> > > > > > > > > > > > -Greg
>> > > > > > > > > > >
>> > > > > > > > > > >
>> > > > > > > > > > >
>> > > > > > > > > > >
>> > > > > > > > > > > --
>> > > > > > > > > > > To unsubscribe from this list: send the line "un=
subscribe ceph-devel" in
>> > > > > > > > > > > the body of a message to majordomo@vger.kernel.o=
rg (mailto:majordomo@vger.kernel.org)
>> > > > > > > > > > > More majordomo info at http://vger.kernel.org/ma=
jordomo-info.html
>> > > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > > --
>> > > > > > > > > > To unsubscribe from this list: send the line "unsu=
bscribe ceph-devel" in
>> > > > > > > > > > the body of a message to majordomo@vger.kernel.org=
 (mailto:majordomo@vger.kernel.org)
>> > > > > > > > > > More majordomo info at http://vger.kernel.org/majo=
rdomo-info.html
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > --
>> > > > > > > > > Wido den Hollander
>> > > > > > > > > 42on B.V.
>> > > > > > > > >
>> > > > > > > > > Phone: +31 (0)20 700 9902
>> > > > > > > > > Skype: contact42on
>> > > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > > --
>> > > > > > > To unsubscribe from this list: send the line "unsubscrib=
e ceph-devel" in
>> > > > > > > the body of a message to majordomo@vger.kernel.org (mail=
to:majordomo@vger.kernel.org)
>> > > > > > > More majordomo info at http://vger.kernel.org/majordomo-=
info.html
>> > > > > >
>> > > > >
>> > > >
>> > >
>> > >
>> > >
>> > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>> > > the body of a message to majordomo@vger.kernel.org (mailto:major=
domo@vger.kernel.org)
>> > > More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l
>> >
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
