From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 15:10:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <orwrbfu4js.fsf@livre.localdomain> <CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
 <orobwqt186.fsf@livre.localdomain> <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
 <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
 <CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
 <CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37791 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1KGXKj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 18:10:39 -0500
In-Reply-To: <CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

On Mon, 7 Nov 2011, Mandell Degerness wrote:
> So, does this apply only to Posix, or to RBD mounts as well?  If so, I
> think we may have to rethink using Ceph in our environment at all.

It applies to RBD too... _if_ the ceph-osd process is calling sync(2).  
On btrfs it doesn't, and on XFS/extN/etc., it only does on older kernels 
with older glibc.  New kernels (.39+) and new glibc have syncfs(2), which 
syncs only the fs the ceph-osd is serving up.

http://linux.die.net/man/2/syncfs

sage


> 
> On Mon, Nov 7, 2011 at 1:45 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > On Mon, Nov 7, 2011 at 11:48, Gregory Farnum
> > <gregory.farnum@dreamhost.com> wrote:
> >> (Hopefully this email still makes sense; I rewrote it several times
> >> trying to figure out what was going on with ceph-fuse!)
> >
> > tl;dr: Don't mount any network filesystem on the box serving that
> > filesystem. The virtual memory disk buffer system will deadlock at
> > some point. That includes Ceph and NFS. The cost of making that work
> > right is so high that in practice it's just not done.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
