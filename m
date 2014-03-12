From: Sage Weil <sage@inktank.com>
Subject: Re: Erasure code properties in OSDMap
Date: Wed, 12 Mar 2014 08:16:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403120804310.316@cobra.newdream.net>
References: <531C5AD5.9060109@cloudwatt.com> <CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com> <531F17B0.4080506@cloudwatt.com> <CAGd4Wr1-effipjF4zCvT15YtC-XMpNvepeA+2L2EYPL5nBn=Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1932441023-1394637017=:316"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53707 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664AbaCLPQo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 11:16:44 -0400
In-Reply-To: <CAGd4Wr1-effipjF4zCvT15YtC-XMpNvepeA+2L2EYPL5nBn=Wg@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1403120811000.316@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>
Cc: Loic Dachary <loic.dachary@cloudwatt.com>, Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1932441023-1394637017=:316
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-ID: <alpine.DEB.2.00.1403120811001.316@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2014, John Spray wrote:
> I am sure all of that will work, but it doesn't explain why these
> properties must be stored and named separately to crush rulesets.  To
> flesh this out one also needs "get" and "list" operations for the sets
> of properties, which feels like overkill if there is an existing place
> we could be storing these things.  The reason I'm taking such an
> interest in what may seem something minor is that once this has been
> added, we will be stuck with it for some time once external tools
> start depending on the interface.
>=20
> The ruleset-based approach doesn't have to be more complicated for CLI
> users, we would essentially replace any "myproperties" above with a
> ruleset name instead.
>=20
> osd pool create mypool <pgnum> <pgpnum> <ruleset>
> osd set ruleset-properties <ruleset> <key>=3D<val> [<key>=3D<val>...]

The order would have to switch, like so:

 osd set ruleset-properties <ruleset> <key>=3D<val> [<key>=3D<val>...]
 osd pool create mypool <pgnum> <pgpnum> <ruleset>

because the parameters need to be specified with the pool to determine=20
even basic stuff like the size.

The problem with this is that the erasure properties are generally=20
immutable, but it is important to retain the ability to change rules for=20
an existing pool.  Would the 'set ruleset' command fail if the properties=
=20
don't match?

Actually, there are some cases where an expert user ought to be able to=20
adjust the properties (swtiching between byte-compatible plugins, for=20
instance), but other values like m and k obviously are fixed.  So I think=
=20
there needs to be an 'expert' or 'force' mode that lets you shoot yoursel=
f=20
in the foot, but I don't want that as part of the normal command flow if=20
possible.

That said, I can imagine a convenience command that creates a ruleset wit=
h=20
the given set of properties in one step (probably matching and reusing an=
=20
existing set of properties if the exist).

It's a more complicated interface, yes, but it still feels like the right=
=20
set of abstractions. :/

sage

>=20
> The simple default cases of "pool create mypool <pgnum> <pgpnum>
> erasure" could be handled by making sure there exist default rulesets
> called "erasure" and "replicated" rather than having these be magic
> words to the commands that cause ruleset creation.  Rulesets currently
> just have numbers instead of names, but it would be simpler to add
> names to rulesets than to introduce a whole new type of object to the
> interface.
>=20
> John
>=20
> On Tue, Mar 11, 2014 at 2:03 PM, Loic Dachary
> <loic.dachary@cloudwatt.com> wrote:
> > On 11/03/2014 13:21, John Spray wrote:
> >> From a high level view, what is the logical difference between the
> >> crush ruleset and the properties object?  I'm thinking about how thi=
s
> >> is exposed to users and tools, and it seems like both would be defin=
ed
> >> as "the settings about data placement and encoding".  I certainly
> >> understand the separation internally, I am just concerned about maki=
ng
> >> the interface we expose upwards more complicated by adding a new typ=
e
> >> of object.
> >>
> >> Is there really a need for a new type of properties object, instead =
of
> >> storing these properties under the existing ruleset ID?
> > These properties are used to configure the new feature that was intro=
duced in Firefly : erasure coded pools. From a user point of view the sim=
plest would be to
> >
> > ceph osd pool create mypool erasure
> >
> > and rely on the fact that a default ruleset will be created using the=
 default erasure code plugin with the default parameters.
> >
> > If the sysadmin wants to tweak the K+M factors (s)he could:
> >
> > ceph osd set properties myproperties k=3D10 m=3D4
> >
> > and then
> >
> > ceph osd pool create mypool erasure myproperties
> >
> > which would implicitly ask the default erasure code plugin to create =
a ruleset named "mypool-ruleset" after configuring it with myproperties.
> >
> > If the sysadmin wants to share rulesets between pools instead of rely=
ing on their implicit creation, (s)he could
> >
> > ceph osd create-serasure myruleset myproperties
> >
> > and then ceph osd set crush_ruleset as per usual. And if (s)he really=
 wants fine tuning, manually adding the ruleset is also possible.
> >
> > I feel confortable explaining this but I'm probably much too familiar=
 with the subject to be a good judge of what makes sense to someone new o=
r not ;-)
> >
> > Cheers
> >
> >>
> >> John
> >>
> >>
> >> On Sun, Mar 9, 2014 at 12:13 PM, Loic Dachary
> >> <loic.dachary@cloudwatt.com> wrote:
> >>> Hi Sage & Sam,
> >>>
> >>> I quickly sketched the replacement of the pg_pool_t::properties map=
 with a OSDMap::properties list of maps at https://github.com/dachary/cep=
h/commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how I see=
 it at http://tracker.ceph.com/issues/7662#note-2
> >>>
> >>> It indeed makes things simpler, more consistent and easier to expla=
in. I can provide an implementation this week if this seems reasonable to=
 you.
> >>>
> >>> Cheers
> >>>
> >>> --
> >>> Lo=C4=8Fc Dachary, Senior Developer
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> > --
> > Lo=C3=AFc Dachary, Senior Developer
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1932441023-1394637017=:316--
