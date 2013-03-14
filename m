From: Dave Spano <dspano@optogenics.com>
Subject: Re: OSD memory leaks?
Date: Wed, 13 Mar 2013 20:05:47 -0400 (EDT)
Message-ID: <511505218.2097.1363219547568.JavaMail.root@optogenics.com>
References: <F860AE51BB524994916F40B02D0CCE04@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:55029 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588Ab3CNAFy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 20:05:54 -0400
In-Reply-To: <F860AE51BB524994916F40B02D0CCE04@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

I renamed the old one from images to images-old, and the new one from i=
mages-new to images.=20

Dave Spano
Optogenics
Systems Administrator



----- Original Message -----
=46rom: Greg Farnum &lt;greg@inktank.com&gt;
To: Dave Spano &lt;dspano@optogenics.com&gt;
Cc: S=C3=A9bastien Han &lt;han.sebastien@gmail.com&gt;, ceph-devel &lt;=
ceph-devel@vger.kernel.org&gt;, Sage Weil &lt;sage@inktank.com&gt;, Wid=
o den Hollander &lt;wido@42on.com&gt;, Sylvain Munaut &lt;s.munaut@what=
ever-company.com&gt;, Samuel Just &lt;sam.just@inktank.com&gt;, Vladisl=
av Gorbunov &lt;vadikgo@gmail.com&gt;
Sent: Wed, 13 Mar 2013 18:52:29 -0400 (EDT)
Subject: Re: OSD memory leaks?

It sounds like maybe you didn't rename the new pool to use the old pool=
's name? Glance is looking for a specific pool to store its data in; I =
believe it's configurable but you'll need to do one or the other.
-Greg

On Wednesday, March 13, 2013 at 3:38 PM, Dave Spano wrote:

&gt; Sebastien,
&gt;=20
&gt; I'm not totally sure yet, but everything is still working.=20
&gt;=20
&gt;=20
&gt; Sage and Greg,=20
&gt; I copied my glance image pool per the posting I mentioned previous=
ly, and everything works when I use the ceph tools. I can export rbds f=
rom the new pool and delete them as well.
&gt;=20
&gt; I noticed that the copied images pool does not work with glance.=20
&gt;=20
&gt; I get this error when I try to create images in the new pool. If I=
 put the old pool back, I can create images no problem.=20
&gt;=20
&gt; Is there something I'm missing in glance that I need to work with =
a pool created in bobtail? I'm using Openstack Folsom.=20
&gt;=20
&gt; File "/usr/lib/python2.7/dist-packages/glance/api/v1/images.py", l=
ine 437, in _upload=20
&gt; image_meta['size'])=20
&gt; File "/usr/lib/python2.7/dist-packages/glance/store/rbd.py", line =
244, in add=20
&gt; image_size, order)=20
&gt; File "/usr/lib/python2.7/dist-packages/glance/store/rbd.py", line =
207, in _create_image=20
&gt; features=3Drbd.RBD_FEATURE_LAYERING)=20
&gt; File "/usr/lib/python2.7/dist-packages/rbd.py", line 194, in creat=
e=20
&gt; raise make_ex(ret, 'error creating image')=20
&gt; PermissionError: error creating image
&gt;=20
&gt;=20
&gt; Dave Spano=20
&gt;=20
&gt;=20
&gt;=20
&gt;=20
&gt; ----- Original Message -----=20
&gt;=20
&gt; From: "S=C3=A9bastien Han" &lt;han.sebastien@gmail.com (mailto:han=
=2Esebastien@gmail.com)&gt;=20
&gt; To: "Dave Spano" &lt;dspano@optogenics.com (mailto:dspano@optogeni=
cs.com)&gt;=20
&gt; Cc: "Greg Farnum" &lt;greg@inktank.com (mailto:greg@inktank.com)&g=
t;, "ceph-devel" &lt;ceph-devel@vger.kernel.org (mailto:ceph-devel@vger=
=2Ekernel.org)&gt;, "Sage Weil" &lt;sage@inktank.com (mailto:sage@inkta=
nk.com)&gt;, "Wido den Hollander" &lt;wido@42on.com (mailto:wido@42on.c=
om)&gt;, "Sylvain Munaut" &lt;s.munaut@whatever-company.com (mailto:s.m=
unaut@whatever-company.com)&gt;, "Samuel Just" &lt;sam.just@inktank.com=
 (mailto:sam.just@inktank.com)&gt;, "Vladislav Gorbunov" &lt;vadikgo@gm=
