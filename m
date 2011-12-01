From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Circular lock / deadlock in kernel client
Date: Thu, 1 Dec 2011 17:24:47 +0100
Message-ID: <201112011724.48724.a.ott@m-privacy.de>
References: <201111301321.47514.a.ott@m-privacy.de> <201112010916.09576.a.ott@m-privacy.de> <Pine.LNX.4.64.1112010812090.18236@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:47194 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882Ab1LAQZF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2011 11:25:05 -0500
In-Reply-To: <Pine.LNX.4.64.1112010812090.18236@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thursday 01 December 2011 wrote Sage Weil:
> On Thu, 1 Dec 2011, Amon Ott wrote:
> > On Wednesday 30 November 2011 wrote Sage Weil:
> > > I pushed a wip-i-ceph-lock branch to ceph-client.git that replace=
s our
> > > (ab?)use of i_lock with a new i_ceph_lock in the ceph inode.  Thi=
s
> > > avoids being bitten by the lock ordering constraint imposed by ig=
rab(),
> > > which requires i_lock to safely take a reference to an inode with=
out
> > > racing with inode destruction.  This lets us keep two inode list =
locks
> > > logically ordered inside i_ceph_lock (with i_lock as an inner loc=
k).
> >
> > I see the branch, but there is nothing new in it. Is that the right
> > location? Maybe forgot to push?
> >
> > https://github.com/NewDreamNetwork/ceph-client/tree/wip-i-ceph-lock
>
> Oops, I pushed the wrong branch.  It's there now.

Got the new commit, but it does not apply cleanly to my tree. I will tr=
y to=20
get it merged tomorrow and retry. I cannot use kernel 3.2-pre here, the=
 rest=20
of the system needs to be stable.

Interesting note: Even though I got the deadlock message in syslog, the=
 system=20
worked fine for another few hours, until all the MDS processes died (se=
e my=20
other mail).

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
