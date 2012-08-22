From: Sage Weil <sage@inktank.com>
Subject: Re: wip-crush
Date: Wed, 22 Aug 2012 10:48:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208221047460.29719@cobra.newdream.net>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net> <5034F0B4.3060107@hastexo.com> <C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov> <alpine.DEB.2.00.1208220929390.32470@cobra.newdream.net>
 <CAPYLRzjmcOuSkxG1iO8GqEZPeLchKwKP94KizB7mXWzAU2a57w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-204634818-1345657734=:29719"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48714 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab2HVRsz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 13:48:55 -0400
In-Reply-To: <CAPYLRzjmcOuSkxG1iO8GqEZPeLchKwKP94KizB7mXWzAU2a57w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-204634818-1345657734=:29719
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Aug 2012, Gregory Farnum wrote:
> On Wed, Aug 22, 2012 at 9:33 AM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 22 Aug 2012, Atchley, Scott wrote:
> >> On Aug 22, 2012, at 10:46 AM, Florian Haas wrote:
> >>
> >> > On 08/22/2012 03:10 AM, Sage Weil wrote:
> >> >> I pushed a branch that changes some of the crush terminology.  In=
stead of
> >> >> having a crush type called "pool" that requires you to say things=
 like
> >> >> "pool=3Ddefault" in the "ceph osd crush set ..." command, it uses=
 "root"
> >> >> instead.  That hopefully reinforces that it is a tree/hierarchy.
> >> >>
> >> >> There is also a patch that changes "bucket" to "node" throughout,=
 since
> >> >> bucket is a term also used by radosgw.
> >> >>
> >> >> Thoughts?  I think the main pain in making this transition is tha=
t old
> >> >> clusters have maps that have a type 'pool' and new ones won't, an=
d the
> >> >> docs will need to walk people through both...
> >> >
> >> > "pool" in a crushmap being completely unrelated to a RADOS pool is
> >> > something that I've heard customers/users report as confusing, as =
well.
> >> > So changing that is probably a good thing. Naming it "root" is pro=
bably
> >> > a good choice as well, as it happens to match
> >> > http://ceph.com/wiki/Custom_data_placement_with_CRUSH.
> >> >
> >> > As for changing "bucket" to node... a "node" is normally simply a
> >> > physical server (at least in HA terminology, which many potential =
Ceph
> >> > users will be familiar with), and CRUSH uses "host" for that. So t=
hat's
> >> > another recipe for confusion. How about using something super-gene=
ric,
> >> > like "element" or "item"?
> >> >
> >> > Cheers,
> >> > Florian
> >>
> >> My guess is that he is trying to use data structure tree nomenclatur=
e
> >> (root, node, leaf). I agree that node is an overloaded term (as is
> >> pool).
> >
> > Yeah...
> >
> >> As for an alternative to bucket which indicates the item is a
> >> collection, what about subtree or branch?
> >
> > I think fixing the overloading of 'pool' in the default crush map is =
the
> > biggest pain point.  I can live with crush 'buckets' staying the same=
 (esp
> > since that's what the papers and code use pervasively) if we can't co=
me up
> > with a better option.
>=20
> I'm definitely most interested in replacing "pool", and "root" works
> for that in my mind. RGW buckets live at a sufficiently different
> level that I think people are unlikely to be confused ?=A0and "bucket"
> is actually a good name for what they are (I'm open to better ones,
> but I don't think that "node" qualifies).

Yeah, sounds good to me.

> > On the pool part, though, the challenge is how to transition.  Existi=
ng
> > clusters have maps that use 'pool', and new clusters will use 'root' =
(or
> > whatever).  Some options:
> >
> >  - document both.  this kills much of the benefit of switching, but i=
s
> >    probably inevitable since people will be running different version=
s.
> >  - make the upgrade process transparently rename the type.  this lets
> >    all the tools use the new names.
> >  - make the tools silently translate old names to new names.  this is
> >    kludgey in that it makes the code make assumptions about the names=
 of
> >    the data it is working with, but would cover everyone except those=
 who
> >    created their own crush maps from scratch.
> >  - ?
>
> I would go with option two, and only document the new options ?=A0I
> wouldn't be surprised if the number of people who had changed those
> was zero. Anybody who has done so can certainly be counted on to pay
> enough attention that a line note "changed CRUSH names (see here if
> you customized your map)" would be sufficient, right?

Yeah.  The one wrinkle is that people running old code (e.g., argonaut)=20
reading the latest docs will see commands that don't quite work.

At some point we need to fork the docs for each stable release... maybe=20
now is the time to do that.

sage
--557981400-204634818-1345657734=:29719--
