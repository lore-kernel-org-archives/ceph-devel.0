From: Greg Farnum <greg@inktank.com>
Subject: Re: OSD memory leaks?
Date: Tue, 12 Mar 2013 13:20:13 -0700
Message-ID: <464F911CDB4D4E4E97D3D783191007DC@inktank.com>
References: <7332688.5.1363110084349.JavaMail.dspano@it1>
 <2104584728.1783.1363111761558.JavaMail.root@optogenics.com>
 <CAOLwVUkBeu+=4XHv8NV+xRm7CaEvByO-uuo5eeZ+iHUg1XQ1sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:40819 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933483Ab3CLUUR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 16:20:17 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so234023pbc.39
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 13:20:17 -0700 (PDT)
In-Reply-To: <CAOLwVUkBeu+=4XHv8NV+xRm7CaEvByO-uuo5eeZ+iHUg1XQ1sw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

On Tuesday, March 12, 2013 at 1:10 PM, S=C3=A9bastien Han wrote:
> Well to avoid un necessary data movement, there is also an
> _experimental_ feature to change on fly the number of PGs in a pool.
> =20
> ceph osd pool set <poolname> pg_num <numpgs> --allow-experimental-fea=
ture
Don't do that. We've got a set of 3 patches which fix bugs we know abou=
t that aren't in bobtail yet, and I'm sure there's more we aren't aware=
 of=E2=80=A6
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com =20

> =20
> Cheers!
> --
> Regards,
> S=C3=A9bastien Han.
> =20
> =20
> On Tue, Mar 12, 2013 at 7:09 PM, Dave Spano <dspano@optogenics.com (m=
ailto:dspano@optogenics.com)> wrote:
> > Disregard my previous question. I found my answer in the post below=
=2E Absolutely brilliant! I thought I was screwed!
> > =20
> > http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/8924
> > =20
> > Dave Spano
> > Optogenics
> > Systems Administrator
> > =20
> > =20
> > =20
> > ----- Original Message -----
> > =20
> > From: "Dave Spano" <dspano@optogenics.com (mailto:dspano@optogenics=
=2Ecom)>
> > To: "S=C3=A9bastien Han" <han.sebastien@gmail.com (mailto:han.sebas=
tien@gmail.com)>
> > Cc: "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, "Wido=
 den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Gregory Farnum=
" <greg@inktank.com (mailto:greg@inktank.com)>, "Sylvain Munaut" <s.mun=
aut@whatever-company.com (mailto:s.munaut@whatever-company.com)>, "ceph=
-devel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)=
>, "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.com)>, =
"Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmail.com)>
> > Sent: Tuesday, March 12, 2013 1:41:21 PM
> > Subject: Re: OSD memory leaks?
> > =20
> > =20
> > If one were stupid enough to have their pg_num and pgp_num set to 8=
 on two of their pools, how could you fix that?
> > =20
> > =20
> > Dave Spano
> > =20
> > =20
> > =20
> > ----- Original Message -----
> > =20
> > From: "S=C3=A9bastien Han" <han.sebastien@gmail.com (mailto:han.seb=
astien@gmail.com)>
> > To: "Vladislav Gorbunov" <vadikgo@gmail.com (mailto:vadikgo@gmail.c=
om)>
> > Cc: "Sage Weil" <sage@inktank.com (mailto:sage@inktank.com)>, "Wido=
 den Hollander" <wido@42on.com (mailto:wido@42on.com)>, "Gregory Farnum=
" <greg@inktank.com (mailto:greg@inktank.com)>, "Sylvain Munaut" <s.mun=
aut@whatever-company.com (mailto:s.munaut@whatever-company.com)>, "Dave=
 Spano" <dspano@optogenics.com (mailto:dspano@optogenics.com)>, "ceph-d=
evel" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)>,=
 "Samuel Just" <sam.just@inktank.com (mailto:sam.just@inktank.com)>
> > Sent: Tuesday, March 12, 2013 9:43:44 AM
> > Subject: Re: OSD memory leaks?
> > =20
> > > Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph=
 osd
