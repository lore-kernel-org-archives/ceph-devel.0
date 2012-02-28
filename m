From: Sage Weil <sage@newdream.net>
Subject: Re: ceph config without ctrfs
Date: Tue, 28 Feb 2012 09:26:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202280923530.19562@cobra.newdream.net>
References: <4F4C0F60.1070100@genome.wustl.edu>
 <CAF3hT9Ap-rqB+3B0WqUzFGhMFDTrN00HiYHAhaW0gSF_60HNnQ@mail.gmail.com>
 <CAORUGqD7ufy=NyS39JGFOAX4ikZf+q6JL=CEK18a7cmRWsoSEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-740224192-1330449961=:19562"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51246 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab2B1R0C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 12:26:02 -0500
In-Reply-To: <CAORUGqD7ufy=NyS39JGFOAX4ikZf+q6JL=CEK18a7cmRWsoSEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-740224192-1330449961=:19562
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 27 Feb 2012, Tommi Virtanen wrote:
> On Mon, Feb 27, 2012 at 15:29, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
> > On Mon, Feb 27, 2012 at 3:18 PM, Matt Weil <mweil@genome.wustl.edu> wro=
te:
> >> How do you do this type of config (specifying multiple devices per ser=
ver)
> >> on xfs not btrfs?
> >>
> >>> [osd.1]
> >>> =A0 =A0 =A0 =A0host =3D linuscs92
> >>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d2
>=20
> My inclination at this point is to deprecate & remove the "btrfs devs"
> feature as soon as possible. It's a half-feature that keeps tripping
> people up.
>=20
> Format your filesystems as you wish, mount them, and point "osd data"
> at one. "btrfs devs" was meant for quickly creating throwaway test
> setups.

Sounds good to me.  Should we add a warning if the feature is used for=20
now, or just rip it out?

It would also be nice to define the path forward at the same time.  Even a=
=20
high level description of what you have in mind to the list so that people=
=20
know where we're going and can work toward.

sage

--557981400-740224192-1330449961=:19562--
