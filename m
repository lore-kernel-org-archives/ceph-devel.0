From: Sage Weil <sage@inktank.com>
Subject: Re: argonaut stable update coming shortly
Date: Sun, 6 Jan 2013 14:38:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301061436500.15430@cobra.newdream.net>
References: <alpine.DEB.2.00.1301042052090.15430@cobra.newdream.net> <CAGrbCHcP6tOO_LAUrzktZyoWdyAcWvhozHSGJbRKysBnnpwDnA@mail.gmail.com> <CAGrbCHevt=oWcXiYgn4enSH-Xerttx40-1K23OSTxBO5OEODig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1794104952-1357511884=:15430"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57272 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab3AFWiG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 17:38:06 -0500
In-Reply-To: <CAGrbCHevt=oWcXiYgn4enSH-Xerttx40-1K23OSTxBO5OEODig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Li <n0zai1sheep@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1794104952-1357511884=:15430
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Isaac,

On Mon, 7 Jan 2013, Isaac Li wrote:
> ? ... no one cares about me!!

There are many commercial use cases besides DreamHost, but the ones I kno=
w=20
most about are Inktank customers, and I'm generally not at liberty to nam=
e=20
names.

What is your use case?

sage


>=20
> On Sat, Jan 5, 2013 at 5:09 PM, Isaac Li <n0zai1sheep@gmail.com> wrote:
>       Hello,
> Recently I'm studying Ceph and want to know whether there are some
> more
> commercial=C2=A0use cases besides=C2=A0DreamHost...
>=20
> Thanks.
>=20
>=20
> On Sat, Jan 5, 2013 at 12:56 PM, Sage Weil <sage@inktank.com> wrote:
>       We recently identified a bug in the way the OSD is marking
>       its commits
>       on XFS or ext4 (well, anything not btrfs) that could lead
>       data loss in the
>       event of power loss or a kernel panic. =C2=A0We're doing some
>       final testing and
>       will have a v0.48.3argonaut package available by Monday.
>       =C2=A0If you like,
>       you can get the fix before that from the autobuilders by
>       grabbing the
>       'stable' branch; see
>=20
> =C2=A0http://ceph.com/docs/master/install/debian/#add-development-testi=
ng-packag
>       es
>=20
>       sage
>=20
>=20
>=20
>       --
>       To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       the body of a message to majordomo@vger.kernel.org
>       More majordomo info at
>       =C2=A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
> --
>=20
> Isaac Li
>=20
>=20
>=20
>=20
> --
>=20
> Isaac Li
>=20
>=20
> Phil 4:6 Be anxious for nothing, but in everything by prayer and
> supplication with thanksgiving let your requests be made known to God.
>=20
>=20
>=20
--557981400-1794104952-1357511884=:15430--
