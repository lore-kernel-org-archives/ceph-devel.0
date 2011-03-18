From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Building the Ceph client on Lucid Lynx
Date: Fri, 18 Mar 2011 15:50:43 -0700
Message-ID: <AFA905E8B6AC4E459A4E2913D853BE3B@gmail.com>
References: <loom.20110318T232227-447@post.gmane.org>
 <20110318224516.GA5086@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37472 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095Ab1CRWur (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 18:50:47 -0400
Received: by iwn34 with SMTP id 34so4482386iwn.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 15:50:47 -0700 (PDT)
In-Reply-To: <20110318224516.GA5086@dreamer>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Steena Monteiro <steena.m@aggiemail.usu.edu>, ceph-devel@vger.kernel.org


On Friday, March 18, 2011 at 3:45 PM, Tommi Virtanen wrote:=20
> On Fri, Mar 18, 2011 at 10:23:37PM +0000, Steena Monteiro wrote:
> > I'm trying to build the Ceph client on Ubuntu 10.04.2 with kernel
> > 2.6.32-28-generic. make -C install gives:
> >=20
> > /usr/src/ceph-client-standalone/ceph/super.c:870: error: unknown fi=
eld =E2=80=98mount=E2=80=99
> > specified in initializer
>=20
> That changed in ceph-client-standalone.git commit
> ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e, which mirrors linux.git
> commit a7f9fb205a88ab9af675a68fc554cf51dafc8b60, which was a VFS
> refactoring by Al Viro for Linux 2.6.37-rc1.
>=20
> You'll need to build an older version of ceph-client-standalone, or
> perhaps try reverting that one commit (git revert ff8a8d). Good luck.

=46YI: ceph-client-standalone is supposed to build on older kernels, al=
though it's only loosely maintained. Let us know how it goes -- if it d=
oesn't work we'll put at least a few developer hours into it!
-Greg



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
