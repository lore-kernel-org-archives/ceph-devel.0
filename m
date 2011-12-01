From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Circular lock / deadlock in kernel client
Date: Thu, 1 Dec 2011 09:16:08 +0100
Message-ID: <201112010916.09576.a.ott@m-privacy.de>
References: <201111301321.47514.a.ott@m-privacy.de> <Pine.LNX.4.64.1111300919520.28417@cobra.newdream.net> <Pine.LNX.4.64.1111300952290.28417@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:56729 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab1LAIQU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2011 03:16:20 -0500
In-Reply-To: <Pine.LNX.4.64.1111300952290.28417@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wednesday 30 November 2011 wrote Sage Weil:
> I pushed a wip-i-ceph-lock branch to ceph-client.git that replaces ou=
r
> (ab?)use of i_lock with a new i_ceph_lock in the ceph inode.  This av=
oids
> being bitten by the lock ordering constraint imposed by igrab(), whic=
h
> requires i_lock to safely take a reference to an inode without racing=
 with
> inode destruction.  This lets us keep two inode list locks logically
> ordered inside i_ceph_lock (with i_lock as an inner lock).

I see the branch, but there is nothing new in it. Is that the right loc=
ation?=20
Maybe forgot to push?

https://github.com/NewDreamNetwork/ceph-client/tree/wip-i-ceph-lock

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
