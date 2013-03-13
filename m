From: Dave Spano <dspano@optogenics.com>
Subject: Re: OSD memory leaks?
Date: Wed, 13 Mar 2013 18:38:00 -0400 (EDT)
Message-ID: <15539190.145.1363214282384.JavaMail.dspano@it1>
References: <CAOLwVUm_ViY_sY9cZ4=5rVi-bLWs1VO8vSz_FE=n2bsjjiDRPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:36380 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab3CMWiG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 18:38:06 -0400
In-Reply-To: <CAOLwVUm_ViY_sY9cZ4=5rVi-bLWs1VO8vSz_FE=n2bsjjiDRPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

Sebastien,

I'm not totally sure yet, but everything is still working.=20


Sage and Greg,=20
I copied my glance image pool per the posting I mentioned previously, a=
nd everything works when I use the ceph tools. I can export rbds from t=
he new pool and delete them as well.

I noticed that the copied images pool does not work with glance.=20

I get this error when I try to create images in the new pool. If I put =
the old pool back, I can create images no problem.=20

Is there something I'm missing in glance that I need to work with a poo=
l created in bobtail? I'm using Openstack Folsom.=20

  File "/usr/lib/python2.7/dist-packages/glance/api/v1/images.py", line=
 437, in _upload                =20
    image_meta['size'])                                                =
                                 =20
  File "/usr/lib/python2.7/dist-packages/glance/store/rbd.py", line 244=
, in add                         =20
    image_size, order)                                                 =
                                 =20
  File "/usr/lib/python2.7/dist-packages/glance/store/rbd.py", line 207=
, in _create_image               =20
    features=3Drbd.RBD_FEATURE_LAYERING)                               =
                                   =20
  File "/usr/lib/python2.7/dist-packages/rbd.py", line 194, in create  =
                                 =20
    raise make_ex(ret, 'error creating image')                         =
                                 =20
PermissionError: error creating image


Dave Spano=20
=20



----- Original Message -----=20

=46rom: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
To: "Dave Spano" <dspano@optogenics.com>=20
Cc: "Greg Farnum" <greg@inktank.com>, "ceph-devel" <ceph-devel@vger.ker=
nel.org>, "Sage Weil" <sage@inktank.com>, "Wido den Hollander" <wido@42=
on.com>, "Sylvain Munaut" <s.munaut@whatever-company.com>, "Samuel Just=
" <sam.just@inktank.com>, "Vladislav Gorbunov" <vadikgo@gmail.com>=20
Sent: Wednesday, March 13, 2013 3:59:03 PM=20
Subject: Re: OSD memory leaks?=20

Dave,=20

Just to be sure, did the log max recent=3D10000 _completely_ stod the=20
memory leak or did it slow it down?=20

Thanks!=20
--=20
Regards,=20
S=C3=A9bastien Han.=20


On Wed, Mar 13, 2013 at 2:12 PM, Dave Spano <dspano@optogenics.com> wro=
te:=20
> Lol. I'm totally fine with that. My glance images pool isn't used too=
 often. I'm going to give that a try today and see what happens.=20
