From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Circular lock / deadlock in kernel client
Date: Tue, 6 Dec 2011 14:21:28 +0100
Message-ID: <201112061421.30695.a.ott@m-privacy.de>
References: <201111301321.47514.a.ott@m-privacy.de> <Pine.LNX.4.64.1112010812090.18236@cobra.newdream.net> <201112011724.48724.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:52307 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933167Ab1LFNWb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 08:22:31 -0500
In-Reply-To: <201112011724.48724.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thursday 01 December 2011 wrote Amon Ott:
> On Thursday 01 December 2011 wrote Sage Weil:
> > On Thu, 1 Dec 2011, Amon Ott wrote:
> > > On Wednesday 30 November 2011 wrote Sage Weil:
> > > > I pushed a wip-i-ceph-lock branch to ceph-client.git that repla=
ces
> > > > our (ab?)use of i_lock with a new i_ceph_lock in the ceph inode=
=2E=20
> > > > This avoids being bitten by the lock ordering constraint impose=
d by
> > > > igrab(), which requires i_lock to safely take a reference to an=
 inode
> > > > without racing with inode destruction.  This lets us keep two i=
node
> > > > list locks logically ordered inside i_ceph_lock (with i_lock as=
 an
> > > > inner lock).
> > >
> > > I see the branch, but there is nothing new in it. Is that the rig=
ht
> > > location? Maybe forgot to push?
> > >
> > > https://github.com/NewDreamNetwork/ceph-client/tree/wip-i-ceph-lo=
ck
> >
> > Oops, I pushed the wrong branch.  It's there now.
>
> Got the new commit, but it does not apply cleanly to my tree. I will =
try to
> get it merged tomorrow and retry. I cannot use kernel 3.2-pre here, t=
he
> rest of the system needs to be stable.

Merged in and bug seems to be fixed. No more deadlock warnings today.

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
