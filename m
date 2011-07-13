From: Sage Weil <sage@newdream.net>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 12:22:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107131215360.8865@cobra.newdream.net>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
 <CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
 <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
 <4E1DDCEA.9010107@hq.newdream.net> <CAC-hyiEsL2yw83pELy8-XdGqxMst_XZX4RGCW4-S6GCFjRRiZQ@mail.gmail.com>
 <CA+qbEUMSDOrCGPB4YO0ysAs_VzXzHUJNKSe2a9fKoDLjVOEOtQ@mail.gmail.com>
 <CAC-hyiGOjPhNfrq11Tfwe=S_FTm+2dGncJZ8oEmOisvg55Cb1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1119994446-1310584971=:8865"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54327 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1GMTTb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 15:19:31 -0400
In-Reply-To: <CAC-hyiGOjPhNfrq11Tfwe=S_FTm+2dGncJZ8oEmOisvg55Cb1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, samuel.just@dreamhost.com, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1119994446-1310584971=:8865
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 Jul 2011, Yehuda Sadeh Weinraub wrote:
> On Wed, Jul 13, 2011 at 11:08 AM, Colin McCabe <cmccabe@alumni.cmu.edu> w=
rote:
> > On Wed, Jul 13, 2011 at 11:04 AM, Yehuda Sadeh Weinraub
> > <yehudasa@gmail.com> wrote:
> >> On Wed, Jul 13, 2011 at 10:59 AM, Samuel Just <samuelj@hq.newdream.net=
> wrote:
> >>> On 07/13/2011 10:52 AM, Yehuda Sadeh Weinraub wrote:
> >>>>>
> >>>>> * Naming> =A0Type Names:
> >>>>>
> >>>>> =A0 =A0Google uses CamelCaps for all type names. =A0We use two nami=
ng schemes:
> >>>>>
> >>>>> =A0 =A0- for structs (simple data containers), lower case with _t s=
uffix:
> >>>>> =A0 =A0 =A0 =A0struct my_type_t {
> >>>>> =A0 =A0 =A0 =A0 =A0int a, b;
> >>>>> =A0 =A0 =A0 =A0 =A0my_type_t() : a(0), b(0) {}
> >>>>> =A0 =A0 =A0 =A0};
> >>>>
> >>>> I'd rather have the struct naming without the _t suffix (as with the=
 C
> >>>> code), and typedef to add _t, e.g.:
> >>>>
> >>>> typedef struct my_type {
> >>>> =A0...
> >>>> } my_type_t;
> >>>>
> >>> What is the advantage of the typedef?
> >>
> >> Being consistent. That's what we do in C. The _t suffix denotes a
> >> typedef, so it should be defined as one. We also mix C and C++ from
> >> time to time (e.g., we have code that is common to both userspace side
> >> and kernel side and/or links with other projects like qemu), so
> >> keeping the same notation is crucial.
> >>
> >
> > Actually, using typedef that way is *inconsistent*, since we claim to
> > follow the kernel coding style document. And this is what it has to
> > say about that:
> >
> >> Please don't use things like "vps_t".
> >>
> >> It's a _mistake_ to use typedef for structures and pointers. When you =
see a
> >>
> >> =A0 =A0 =A0 vps_t a;
> >>
> >> in the source, what does it mean?
> >>
> >> In contrast, if it says
> >>
> >> =A0 =A0 =A0 struct virtual_container *a;
> >>
> >> you can actually tell what "a" is.
>=20
> Whether to typedef or not is a different issue. If you want a _t
> suffix, use typedef.

Yeah, I'm not suggesting a typedef.  It's only useful in C if you want to=
=20
exclude the 'struct' prefix which isn't needed in C++ anyway.

The key distinction I want to make is between things like struct inode_t,=
=20
which is essentially a glorified struct with initializers/constructor, is=
=20
encodable, and has a few helper methods, versus something like SimpleLock,=
=20
which is not copyable, not encodable, has pointers to parent objects,=20
exists on specific lists, etc.  Currently the former "struct" type is=20
named_like_this_t and the latter "class" is NamedLikeThis.

In C, the no typedef rule makes a lot of sense, since you know it is a=20
struct.  In C++, it doesn't matter if it's a struct becaue the=20
initialization and such (which you tend to screw up in C) is hidden from=20
you anyway. =20

The nice thing about _t and CamelCaps both is that they don't collide with=
=20
variable names.  My concern is that

 inode *in;

isn't as clear as

 inode_t *in;  // clearly a type
 Inode *in;    // clearly a type

sage
--557981400-1119994446-1310584971=:8865--
