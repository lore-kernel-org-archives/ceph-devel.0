From: Sage Weil <sage@newdream.net>
Subject: Re: wip-encoding
Date: Fri, 20 Jan 2012 10:58:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201201045230.8753@cobra.newdream.net>
References: <Pine.LNX.4.64.1201161520380.27147@cobra.newdream.net>
 <CAF3hT9CMJ1MZmA6Dkzj8ZXKpDtYECk_h3s2rudQjYkZDc-2cQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-54174739-1327085911=:8753"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40284 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab2ATS6c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2012 13:58:32 -0500
In-Reply-To: <CAF3hT9CMJ1MZmA6Dkzj8ZXKpDtYECk_h3s2rudQjYkZDc-2cQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-54174739-1327085911=:8753
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Jan 2012, Gregory Farnum wrote:
> On Mon, Jan 16, 2012 at 3:46 PM, Sage Weil <sage@newdream.net> wrote:
> > When we can't handle a change with a compatible encoding change, we can
> > introduce a feature bits and conditionally encode old formats for old
> > peers. =A0This is just more work and eats into a more limited feature b=
it
> > space.
>=20
> I'd like to hear a lot more about this ? it's the real problem. I
> think we've already got one example in the codebase of encoding for
> backwards-compatibility, and it's a huge mess.
> Could we construct reasonable macros/functions that take in compat
> bits from the daemon we're targeting and then select the appropriate
> encoder based on those, for instance? It certainly shouldn't be hacked
> together on a case-by-case basis because we're going to start running
> into a lot more of these things as we start testing for
> forwards-and-backwards compatibility.

The current pattern is=20

void Foo::encode(bufferlist& bl, unsigned features) const
{
  if (features & NEW_THING) {
     // encode normally
  } else {
     // encode old way (wahtever was in this func)
  }
}

I'm not sure what to add here to make this less painful or error-prone. =20
ceph-dencoder does have options to print the feature set for the version=20
it was compiled for, and to set the bits passed to encoder functions, so=20
that we can test these paths.

> > =A0void pool_snap_info_t::decode(bufferlist::iterator& bl)
> > =A0{
> > =A0 DECODE_START_LEGACY(2, bl, 2);
> >
> > We can still decode v1 code, but it doesn't have the (new) length and
> > incompat version fields, so use the _LEGACY macro. =A0The second 2 mean=
s we
> > started using the new approach with v2.
>=20
> Is there a DECODE_START (non-legacy) for new structs?

yeah

> > This requires and initial incompat change to add the length and incompa=
t
> > fields, but then we can generally add things without breakage.
> Hmm...if we come up with something that talks feature bits we could do
> this nicely with a compat bit. :)

Hmm, yeah.  If we redo a bunch of encoders at once we can use a=20
single feature bit for all of them.  That's a good idea!

> > How to build the per-version corpus? =A0We can write unit tests that
> > explicitly generate interesting object instances. =A0That's tedious and=
 time
> > consuming, but probably best, since the developer knows what corner cas=
es
> > are interesting.
>=20
> If we've got a single tool that can handle all the structs we can
> presumably encode each struct from a given version?
> Obviously constructing actual state would require more work but just
> checking the default constructor version of each struct would go a
> long, loooong way toward automating encode/decode checks.

Yeah.  So the new idea here is to create a static class methods like

  static void generate_test_instances(list<T>& o);

and have the implementation fill a list with some interesting object=20
instances.  That normally looks something like

  void foo_t::generate_test_instances(list<foo_t>& o) {
    foo_t a;
    o.push_back(a);
    a.x =3D 1;
    a.y =3D 2;
    a.z.push_back(3);
    o.push_back(a);
  }

and the ceph-dencoder lets you select these generated objects to=20
encode/decode/dump/whatever.

I cleaned up the tool usage a bit and it currently looks like

$ ./ceph-dencoder -h
usage: ceph-dencoder [commands ...]

  version          print version string (to stdout)

  import <encfile> read encoded data from encfile
  export <outfile> write encoded data to outfile

  features <num>   set feature bits used for encoding
  get_features     print feature bits (int) to stdout

  list_types       list supported types
  type <classname> select type
  decode           decode into in-core object
  encode           encode in-core object
  dump_json        dump in-core object as json (to stdout)

  count            print number of generated test objects (to stdout)
  select <n>       select generated test object as in-core object


There are also some preliminary scripts to populate an archive that looks=
=20
something like

ar
ar/0.40
ar/0.40/osd_stat_t
ar/0.40/osd_stat_t/25afb7d451b03137f945307a1ed82a33
ar/0.40/osd_stat_t/800a085cc38e531cd41af1905a0f37e8
=2E..
ar/0.40/utime_t
ar/0.40/utime_t/8bdbd752410ebe5fb417a23173910b0f
ar/0.40/utime_t/e8884a8076dd8e639f5bfa3b896427a8
ar/0.40/utime_t/6bd3e253cb30ad41417f055be3f8a485
=2E..

I'm thinking we also include a built ceph-dencoder in each version dir, so=
=20
that some scripts can do the cross-version validation.  That just requires=
=20
standarizing the usage for ceph-dencoder, so please poke some holes in the=
=20
above!

thanks
sage

--557981400-54174739-1327085911=:8753--