ail.com (mailto:vadikgo@gmail.com)&gt;=20
&gt; Sent: Wednesday, March 13, 2013 3:59:03 PM=20
&gt; Subject: Re: OSD memory leaks?=20
&gt;=20
&gt; Dave,=20
&gt;=20
&gt; Just to be sure, did the log max recent=3D10000 _completely_ stod =
the=20
&gt; memory leak or did it slow it down?=20
&gt;=20
&gt; Thanks!=20
&gt; --=20
&gt; Regards,=20
&gt; S=C3=A9bastien Han.=20
&gt;=20
&gt;=20
&gt; On Wed, Mar 13, 2013 at 2:12 PM, Dave Spano &lt;dspano@optogenics.=
com (mailto:dspano@optogenics.com)&gt; wrote:=20
&gt; &gt; Lol. I'm totally fine with that. My glance images pool isn't =
used too often. I'm going to give that a try today and see what happens=
=2E=20
&gt; &gt;=20
&gt; &gt; I'm still crossing my fingers, but since I added log max rece=
nt=3D10000 to ceph.conf, I've been okay despite the improper pg_num, an=
d a lot of scrubbing/deep scrubbing yesterday.=20
&gt; &gt;=20
&gt; &gt; Dave Spano=20
&gt; &gt;=20
&gt; &gt;=20
&gt; &gt;=20
&gt; &gt;=20
&gt; &gt; ----- Original Message -----=20
&gt; &gt;=20
&gt; &gt; From: "Greg Farnum" &lt;greg@inktank.com (mailto:greg@inktank=
=2Ecom)&gt;=20
&gt; &gt; To: "Dave Spano" &lt;dspano@optogenics.com (mailto:dspano@opt=
ogenics.com)&gt;=20
&gt; &gt; Cc: "ceph-devel" &lt;ceph-devel@vger.kernel.org (mailto:ceph-=
devel@vger.kernel.org)&gt;, "Sage Weil" &lt;sage@inktank.com (mailto:sa=
ge@inktank.com)&gt;, "Wido den Hollander" &lt;wido@42on.com (mailto:wid=
o@42on.com)&gt;, "Sylvain Munaut" &lt;s.munaut@whatever-company.com (ma=
ilto:s.munaut@whatever-company.com)&gt;, "Samuel Just" &lt;sam.just@ink=
tank.com (mailto:sam.just@inktank.com)&gt;, "Vladislav Gorbunov" &lt;va=
dikgo@gmail.com (mailto:vadikgo@gmail.com)&gt;, "S=C3=A9bastien Han" &l=
t;han.sebastien@gmail.com (mailto:han.sebastien@gmail.com)&gt;=20
&gt; &gt; Sent: Tuesday, March 12, 2013 5:37:37 PM=20
&gt; &gt; Subject: Re: OSD memory leaks?=20
&gt; &gt;=20
&gt; &gt; Yeah. There's not anything intelligent about that cppool mech=
anism. :)=20
&gt; &gt; -Greg=20
&gt; &gt;=20
&gt; &gt; On Tuesday, March 12, 2013 at 2:15 PM, Dave Spano wrote:=20
&gt; &gt;=20
&gt; &gt; &gt; I'd rather shut the cloud down and copy the pool to a ne=
w one than take any chances of corruption by using an experimental feat=
ure. My guess is that there cannot be any i/o to the pool while copying=
, otherwise you'll lose the changes that are happening during the copy,=
 correct?=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; Dave Spano=20
