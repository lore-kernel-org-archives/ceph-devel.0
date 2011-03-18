From: Sage Weil <sage@newdream.net>
Subject: Re: Building the Ceph client on Lucid Lynx
Date: Fri, 18 Mar 2011 16:42:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103181641090.16804@cobra.newdream.net>
References: <loom.20110318T232227-447@post.gmane.org> <20110318224516.GA5086@dreamer>
 <AFA905E8B6AC4E459A4E2913D853BE3B@gmail.com> <5981E16F90B045E8BEA32AF41BEA2E80@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1927087240-1300491720=:16804"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52005 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab1CRXkO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 19:40:14 -0400
In-Reply-To: <5981E16F90B045E8BEA32AF41BEA2E80@gmail.com>
Content-ID: <Pine.LNX.4.64.1103181642190.16804@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: henry.cy.chang@gmail.com
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Steena Monteiro <steena.m@aggiemail.usu.edu>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1927087240-1300491720=:16804
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1103181642191.16804@cobra.newdream.net>

On Fri, 18 Mar 2011, Gregory Farnum wrote:
> On Friday, March 18, 2011 at 3:50 PM, Gregory Farnum wrote:=20
> >=20
> > On Friday, March 18, 2011 at 3:45 PM, Tommi Virtanen wrote:=20
> > > On Fri, Mar 18, 2011 at 10:23:37PM +0000, Steena Monteiro wrote:
> > > > I'm trying to build the Ceph client on Ubuntu 10.04.2 with kernel
> > > > 2.6.32-28-generic. make -C install gives:
> > > >=20
> > > > /usr/src/ceph-client-standalone/ceph/super.c:870: error: unknown fi=
eld =FF=FFmount=FF=FF
> > > > specified in initializer
> > >=20
> > > That changed in ceph-client-standalone.git commit
> > > ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e, which mirrors linux.git
> > > commit a7f9fb205a88ab9af675a68fc554cf51dafc8b60, which was a VFS
> > > refactoring by Al Viro for Linux 2.6.37-rc1.
> > >=20
> > > You'll need to build an older version of ceph-client-standalone, or
> > > perhaps try reverting that one commit (git revert ff8a8d). Good luck.
> >=20
> > FYI: ceph-client-standalone is supposed to build on older kernels, alth=
ough it's only loosely maintained. Let us know how it goes -- if it doesn't=
 work we'll put at least a few developer hours into it!
> > -Greg
> Correction: The backports branch of ceph-client-standalone is supposed to=
 build on older kernels. Have you tried that one?=20
> -Greg

I think the problem is that particular change hasn't been backported yet.=
=20
The most recent backport fixes have been done by Henry.  I'm not sure if=20
they've done this one too?

sage
--557981400-1927087240-1300491720=:16804--