> > > dump | grep 'rep size'"
> > =20
> > =20
> > =20
> > Well it's still 450 each...
> > =20
> > > The default pg_num value 8 is NOT suitable for big cluster.
> > =20
> > Thanks I know, I'm not new with Ceph. What's your point here? I
> > already said that pg_num was 450...
> > --
> > Regards,
> > S=C3=A9bastien Han.
> > =20
> > =20
> > On Tue, Mar 12, 2013 at 2:00 PM, Vladislav Gorbunov <vadikgo@gmail.=
com (mailto:vadikgo@gmail.com)> wrote:
> > > Sorry, i mean pg_num and pgp_num on all pools. Shown by the "ceph=
 osd
> > > dump | grep 'rep size'"
> > > The default pg_num value 8 is NOT suitable for big cluster.
> > > =20
> > > 2013/3/13 S=C3=A9bastien Han <han.sebastien@gmail.com (mailto:han=
=2Esebastien@gmail.com)>:
> > > > Replica count has been set to 2.
> > > > =20
> > > > Why?
> > > > --
> > > > Regards,
> > > > S=C3=A9bastien Han.
> > > > =20
> > > > =20
> > > > On Tue, Mar 12, 2013 at 12:45 PM, Vladislav Gorbunov <vadikgo@g=
mail.com (mailto:vadikgo@gmail.com)> wrote:
> > > > > > FYI I'm using 450 pgs for my pools.
> > > > > =20
> > > > > =20
> > > > > Please, can you show the number of object replicas?
> > > > > =20
> > > > > ceph osd dump | grep 'rep size'
> > > > > =20
> > > > > Vlad Gorbunov
> > > > > =20
> > > > > 2013/3/5 S=C3=A9bastien Han <han.sebastien@gmail.com (mailto:=
han.sebastien@gmail.com)>:
> > > > > > FYI I'm using 450 pgs for my pools.
> > > > > > =20
> > > > > > --
> > > > > > Regards,
> > > > > > S=C3=A9bastien Han.
> > > > > > =20
> > > > > > =20
> > > > > > On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.com=
 (mailto:sage@inktank.com)> wrote:
> > > > > > > =20
> > > > > > > On Fri, 1 Mar 2013, Wido den Hollander wrote:
> > > > > > > > On 02/23/2013 01:44 AM, Sage Weil wrote:
> > > > > > > > > On Fri, 22 Feb 2013, S?bastien Han wrote:
> > > > > > > > > > Hi all,
> > > > > > > > > > =20
> > > > > > > > > > I finally got a core dump.
> > > > > > > > > > =20
> > > > > > > > > > I did it with a kill -SEGV on the OSD process.
> > > > > > > > > > =20
> > > > > > > > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph=
-osd-11-0-0-20100-1361539008
> > > > > > > > > > =20
> > > > > > > > > > Hope we will get something out of it :-).
> > > > > > > > > =20
> > > > > > > > > AHA! We have a theory. The pg log isnt trimmed during=
 scrub (because teh
> > > > > > > > > old scrub code required that), but the new (deep) scr=
ub can take a very
> > > > > > > > > long time, which means the pg log will eat ram in the=
 meantime..
> > > > > > > > > especially under high iops.
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > Does the number of PGs influence the memory leak? So my=
 theory is that when
> > > > > > > > you have a high number of PGs with a low number of obje=
cts per PG you don't
> > > > > > > > see the memory leak.
> > > > > > > > =20
> > > > > > > > I saw the memory leak on a RBD system where a pool had =
just 8 PGs, but after
> > > > > > > > going to 1024 PGs in a new pool it seemed to be resolve=
d.
> > > > > > > > =20
> > > > > > > > I've asked somebody else to try your patch since he's s=
till seeing it on his
> > > > > > > > systems. Hopefully that gives us some results.
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > The PGs were active+clean when you saw the leak? There is=
 a problem (that
> > > > > > > we just fixed in master) where pg logs aren't trimmed for=
 degraded PGs.
