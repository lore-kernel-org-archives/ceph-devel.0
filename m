From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Building the Ceph client on Lucid Lynx
Date: Fri, 18 Mar 2011 15:45:16 -0700
Message-ID: <20110318224516.GA5086@dreamer>
References: <loom.20110318T232227-447@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41472 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab1CRWpU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 18:45:20 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110318T232227-447@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, Mar 18, 2011 at 10:23:37PM +0000, Steena Monteiro wrote:
> I'm trying to build the Ceph client on Ubuntu 10.04.2 with kernel
> 2.6.32-28-generic.  make -C install gives:
>=20
> /usr/src/ceph-client-standalone/ceph/super.c:870: error: unknown fiel=
d =E2=80=98mount=E2=80=99
> specified in initializer

That changed in ceph-client-standalone.git commit
ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e, which mirrors linux.git
commit a7f9fb205a88ab9af675a68fc554cf51dafc8b60, which was a VFS
refactoring by Al Viro for Linux 2.6.37-rc1.

You'll need to build an older version of ceph-client-standalone, or
perhaps try reverting that one commit (git revert ff8a8d). Good luck.

--=20
:(){ :|:&};:
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
