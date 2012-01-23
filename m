From: Sage Weil <sage@newdream.net>
Subject: Re: wip-encoding
Date: Sun, 22 Jan 2012 22:18:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201222206550.22651@cobra.newdream.net>
References: <Pine.LNX.4.64.1201161520380.27147@cobra.newdream.net>
 <CAF3hT9CMJ1MZmA6Dkzj8ZXKpDtYECk_h3s2rudQjYkZDc-2cQw@mail.gmail.com>
 <Pine.LNX.4.64.1201201045230.8753@cobra.newdream.net>
 <CAF3hT9BwUW8mHsB+Z2u_iUGZp0494wGKjFgmjhzipxuYhXcV_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-489448358-1327299496=:22651"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60071 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2AWGSS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2012 01:18:18 -0500
In-Reply-To: <CAF3hT9BwUW8mHsB+Z2u_iUGZp0494wGKjFgmjhzipxuYhXcV_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-489448358-1327299496=:22651
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Jan 2012, Gregory Farnum wrote:
> On Fri, Jan 20, 2012 at 10:58 AM, Sage Weil <sage@newdream.net> wrote:
> > The current pattern is
> >
> > void Foo::encode(bufferlist& bl, unsigned features) const
> > {
> > =A0if (features & NEW_THING) {
> > =A0 =A0 // encode normally
> > =A0} else {
> > =A0 =A0 // encode old way (wahtever was in this func)
> > =A0}
> > }
> >
> > I'm not sure what to add here to make this less painful or error-prone.
> > ceph-dencoder does have options to print the feature set for the versio=
n
> > it was compiled for, and to set the bits passed to encoder functions, s=
o
> > that we can test these paths.
>=20
> Well, our features tend to all move forward, so perhaps we should have
> a way of specifying different encoders based on the feature bits (or
> struct version) we're targeting, instead of if-elsing through the code
> (nesting with something like this tends to sprawl ever-deeper). I
> think that would make it easier to test inter-version compatibility
> and avoid accidentally breaking interoperation.
>=20
> Not having spent a bunch of time thinking about how to do this I don't
> have obviously better ideas off-hand, but I'd really like it if
> somebody could either present a good option or else say why we won't
> get anything much better, instead of just pressing ahead because
> nobody has any better ideas. :( We're going to be stuck with this for
> a while.

Hmm.  I don't like obscuring control flow with macros, and features needs=
=20
to be an argument.  I don't have any real ideas here.

> >> > This requires and initial incompat change to add the length and inco=
mpat
> >> > fields, but then we can generally add things without breakage.
> >> Hmm...if we come up with something that talks feature bits we could do
> >> this nicely with a compat bit. :)
> >
> > Hmm, yeah. =A0If we redo a bunch of encoders at once we can use a
> > single feature bit for all of them. =A0That's a good idea!
>=20
> I'm not sure my thought came across clearly ?=A0we should be able to use
> a compat rather than an incompat flag if we have a good way to target
> multiple versions in our encoder.

You'll need to explain what you mean on Monday.. I'm missing it!

> > I cleaned up the tool usage a bit and it currently looks like
> >
> > $ ./ceph-dencoder -h
> > usage: ceph-dencoder [commands ...]
> >
> > =A0version =A0 =A0 =A0 =A0 =A0print version string (to stdout)
> >
> > =A0import <encfile> read encoded data from encfile
> > =A0export <outfile> write encoded data to outfile
> >
> > =A0features <num> =A0 set feature bits used for encoding
> > =A0get_features =A0 =A0 print feature bits (int) to stdout
>=20
> We will probably be happier in the long run if we can use symbolic
> names for the features. Not sure how difficult that would be, though.

Just a bunch of string parsing and conversion functions.  Meh...
=20
> > =A0list_types =A0 =A0 =A0 list supported types
> > =A0type <classname> select type
> > =A0decode =A0 =A0 =A0 =A0 =A0 decode into in-core object
> > =A0encode =A0 =A0 =A0 =A0 =A0 encode in-core object
> > =A0dump_json =A0 =A0 =A0 =A0dump in-core object as json (to stdout)
> >
> > =A0count =A0 =A0 =A0 =A0 =A0 =A0print number of generated test objects =
(to stdout)
> > =A0select <n> =A0 =A0 =A0 select generated test object as in-core objec=
t
>=20
> I'm not sure what "in-core" means here, nor what it means to "select type=
".

I'll it to 'in-memory'. :)

--557981400-489448358-1327299496=:22651--
