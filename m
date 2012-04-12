From: Sage Weil <sage@newdream.net>
Subject: Re: wip-librbd-caching
Date: Thu, 12 Apr 2012 13:20:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204121257050.21220@cobra.newdream.net>
References: <4F872D48.6070801@tuxadero.com> <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
 <CAORUGqARGBqwXw+zLxjiyounRmFJpWJj293mwsy+7=0f6iOGcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-988276967-1334262001=:21220"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47278 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131Ab2DLUVU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 16:21:20 -0400
In-Reply-To: <CAORUGqARGBqwXw+zLxjiyounRmFJpWJj293mwsy+7=0f6iOGcA@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1204121320120.21220@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Martin Mailand <martin@tuxadero.com>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-988276967-1334262001=:21220
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1204121320121.21220@cobra.newdream.net>

On Thu, 12 Apr 2012, Tommi Virtanen wrote:
> On Thu, Apr 12, 2012 at 12:45, Sage Weil <sage@newdream.net> wrote:
> >> So maybe we could reduce the memory footprint of the cache, but keep i=
t's
> >> performance.
> >
> > I'm not familiar with the performance implications of KSM, but the
> > objectcacher doesn't modify existing buffers in place, so I suspect it'=
s a
> > good candidate. =A0And it looks like there's minimal effort in enabling
> > it...
>=20
> Are the objectcacher cache entries full pages, page aligned, with no
> bookkeeping data inside the page? Those are pretty much the
> requirements for page-granularity dedup to work..

Some buffers are, some aren't, but we'd only want to madvise on page=20
aligned ones.  The messenger is careful to read things into aligned=20
memory, and librbd will only be getting block-sized (probably page-sized,=
=20
if we say we have 4k blocks) IO... so that should include every buffer in=
=20
this case.

sage
--557981400-988276967-1334262001=:21220--
