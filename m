From: Sage Weil <sage@inktank.com>
Subject: Re: core standup
Date: Thu, 5 Dec 2013 09:53:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312050952460.21812@cobra.newdream.net>
References: <alpine.DEB.2.00.1312050919450.32370@cobra.newdream.net> <CAPYLRzhdBLg8ggq=55UYnxe7pA+B4JeSyO06SO1RMXS=psp2OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-682111527-1386266011=:21812"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49867 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757812Ab3LERxb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Dec 2013 12:53:31 -0500
In-Reply-To: <CAPYLRzhdBLg8ggq=55UYnxe7pA+B4JeSyO06SO1RMXS=psp2OQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-682111527-1386266011=:21812
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2013, Gregory Farnum wrote:
> On Thursday, December 5, 2013, Sage Weil wrote:
>       Missing core standup today (all day meeting).
>=20
>       Y:
>       - more wip-tier work
>       - almost done with memstore (a simple in-memory ObjectStore
>       backend to
>       =A0 serve as a reference implementation and possibly as a
>       benchmarking tool)
>       - more review of Zheng's mds branch
>=20
>       T:
>       - meeting
>       - finish memstore
>       - more wip-tier wrangling (verify the trimming is working
>       properly; add a
>       test for it)
>=20
>       B:
>       - wip-crush-tunables needs review
>       - wip-crush needs review
>       - wip-pool-set-* needs some consensus on approach. =A0the kludgey
>       fix is in
>       the pull requests; an alternative general approach is described
>       by
>       =A0 =A0 =A0 =A0
>       https://github.com/ceph/ceph/pull/895#issuecomment-29846799
>=20
>=20
> Since we need this for the tiering,=A0I'm going to tackle=A0an alternat=
ive
> today=A0that Sam and Joao and I have discussed previously, where the mo=
nitors
> in a quorum=A0share their accepted APIs with each other=A0and advertise=
 the
> maximum subset to clients. I'll need to become more familiar with the
> API=A0internals but I don't think it should be too difficult.

Cool.  Is this just a current_version and compat_version defined in=20
MonCommands?  And if incompat with the leader, boot the client?

s


--557981400-682111527-1386266011=:21812--