>=20
> I'm still crossing my fingers, but since I added log max recent=3D100=
00 to ceph.conf, I've been okay despite the improper pg_num, and a lot =
of scrubbing/deep scrubbing yesterday.=20
>=20
> Dave Spano=20
>=20
>=20
>=20
>=20
> ----- Original Message -----=20
>=20
> From: "Greg Farnum" <greg@inktank.com>=20
> To: "Dave Spano" <dspano@optogenics.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage@inkt=
ank.com>, "Wido den Hollander" <wido@42on.com>, "Sylvain Munaut" <s.mun=
aut@whatever-company.com>, "Samuel Just" <sam.just@inktank.com>, "Vladi=
slav Gorbunov" <vadikgo@gmail.com>, "S=C3=A9bastien Han" <han.sebastien=
@gmail.com>=20
> Sent: Tuesday, March 12, 2013 5:37:37 PM=20
> Subject: Re: OSD memory leaks?=20
>=20
> Yeah. There's not anything intelligent about that cppool mechanism. :=
)=20
> -Greg=20
>=20
> On Tuesday, March 12, 2013 at 2:15 PM, Dave Spano wrote:=20
>=20
>> I'd rather shut the cloud down and copy the pool to a new one than t=
ake any chances of corruption by using an experimental feature. My gues=
s is that there cannot be any i/o to the pool while copying, otherwise =
you'll lose the changes that are happening during the copy, correct?=20
>>=20
>> Dave Spano=20
>> Optogenics=20
>> Systems Administrator=20
>>=20
>>=20
>>=20
>> ----- Original Message -----=20
>>=20
>> From: "Greg Farnum" <greg@inktank.com (mailto:greg@inktank.com)>=20
>> To: "S=C3=A9bastien Han" <han.sebastien@gmail.com (mailto:han.sebast=
ien@gmail.com)>=20
>> Cc: "Dave Spano" <dspano@optogenics.com (mailto:dspano@optogenics.co=
m)>, "ceph-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.k=
ernel.org)>, "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, =
"Wido den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Sylvain M=
unaut" <s.munaut@whatever-company.com (mailto:s.munaut@whatever-company=
=2Ecom)>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.=
com)>, "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmail.co=
m)>=20
>> Sent: Tuesday, March 12, 2013 4:20:13 PM=20
>> Subject: Re: OSD memory leaks?=20
>>=20
>> On Tuesday, March 12, 2013 at 1:10 PM, S=C3=A9bastien Han wrote:=20
>> > Well to avoid un necessary data movement, there is also an=20
>> > _experimental_ feature to change on fly the number of PGs in a poo=
l.=20
>> >=20
>> > ceph osd pool set <poolname> pg_num <numpgs> --allow-experimental-=
feature=20
>> Don't do that. We've got a set of 3 patches which fix bugs we know a=
bout that aren't in bobtail yet, and I'm sure there's more we aren't aw=
are of=E2=80=A6=20
>> -Greg=20
>>=20
>> Software Engineer #42 @ http://inktank.com | http://ceph.com=20
>>=20
>> >=20
>> > Cheers!=20
>> > --=20
>> > Regards,=20
>> > S=C3=A9bastien Han.=20
>> >=20
>> >=20
>> > On Tue, Mar 12, 2013 at 7:09 PM, Dave Spano <dspano@optogenics.com=
 (mailto:dspano@optogenics.com)> wrote:=20
