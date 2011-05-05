From: Sage Weil <sage@newdream.net>
Subject: Re: Document and example for libceph, librbd and librados
Date: Wed, 4 May 2011 21:24:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105042121150.17319@cobra.newdream.net>
References: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
 <1304514803.4036.104.camel@wido-laptop.pcextreme.nl>
 <BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
 <1304523657.4036.110.camel@wido-laptop.pcextreme.nl>
 <BANLkTi=i6so2XwLUBceHQfakY5qaJDfpSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-393155117-1304569479=:17319"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57215 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab1EEEYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 00:24:06 -0400
In-Reply-To: <BANLkTi=i6so2XwLUBceHQfakY5qaJDfpSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-393155117-1304569479=:17319
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 May 2011, tsk wrote:
> 2011/5/4 Wido den Hollander <wido@widodh.nl>:
> > Hi,
> >
> > On Wed, 2011-05-04 at 22:22 +0800, tsk wrote:
> >> 2011/5/4 Wido den Hollander <wido@widodh.nl>:
> >> > Hi,
> >> >
> >> > On Wed, 2011-05-04 at 20:36 +0800, tsk wrote:
> >> >> Hi folks,
> >> >>
> >> >> =A0 =A0 =A0Is there any document for libceph, librbd and librados, =
and where
> >> >> could I get some example for them?
> >> >
> >> > What kind of examples are you looking for? In the Ceph git repositor=
y
> >> > there is:
> >> >
> >> > * rados.cc (The rados tool)
> >> > * testradospp.cpp
> >> > * testrbdpp.cpp
> >>
> >> Thx!
> >> I have run over these test code yet, =A0I think they are useful for me=
=2E
> >>
> >> Hmm, Is there any simple application example for these library?
> >
> > What kind of example are you looking for? I think everything you are
> > searching for is in the testradospp/testrbdpp files, those really show
> > what you can do.
> >
> > Could you explain what you are trying to achieve/write?
> >
> > Wido
>=20
> I have an application which is decided to be achieved by ceph, which
> is the most suitable. But there are some requirements I don't know how
> to satisfy with the ceph libs:
>=20
> There will be almost 10000 big file, each may be 10G~500G. Kernel
> client will not be used, instead, a user space process will handle
> read and write requests for each file via using the libs of ceph.
> Because this will bypass the kernel VFS, and should get better
> performance.
>=20
> Problem I want to issue:
> 1.   I need to set size of replicas for each file. e.g 1 replica for A
> file, 2 for B file, 3 for C file.etc.
> I think I should create several pools, each with a different replica
> size. File for different replica size should be drop into the
> corresponding pool. Is that workable?

Yep.  There is a per-file ioctl you can use to set the pool after creating=
=20
the file but before writing any data to it, or there is a directory ioctl=
=20
that sets the default layout/pool for new files created in that subtree. =
=20
There should be equivalent libceph calls (if they aren't there yet, they=20
are easily added in to complete the interface).
=20
> 2.   Snapshot should be able to create, delete, list, rollback for each f=
ile.
> Which APIs should I use in libceph, librbd and librados?

The file system doesn't have a built-in 'rollback' operation.  You=20
currently need to recopy the old data over the new, unfortunately.  It is=
=20
possible to make this efficient (at least for individual files), but we=20
haven't done it yet.
=20
> 3.   The user space process and the cosd process will run on the same
> host. To lower the network utilization, force-feeding will be used. I
> guess reading performance may be better when do this, is it right? I
> need to confirm this.  How to configure the force-feeding option=FF=FF In
> the libs or the CRUSH map?

There is a 'preferred' field you can set via the libceph interface. =20
There is also a get_local_osd() that tells you an osd on the local node=20
(if there is one).

sage
--557981400-393155117-1304569479=:17319--
