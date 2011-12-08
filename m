From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Circular lock / deadlock in kernel client
Date: Thu, 8 Dec 2011 14:39:33 +0100
Message-ID: <201112081439.34719.a.ott@m-privacy.de>
References: <201111301321.47514.a.ott@m-privacy.de> <Pine.LNX.4.64.1112070831250.22025@cobra.newdream.net> <201112081058.47241.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:52702 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab1LHNjo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 08:39:44 -0500
In-Reply-To: <201112081058.47241.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thursday 08 December 2011 wrote Amon Ott:
> On Wednesday 07 December 2011 wrote Sage Weil:
> > I pushed a patch to wip-d-lock that may fix this one, but unfortuna=
tely
> > don't have time to test this very carefully right now.  Let us know=
 if
> > that helps, or you can wait until next week.
>
> Rebuilding kernel with that patch.

With the patch the deadlock disappears and the kernel does not hang at =
the=20
locks afterwards.

> > The call path that was triggering both of these can be exercised by
> > restarting the ceph-mds daemon.  Try running your client for a bit =
and
> > the doing that and see if you get any more splats.
>
> What triggered the kernel problem was bug 1047. ceph-mds crashed on a=
ll
> nodes with that assert. When the kernel detected that the main mds
> connection was missing, it tried to reconnect and hung.

This problem remains, and without a working mds the whole ceph mount ha=
ngs.=20
Instead of crashing, mds sometimes goes into a dead loop and uses a cpu=
 core=20
at 100%. This also makes the mount hang.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