&gt; &gt; &gt; Optogenics=20
&gt; &gt; &gt; Systems Administrator=20
&gt; &gt; &gt;=20
&gt; &gt; &gt;=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; ----- Original Message -----=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; From: "Greg Farnum" &lt;greg@inktank.com (mailto:greg@in=
ktank.com)&gt;=20
&gt; &gt; &gt; To: "S=C3=A9bastien Han" &lt;han.sebastien@gmail.com (ma=
ilto:han.sebastien@gmail.com)&gt;=20
&gt; &gt; &gt; Cc: "Dave Spano" &lt;dspano@optogenics.com (mailto:dspan=
o@optogenics.com)&gt;, "ceph-devel" &lt;ceph-devel@vger.kernel.org (mai=
lto:ceph-devel@vger.kernel.org)&gt;, "Sage Weil" &lt;sage@inktank.com (=
mailto:sage@inktank.com)&gt;, "Wido den Hollander" &lt;wido@42on.com (m=
ailto:wido@42on.com)&gt;, "Sylvain Munaut" &lt;s.munaut@whatever-compan=
y.com (mailto:s.munaut@whatever-company.com)&gt;, "Samuel Just" &lt;sam=
=2Ejust@inktank.com (mailto:sam.just@inktank.com)&gt;, "Vladislav Gorbu=
nov" &lt;vadikgo@gmail.com (mailto:vadikgo@gmail.com)&gt;=20
&gt; &gt; &gt; Sent: Tuesday, March 12, 2013 4:20:13 PM=20
&gt; &gt; &gt; Subject: Re: OSD memory leaks?=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; On Tuesday, March 12, 2013 at 1:10 PM, S=C3=A9bastien Ha=
n wrote:=20
&gt; &gt; &gt; &gt; Well to avoid un necessary data movement, there is =
also an=20
&gt; &gt; &gt; &gt; _experimental_ feature to change on fly the number =
of PGs in a pool.=20
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; ceph osd pool set &lt;poolname&gt; pg_num &lt;numpg=
s&gt; --allow-experimental-feature=20
&gt; &gt; &gt; Don't do that. We've got a set of 3 patches which fix bu=
gs we know about that aren't in bobtail yet, and I'm sure there's more =
we aren't aware of=E2=80=A6=20
&gt; &gt; &gt; -Greg=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; Software Engineer #42 @ http://inktank.com | http://ceph=
=2Ecom=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; Cheers!=20
&gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; Regards,=20
&gt; &gt; &gt; &gt; S=C3=A9bastien Han.=20
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; On Tue, Mar 12, 2013 at 7:09 PM, Dave Spano &lt;dsp=
ano@optogenics.com (mailto:dspano@optogenics.com)&gt; wrote:=20
&gt; &gt; &gt; &gt; &gt; Disregard my previous question. I found my ans=
wer in the post below. Absolutely brilliant! I thought I was screwed!=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; http://permalink.gmane.org/gmane.comp.file-sys=
tems.ceph.devel/8924=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; Dave Spano=20
&gt; &gt; &gt; &gt; &gt; Optogenics=20
&gt; &gt; &gt; &gt; &gt; Systems Administrator=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; ----- Original Message -----=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; From: "Dave Spano" &lt;dspano@optogenics.com (=
mailto:dspano@optogenics.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; To: "S=C3=A9bastien Han" &lt;han.sebastien@gma=
il.com (mailto:han.sebastien@gmail.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; Cc: "Sage Weil" &lt;sage@inktank.com (mailto:s=
age@inktank.com)&gt;, "Wido den Hollander" &lt;wido@42on.com (mailto:wi=
do@42on.com)&gt;, "Gregory Farnum" &lt;greg@inktank.com (mailto:greg@in=
ktank.com)&gt;, "Sylvain Munaut" &lt;s.munaut@whatever-company.com (mai=
lto:s.munaut@whatever-company.com)&gt;, "ceph-devel" &lt;ceph-devel@vge=
r.kernel.org (mailto:ceph-devel@vger.kernel.org)&gt;, "Samuel Just" &lt=
;sam.just@inktank.com (mailto:sam.just@inktank.com)&gt;, "Vladislav Gor=
bunov" &lt;vadikgo@gmail.com (mailto:vadikgo@gmail.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; Sent: Tuesday, March 12, 2013 1:41:21 PM=20
&gt; &gt; &gt; &gt; &gt; Subject: Re: OSD memory leaks?=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; If one were stupid enough to have their pg_num=
 and pgp_num set to 8 on two of their pools, how could you fix that?=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; Dave Spano=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; ----- Original Message -----=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; From: "S=C3=A9bastien Han" &lt;han.sebastien@g=
mail.com (mailto:han.sebastien@gmail.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; To: "Vladislav Gorbunov" &lt;vadikgo@gmail.com=
 (mailto:vadikgo@gmail.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; Cc: "Sage Weil" &lt;sage@inktank.com (mailto:s=
age@inktank.com)&gt;, "Wido den Hollander" &lt;wido@42on.com (mailto:wi=
do@42on.com)&gt;, "Gregory Farnum" &lt;greg@inktank.com (mailto:greg@in=
ktank.com)&gt;, "Sylvain Munaut" &lt;s.munaut@whatever-company.com (mai=
lto:s.munaut@whatever-company.com)&gt;, "Dave Spano" &lt;dspano@optogen=
ics.com (mailto:dspano@optogenics.com)&gt;, "ceph-devel" &lt;ceph-devel=
@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)&gt;, "Samuel Just"=
 &lt;sam.just@inktank.com (mailto:sam.just@inktank.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; Sent: Tuesday, March 12, 2013 9:43:44 AM=20
&gt; &gt; &gt; &gt; &gt; Subject: Re: OSD memory leaks?=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; Sorry, i mean pg_num and pgp_num on all p=
ools. Shown by the "ceph osd=20
&gt; &gt; &gt; &gt; &gt; &gt; dump | grep 'rep size'"=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; Well it's still 450 each...=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; The default pg_num value 8 is NOT suitabl=
e for big cluster.=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; Thanks I know, I'm not new with Ceph. What's y=
our point here? I=20
&gt; &gt; &gt; &gt; &gt; already said that pg_num was 450...=20
&gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; Regards,=20
&gt; &gt; &gt; &gt; &gt; S=C3=A9bastien Han.=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gor=
bunov &lt;vadikgo@gmail.com (mailto:vadikgo@gmail.com)&gt; wrote:=20
&gt; &gt; &gt; &gt; &gt; &gt; Sorry, i mean pg_num and pgp_num on all p=
ools. Shown by the "ceph osd=20
&gt; &gt; &gt; &gt; &gt; &gt; dump | grep 'rep size'"=20
&gt; &gt; &gt; &gt; &gt; &gt; The default pg_num value 8 is NOT suitabl=
e for big cluster.=20
&gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; 2013/3/13 S=C3=A9bastien Han &lt;han.seba=
stien@gmail.com (mailto:han.sebastien@gmail.com)&gt;:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Replica count has been set to 2.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Why?=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Regards,=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; S=C3=A9bastien Han.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, Mar 12, 2013 at 12:45 PM, Vl=
adislav Gorbunov &lt;vadikgo@gmail.com (mailto:vadikgo@gmail.com)&gt; w=
rote:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; FYI I'm using 450 pgs for =
my pools.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Please, can you show the number=
 of object replicas?=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; ceph osd dump | grep 'rep size'=
=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Vlad Gorbunov=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; 2013/3/5 S=C3=A9bastien Han &lt=
;han.sebastien@gmail.com (mailto:han.sebastien@gmail.com)&gt;:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; FYI I'm using 450 pgs for =
my pools.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Regards,=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; S=C3=A9bastien Han.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Fri, Mar 1, 2013 at 8:1=
0 PM, Sage Weil &lt;sage@inktank.com (mailto:sage@inktank.com)&gt; wrot=
e:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Fri, 1 Mar 2013, W=
ido den Hollander wrote:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On 02/23/2013 01=
:44 AM, Sage Weil wrote:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Fri, 22 =
=46eb 2013, S?bastien Han wrote:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hi all=
,=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I fina=
lly got a core dump.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I did =
it with a kill -SEGV on the OSD process.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; https:=
//www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0-20100-13615390=
08=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hope w=
e will get something out of it :-).=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; AHA! We hav=
e a theory. The pg log isnt trimmed during scrub (because teh=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; old scrub c=
ode required that), but the new (deep) scrub can take a very=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; long time, =
which means the pg log will eat ram in the meantime..=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; especially =
under high iops.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Does the number =
of PGs influence the memory leak? So my theory is that when=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; you have a high =
number of PGs with a low number of objects per PG you don't=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; see the memory l=
eak.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I saw the memory=
 leak on a RBD system where a pool had just 8 PGs, but after=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; going to 1024 PG=
s in a new pool it seemed to be resolved.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I've asked someb=
ody else to try your patch since he's still seeing it on his=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; systems. Hopeful=
ly that gives us some results.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; The PGs were active+c=
lean when you saw the leak? There is a problem (that=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; we just fixed in mast=
er) where pg logs aren't trimmed for degraded PGs.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; sage=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Wido=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Can you try=
 wip-osd-log-trim (which is bobtail + a simple patch) and see=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; if that see=
ms to work? Note that that patch shouldn't be run in a mixed=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; argonaut+bo=
btail cluster, since it isn't properly checking if the scrub is=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; class or ch=
unky/deep.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks!=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; sage=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Regard=
s,=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; S?bast=
ien Han.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Fri=
, Jan 11, 2013 at 7:13 PM, Gregory Farnum &lt;greg@inktank.com (mailto:=
greg@inktank.com)&gt; wrote:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; O=
n Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han &lt;han.sebastien@gmail.c=
om (mailto:han.sebastien@gmail.com)&gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; w=
rote:=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; Is osd.1 using the heap profiler as well? Keep in mind that ac=
tive=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; use=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; of the memory profiler will itself cause memory usage to incre=
ase ?=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; this sounds a bit like that to me since it's staying stable at=
 a=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; large=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; but finite portion of total memory.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; Well, the memory consumption was already high before the profiler w=
as=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; started. So yes with the memory profiler enable an OSD might consum=
e=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; more memory but this doesn't cause the memory leaks.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; M=
y concern is that maybe you saw a leak but when you restarted with=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; t=
he memory profiling you lost whatever conditions caused it.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; Any ideas? Nothing to say about my scrumbing theory?=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I=
 like it, but Sam indicates that without some heap dumps which=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; c=
apture the actual leak then scrub is too large to effectively code=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; r=
eview for leaks. :(=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=
Greg=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; To uns=
ubscribe from this list: send the line "unsubscribe ceph-devel" in=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the bo=
dy of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.ker=
nel.org)=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; More m=
ajordomo info at http://vger.kernel.org/majordomo-info.html=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; To unsubscr=
ibe from this list: send the line "unsubscribe ceph-devel" in=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the body of=
 a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.o=
rg)=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; More majord=
omo info at http://vger.kernel.org/majordomo-info.html=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Wido den Holland=
er=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; 42on B.V.=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Phone: +31 (0)20=
 700 9902=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Skype: contact42=
on=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; To unsubscribe from this l=
ist: send the line "unsubscribe ceph-devel" in=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the body of a message to m=
ajordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; More majordomo info at htt=
p://vger.kernel.org/majordomo-info.html=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; --=20
&gt; &gt; &gt; &gt; &gt; To unsubscribe from this list: send the line "=
unsubscribe ceph-devel" in=20
&gt; &gt; &gt; &gt; &gt; the body of a message to majordomo@vger.kernel=
=2Eorg (mailto:majordomo@vger.kernel.org)=20
&gt; &gt; &gt; &gt; &gt; More majordomo info at http://vger.kernel.org/=
majordomo-info.html=20
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt;=20
&gt; &gt;=20
&gt;=20




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