> > > > > > > =20
> > > > > > > sage
> > > > > > > =20
> > > > > > > > =20
> > > > > > > > Wido
> > > > > > > > =20
> > > > > > > > > Can you try wip-osd-log-trim (which is bobtail + a si=
mple patch) and see
> > > > > > > > > if that seems to work? Note that that patch shouldn't=
 be run in a mixed
> > > > > > > > > argonaut+bobtail cluster, since it isn't properly che=
cking if the scrub is
> > > > > > > > > class or chunky/deep.
> > > > > > > > > =20
> > > > > > > > > Thanks!
> > > > > > > > > sage
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > > --
> > > > > > > > > > Regards,
> > > > > > > > > > S?bastien Han.
> > > > > > > > > > =20
> > > > > > > > > > =20
> > > > > > > > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <gr=
eg@inktank.com (mailto:greg@inktank.com)> wrote:
> > > > > > > > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <h=
an.sebastien@gmail.com (mailto:han.sebastien@gmail.com)>
> > > > > > > > > > > wrote:
> > > > > > > > > > > > > Is osd.1 using the heap profiler as well? Kee=
p in mind that active
> > > > > > > > > > > > > use
> > > > > > > > > > > > > of the memory profiler will itself cause memo=
ry usage to increase ?
> > > > > > > > > > > > > this sounds a bit like that to me since it's =
staying stable at a
> > > > > > > > > > > > > large
> > > > > > > > > > > > > but finite portion of total memory.
> > > > > > > > > > > > =20
> > > > > > > > > > > > =20
> > > > > > > > > > > > =20
> > > > > > > > > > > > Well, the memory consumption was already high b=
efore the profiler was
> > > > > > > > > > > > started. So yes with the memory profiler enable=
 an OSD might consume
> > > > > > > > > > > > more memory but this doesn't cause the memory l=
eaks.
> > > > > > > > > > > =20
> > > > > > > > > > > =20
> > > > > > > > > > > =20
> > > > > > > > > > > My concern is that maybe you saw a leak but when =
you restarted with
> > > > > > > > > > > the memory profiling you lost whatever conditions=
 caused it.
> > > > > > > > > > > =20
> > > > > > > > > > > > Any ideas? Nothing to say about my scrumbing th=
eory?
> > > > > > > > > > > I like it, but Sam indicates that without some he=
ap dumps which
> > > > > > > > > > > capture the actual leak then scrub is too large t=
o effectively code
> > > > > > > > > > > review for leaks. :(
> > > > > > > > > > > -Greg
> > > > > > > > > > =20
> > > > > > > > > > =20
> > > > > > > > > > --
> > > > > > > > > > To unsubscribe from this list: send the line "unsub=
scribe ceph-devel" in
> > > > > > > > > > the body of a message to majordomo@vger.kernel.org =
(mailto:majordomo@vger.kernel.org)
> > > > > > > > > > More majordomo info at http://vger.kernel.org/major=
domo-info.html
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > --
> > > > > > > > > To unsubscribe from this list: send the line "unsubsc=
ribe ceph-devel" in
> > > > > > > > > the body of a message to majordomo@vger.kernel.org (m=
ailto:majordomo@vger.kernel.org)
> > > > > > > > > More majordomo info at http://vger.kernel.org/majordo=
mo-info.html
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > --
> > > > > > > > Wido den Hollander
> > > > > > > > 42on B.V.
> > > > > > > > =20
> > > > > > > > Phone: +31 (0)20 700 9902
> > > > > > > > Skype: contact42on
> > > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe c=
eph-devel" in
> > > > > > the body of a message to majordomo@vger.kernel.org (mailto:=
majordomo@vger.kernel.org)
> > > > > > More majordomo info at http://vger.kernel.org/majordomo-inf=
o.html
> > > > > =20
> > > > =20
> > > =20
> > =20
> > =20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordom=
o@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> =20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
