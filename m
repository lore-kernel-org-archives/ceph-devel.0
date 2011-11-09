From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-mon blocked error
Date: Wed, 9 Nov 2011 12:54:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091254350.31435@cobra.newdream.net>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <orwrbfu4js.fsf@livre.localdomain> <CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
 <orobwqt186.fsf@livre.localdomain> <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
 <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
 <CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
 <CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com>
 <Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net> <orhb2drxh5.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51400 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab1KIUyk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 15:54:40 -0500
In-Reply-To: <orhb2drxh5.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: Mandell Degerness <mandell@pistoncloud.com>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Applied, thanks!

On Wed, 9 Nov 2011, Alexandre Oliva wrote:

> On Nov  7, 2011, Sage Weil <sage@newdream.net> wrote:
> 
> > New kernels (.39+) and new glibc have syncfs(2), which syncs only the
> > fs the ceph-osd is serving up.
> 
> I haven't seen the current glibc implementation, but the one I have on
> my system is a stub that sets errno and returns nonzero.  autoconf
> correctly detects it as a stub, but I'm concerned that syncfs might fail
> with say ENOSYS and we'd happily go ahead assuming the data is properly
> sync()ed.
> 
> The patch below fixes this, arranging for us to fallback to sync if
> syncfs fails, but to try btrfs sync in between, under the assumption
> that the ioctl will fail if fd isn't a btrfs inode.
> 
> > http://linux.die.net/man/2/syncfs
> 
> The man page is wrong or outdated: syncfs returns int, not void.
> 
> 