>> > > Disregard my previous question. I found my answer in the post be=
low. Absolutely brilliant! I thought I was screwed!=20
>> > >=20
>> > > http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/89=
24=20
>> > >=20
>> > > Dave Spano=20
>> > > Optogenics=20
>> > > Systems Administrator=20
>> > >=20
>> > >=20
>> > >=20
>> > > ----- Original Message -----=20
>> > >=20
>> > > From: "Dave Spano" <dspano@optogenics.com (mailto:dspano@optogen=
ics.com)>=20
>> > > To: "S=C3=A9bastien Han" <han.sebastien@gmail.com (mailto:han.se=
bastien@gmail.com)>=20
>> > > Cc: "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, "W=
ido den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Gregory Far=
num" <greg@inktank.com (mailto:greg@inktank.com)>, "Sylvain Munaut" <s.=
munaut@whatever-company.com (mailto:s.munaut@whatever-company.com)>, "c=
eph-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.o=
rg)>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.com)=
>, "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmail.com)>=20
>> > > Sent: Tuesday, March 12, 2013 1:41:21 PM=20
>> > > Subject: Re: OSD memory leaks?=20
>> > >=20
>> > >=20
>> > > If one were stupid enough to have their pg_num and pgp_num set t=
o 8 on two of their pools, how could you fix that?=20
>> > >=20
>> > >=20
>> > > Dave Spano=20
>> > >=20
>> > >=20
>> > >=20
>> > > ----- Original Message -----=20
>> > >=20
>> > > From: "S=C3=A9bastien Han" <han.sebastien@gmail.com (mailto:han.=
sebastien@gmail.com)>=20
>> > > To: "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmai=
l.com)>=20
>> > > Cc: "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, "W=
ido den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Gregory Far=
num" <greg@inktank.com (mailto:greg@inktank.com)>, "Sylvain Munaut" <s.=
munaut@whatever-company.com (mailto:s.munaut@whatever-company.com)>, "D=
ave Spano" <dspano@optogenics.com (mailto:dspano@optogenics.com)>, "cep=
h-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org=
)>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.com)>=20
>> > > Sent: Tuesday, March 12, 2013 9:43:44 AM=20
>> > > Subject: Re: OSD memory leaks?=20
>> > >=20
>> > > > Sorry, i mean pg_num and pgp_num on all pools. Shown by the "c=
eph osd=20
>> > > > dump | grep 'rep size'"=20
>> > >=20
>> > >=20
>> > >=20
>> > >=20
>> > >=20
>> > > Well it's still 450 each...=20
>> > >=20
>> > > > The default pg_num value 8 is NOT suitable for big cluster.=20
>> > >=20
>> > > Thanks I know, I'm not new with Ceph. What's your point here? I=20
>> > > already said that pg_num was 450...=20
>> > > --=20
>> > > Regards,=20
>> > > S=C3=A9bastien Han.=20
>> > >=20
>> > >=20
>> > > On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gorbunov <vadikgo@gma=
il.com (mailto:vadikgo@gmail.com)> wrote:=20
>> > > > Sorry, i mean pg_num and pgp_num on all pools. Shown by the "c=
eph osd=20
>> > > > dump | grep 'rep size'"=20
>> > > > The default pg_num value 8 is NOT suitable for big cluster.=20
>> > > >=20
>> > > > 2013/3/13 S=C3=A9bastien Han <han.sebastien@gmail.com (mailto:=
han.sebastien@gmail.com)>:=20
>> > > > > Replica count has been set to 2.=20
>> > > > >=20
>> > > > > Why?=20
>> > > > > --=20
>> > > > > Regards,=20
>> > > > > S=C3=A9bastien Han.=20
>> > > > >=20
>> > > > >=20
>> > > > > On Tue, Mar 12, 2013 at 12:45 PM, Vladislav Gorbunov <vadikg=
o@gmail.com (mailto:vadikgo@gmail.com)> wrote:=20
>> > > > > > > FYI I'm using 450 pgs for my pools.=20
>> > > > > >=20
>> > > > > >=20
>> > > > > >=20
>> > > > > >=20
>> > > > > > Please, can you show the number of object replicas?=20
>> > > > > >=20
>> > > > > > ceph osd dump | grep 'rep size'=20
>> > > > > >=20
>> > > > > > Vlad Gorbunov=20
>> > > > > >=20
>> > > > > > 2013/3/5 S=C3=A9bastien Han <han.sebastien@gmail.com (mail=
to:han.sebastien@gmail.com)>:=20
>> > > > > > > FYI I'm using 450 pgs for my pools.=20
>> > > > > > >=20
>> > > > > > > --=20
>> > > > > > > Regards,=20
>> > > > > > > S=C3=A9bastien Han.=20
>> > > > > > >=20
>> > > > > > >=20
>> > > > > > > On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.=
com (mailto:sage@inktank.com)> wrote:=20
>> > > > > > > >=20
>> > > > > > > > On Fri, 1 Mar 2013, Wido den Hollander wrote:=20
>> > > > > > > > > On 02/23/2013 01:44 AM, Sage Weil wrote:=20
>> > > > > > > > > > On Fri, 22 Feb 2013, S?bastien Han wrote:=20
>> > > > > > > > > > > Hi all,=20
>> > > > > > > > > > >=20
>> > > > > > > > > > > I finally got a core dump.=20
>> > > > > > > > > > >=20
>> > > > > > > > > > > I did it with a kill -SEGV on the OSD process.=20
>> > > > > > > > > > >=20
>> > > > > > > > > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-c=
eph-osd-11-0-0-20100-1361539008=20
>> > > > > > > > > > >=20
>> > > > > > > > > > > Hope we will get something out of it :-).=20
>> > > > > > > > > >=20
>> > > > > > > > > > AHA! We have a theory. The pg log isnt trimmed dur=
ing scrub (because teh=20
>> > > > > > > > > > old scrub code required that), but the new (deep) =
scrub can take a very=20
>> > > > > > > > > > long time, which means the pg log will eat ram in =
the meantime..=20
>> > > > > > > > > > especially under high iops.=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > > Does the number of PGs influence the memory leak? So=
 my theory is that when=20
>> > > > > > > > > you have a high number of PGs with a low number of o=
bjects per PG you don't=20
>> > > > > > > > > see the memory leak.=20
>> > > > > > > > >=20
>> > > > > > > > > I saw the memory leak on a RBD system where a pool h=
ad just 8 PGs, but after=20
>> > > > > > > > > going to 1024 PGs in a new pool it seemed to be reso=
lved.=20
>> > > > > > > > >=20
>> > > > > > > > > I've asked somebody else to try your patch since he'=
s still seeing it on his=20
>> > > > > > > > > systems. Hopefully that gives us some results.=20
>> > > > > > > >=20
>> > > > > > > >=20
>> > > > > > > >=20
>> > > > > > > >=20
>> > > > > > > >=20
>> > > > > > > > The PGs were active+clean when you saw the leak? There=
 is a problem (that=20
>> > > > > > > > we just fixed in master) where pg logs aren't trimmed =
for degraded PGs.=20
>> > > > > > > >=20
>> > > > > > > > sage=20
>> > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > > Wido=20
>> > > > > > > > >=20
>> > > > > > > > > > Can you try wip-osd-log-trim (which is bobtail + a=
 simple patch) and see=20
