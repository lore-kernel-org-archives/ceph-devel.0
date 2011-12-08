From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Circular lock / deadlock in kernel client
Date: Thu, 8 Dec 2011 10:58:46 +0100
Message-ID: <201112081058.47241.a.ott@m-privacy.de>
References: <201111301321.47514.a.ott@m-privacy.de> <201112071620.42437.a.ott@m-privacy.de> <Pine.LNX.4.64.1112070831250.22025@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:50909 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab1LHJ65 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 04:58:57 -0500
In-Reply-To: <Pine.LNX.4.64.1112070831250.22025@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wednesday 07 December 2011 wrote Sage Weil:
> I pushed a patch to wip-d-lock that may fix this one, but unfortunate=
ly
> don't have time to test this very carefully right now.  Let us know i=
f
> that helps, or you can wait until next week.

Rebuilding kernel with that patch.

> The call path that was triggering both of these can be exercised by
> restarting the ceph-mds daemon.  Try running your client for a bit an=
d
> the doing that and see if you get any more splats.

What triggered the kernel problem was bug 1047. ceph-mds crashed on all=
 nodes=20
with that assert. When the kernel detected that the main mds connection=
 was=20
missing, it tried to reconnect and hung.

We do appreciate how much work you are doing to make Ceph production re=
ady.=20
Thank you!

We really want to use Ceph in our product, because the design and exper=
ience=20
so far have shown a lot of potential.

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
