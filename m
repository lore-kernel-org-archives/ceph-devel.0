From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Building the Ceph client on Lucid Lynx
Date: Fri, 18 Mar 2011 15:56:59 -0700
Message-ID: <5981E16F90B045E8BEA32AF41BEA2E80@gmail.com>
References: <loom.20110318T232227-447@post.gmane.org>
 <20110318224516.GA5086@dreamer>
 <AFA905E8B6AC4E459A4E2913D853BE3B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42358 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab1CRW5D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 18:57:03 -0400
Received: by iyb26 with SMTP id 26so4486538iyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 15:57:02 -0700 (PDT)
In-Reply-To: <AFA905E8B6AC4E459A4E2913D853BE3B@gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: ceph-devel@vger.kernel.org


On Friday, March 18, 2011 at 3:50 PM, Gregory Farnum wrote:=20
>=20
> On Friday, March 18, 2011 at 3:45 PM, Tommi Virtanen wrote:=20
> > On Fri, Mar 18, 2011 at 10:23:37PM +0000, Steena Monteiro wrote:
> > > I'm trying to build the Ceph client on Ubuntu 10.04.2 with kernel
> > > 2.6.32-28-generic. make -C install gives:
> > >=20
> > > /usr/src/ceph-client-standalone/ceph/super.c:870: error: unknown =
field =E2=80=98mount=E2=80=99
> > > specified in initializer
> >=20
> > That changed in ceph-client-standalone.git commit
> > ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e, which mirrors linux.git
> > commit a7f9fb205a88ab9af675a68fc554cf51dafc8b60, which was a VFS
> > refactoring by Al Viro for Linux 2.6.37-rc1.
> >=20
> > You'll need to build an older version of ceph-client-standalone, or
> > perhaps try reverting that one commit (git revert ff8a8d). Good luc=
k.
>=20
> FYI: ceph-client-standalone is supposed to build on older kernels, al=
though it's only loosely maintained. Let us know how it goes -- if it d=
oesn't work we'll put at least a few developer hours into it!
> -Greg
>  Correction: The backports branch of ceph-client-standalone is suppos=
ed to build on older kernels. Have you tried that one?=20
-Greg



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