>> > > > > > > > > > if that seems to work? Note that that patch should=
n't be run in a mixed=20
>> > > > > > > > > > argonaut+bobtail cluster, since it isn't properly =
checking if the scrub is=20
>> > > > > > > > > > class or chunky/deep.=20
>> > > > > > > > > >=20
>> > > > > > > > > > Thanks!=20
>> > > > > > > > > > sage=20
>> > > > > > > > > >=20
>> > > > > > > > > >=20
>> > > > > > > > > > > --=20
>> > > > > > > > > > > Regards,=20
>> > > > > > > > > > > S?bastien Han.=20
>> > > > > > > > > > >=20
>> > > > > > > > > > >=20
>> > > > > > > > > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum =
<greg@inktank.com (mailto:greg@inktank.com)> wrote:=20
>> > > > > > > > > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han=
 <han.sebastien@gmail.com (mailto:han.sebastien@gmail.com)>=20
>> > > > > > > > > > > > wrote:=20
>> > > > > > > > > > > > > > Is osd.1 using the heap profiler as well? =
Keep in mind that active=20
>> > > > > > > > > > > > > > use=20
>> > > > > > > > > > > > > > of the memory profiler will itself cause m=
emory usage to increase ?=20
>> > > > > > > > > > > > > > this sounds a bit like that to me since it=
's staying stable at a=20
>> > > > > > > > > > > > > > large=20
>> > > > > > > > > > > > > > but finite portion of total memory.=20
>> > > > > > > > > > > > >=20
>> > > > > > > > > > > > >=20
>> > > > > > > > > > > > >=20
>> > > > > > > > > > > > >=20
>> > > > > > > > > > > > >=20
>> > > > > > > > > > > > > Well, the memory consumption was already hig=
h before the profiler was=20
>> > > > > > > > > > > > > started. So yes with the memory profiler ena=
ble an OSD might consume=20
>> > > > > > > > > > > > > more memory but this doesn't cause the memor=
y leaks.=20
>> > > > > > > > > > > >=20
>> > > > > > > > > > > >=20
>> > > > > > > > > > > >=20
>> > > > > > > > > > > >=20
>> > > > > > > > > > > >=20
>> > > > > > > > > > > > My concern is that maybe you saw a leak but wh=
en you restarted with=20
>> > > > > > > > > > > > the memory profiling you lost whatever conditi=
ons caused it.=20
>> > > > > > > > > > > >=20
>> > > > > > > > > > > > > Any ideas? Nothing to say about my scrumbing=
 theory?=20
>> > > > > > > > > > > > I like it, but Sam indicates that without some=
 heap dumps which=20
>> > > > > > > > > > > > capture the actual leak then scrub is too larg=
e to effectively code=20
>> > > > > > > > > > > > review for leaks. :(=20
>> > > > > > > > > > > > -Greg=20
>> > > > > > > > > > >=20
>> > > > > > > > > > >=20
>> > > > > > > > > > >=20
>> > > > > > > > > > >=20
>> > > > > > > > > > > --=20
>> > > > > > > > > > > To unsubscribe from this list: send the line "un=
subscribe ceph-devel" in=20
>> > > > > > > > > > > the body of a message to majordomo@vger.kernel.o=
rg (mailto:majordomo@vger.kernel.org)=20
>> > > > > > > > > > > More majordomo info at http://vger.kernel.org/ma=
jordomo-info.html=20
>> > > > > > > > > >=20
>> > > > > > > > > >=20
>> > > > > > > > > >=20
>> > > > > > > > > >=20
>> > > > > > > > > > --=20
>> > > > > > > > > > To unsubscribe from this list: send the line "unsu=
bscribe ceph-devel" in=20
>> > > > > > > > > > the body of a message to majordomo@vger.kernel.org=
 (mailto:majordomo@vger.kernel.org)=20
>> > > > > > > > > > More majordomo info at http://vger.kernel.org/majo=
rdomo-info.html=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > >=20
>> > > > > > > > > --=20
>> > > > > > > > > Wido den Hollander=20
>> > > > > > > > > 42on B.V.=20
>> > > > > > > > >=20
>> > > > > > > > > Phone: +31 (0)20 700 9902=20
>> > > > > > > > > Skype: contact42on=20
>> > > > > > > >=20
>> > > > > > >=20
>> > > > > > >=20
>> > > > > > >=20
>> > > > > > >=20
>> > > > > > > --=20
>> > > > > > > To unsubscribe from this list: send the line "unsubscrib=
e ceph-devel" in=20
>> > > > > > > the body of a message to majordomo@vger.kernel.org (mail=
to:majordomo@vger.kernel.org)=20
>> > > > > > > More majordomo info at http://vger.kernel.org/majordomo-=
info.html=20
>> > > > > >=20
>> > > > >=20
>> > > >=20
>> > >=20
>> > >=20
>> > >=20
>> > >=20
>> > > --=20
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in=20
>> > > the body of a message to majordomo@vger.kernel.org (mailto:major=
domo@vger.kernel.org)=20
>> > > More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l=20
>> >=20
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
