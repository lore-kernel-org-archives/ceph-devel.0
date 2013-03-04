From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Mon, 4 Mar 2013 18:11:22 +0100
Message-ID: <CAOLwVUnVJABHAqaSechu5=4kDhft4wf7LNQVddp-J+miuu=qiQ@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
 <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
 <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com>
 <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com>
 <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com>
 <alpine.DEB.2.00.1302221642570.5703@cobra.newdream.net> <5130CE65.7050606@42on.com>
 <alpine.DEB.2.00.1303011110120.22593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49323 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758118Ab3CDRLm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 12:11:42 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so9514764oag.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 09:11:42 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1303011110120.22593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

=46YI I'm using 450 pgs for my pools.

--
Regards,
S=E9bastien Han.


On Fri, Mar 1, 2013 at 8:10 PM, Sage Weil <sage@inktank.com> wrote:
>
> On Fri, 1 Mar 2013, Wido den Hollander wrote:
> > On 02/23/2013 01:44 AM, Sage Weil wrote:
> > > On Fri, 22 Feb 2013, S?bastien Han wrote:
> > > > Hi all,
> > > >
> > > > I finally got a core dump.
> > > >
> > > > I did it with a kill -SEGV on the OSD process.
> > > >
> > > > https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0-=
20100-1361539008
> > > >
> > > > Hope we will get something out of it :-).
> > >
> > > AHA!  We have a theory.  The pg log isnt trimmed during scrub (be=
cause teh
> > > old scrub code required that), but the new (deep) scrub can take =
a very
> > > long time, which means the pg log will eat ram in the meantime..
> > > especially under high iops.
> > >
> >
> > Does the number of PGs influence the memory leak? So my theory is t=
hat when
> > you have a high number of PGs with a low number of objects per PG y=
ou don't
> > see the memory leak.
> >
> > I saw the memory leak on a RBD system where a pool had just 8 PGs, =
but after
> > going to 1024 PGs in a new pool it seemed to be resolved.
> >
> > I've asked somebody else to try your patch since he's still seeing =
it on his
> > systems. Hopefully that gives us some results.
>
> The PGs were active+clean when you saw the leak?  There is a problem =
(that
> we just fixed in master) where pg logs aren't trimmed for degraded PG=
s.
>
> sage
>
> >
> > Wido
> >
> > > Can you try wip-osd-log-trim (which is bobtail + a simple patch) =
and see
> > > if that seems to work?  Note that that patch shouldn't be run in =
a mixed
> > > argonaut+bobtail cluster, since it isn't properly checking if the=
 scrub is
> > > class or chunky/deep.
> > >
> > > Thanks!
> > > sage
> > >
> > >
> > >   > --
> > > > Regards,
> > > > S?bastien Han.
> > > >
> > > >
> > > > On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inktank.c=
om> wrote:
> > > > > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebastien=
@gmail.com>
> > > > > wrote:
> > > > > > > Is osd.1 using the heap profiler as well? Keep in mind th=
at active
> > > > > > > use
> > > > > > > of the memory profiler will itself cause memory usage to =
increase ?
> > > > > > > this sounds a bit like that to me since it's staying stab=
le at a
> > > > > > > large
> > > > > > > but finite portion of total memory.
> > > > > >
> > > > > > Well, the memory consumption was already high before the pr=
ofiler was
> > > > > > started. So yes with the memory profiler enable an OSD migh=
t consume
> > > > > > more memory but this doesn't cause the memory leaks.
> > > > >
> > > > > My concern is that maybe you saw a leak but when you restarte=
d with
> > > > > the memory profiling you lost whatever conditions caused it.
> > > > >
> > > > > > Any ideas? Nothing to say about my scrumbing theory?
> > > > > I like it, but Sam indicates that without some heap dumps whi=
ch
> > > > > capture the actual leak then scrub is too large to effectivel=
y code
> > > > > review for leaks. :(
> > > > > -Greg
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> > > >
> > > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > >
> >
> >
> > --
> > Wido den Hollander
> > 42on B.V.
> >
> > Phone: +31 (0)20 700 9902
> > Skype: contact42on
> >
> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
