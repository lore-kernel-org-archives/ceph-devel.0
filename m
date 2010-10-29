From: Sage Weil <sage@newdream.net>
Subject: Re: mds getattr locked again
Date: Thu, 28 Oct 2010 22:08:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
References: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57152 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab0J2FEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 01:04:44 -0400
In-Reply-To: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 29 Oct 2010, Henry C Chang wrote:
> Hi,
> 
> getattr on mds hanged again.
> 
> I have already reverted d91f2438d881514e4a923fd786dbd94b764a9440.
> Although the probability is significant lowered down, it still has the
> chance to hang on getattr.
> 
> Attached are the logs of mds and the hanging client. :(
> 
> I'm using ceph-client-standalone master-backport branch on 2.6.32 kernel.

It looks like ceph_check_caps is hung somehow:

ceph:ceph:  handle_caps from mds0
ceph:ceph:   mds0 seq 99 cap seq 28
ceph:ceph:   op revoke ino 10000000bd1.fffffffffffffffe inode 
ffff8800a6251d88
ceph:ceph:  handle_cap_grant inode ffff8800a6251d88 cap ffff8800a635b780 
mds0 seq 28 pAsLsXsFr
ceph:ceph:   size 4294967296 max_size 8594128896, i_size 4294967296
ceph:ceph:  try_nonblocking_invalidate ffff8800a6251d88 success
ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 
issued pAsLsXsFscr
ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 
issued pAsLsXsFscr
ceph:ceph:  ffff8800a6251d88 mode 0100644 uid.gid 0.0
ceph:ceph:   my wanted = pAsxXsxFsxcrwb, used = pFcr, dirty -
ceph:ceph:  revocation: pAsLsXsFscr -> pAsLsXsFr (revoking Fsc)
ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 
issued pAsLsXsFr
ceph:ceph:  check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used pFcr 
dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcrwbl  
AUTHONLY NODELAY
ceph:ceph:   mds0 revoking Fsc
ceph:ceph:  mdsc put_session ffff8800b41c6000 3 -> 2
ceph:ceph:  mdsc con_put ffff8800b41c6000 (2)
ceph:ceph:  aio_read ffff8800a6251d88 10000000bd1.fffffffffffffffe 
dropping cap refs on Fcr = 512
ceph:ceph:  put_cap_refs ffff8800a6251d88 had Fcr last
ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 
issued pAsLsXsFr
ceph:ceph:  check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used pFc 
dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcrwbl 
ceph:ceph:  check_caps trying to invalidate on ffff8800a6251d88
ceph:ceph:  try_nonblocking_invalidate ffff8800a6251d88 failed
ceph:ceph:  check_caps queuing invalidate

--> this means queue_invalidate = 1, and check_caps will call 
ceph_queue_invalidate on exit, which will always print something...

ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 issued pAsLsXsFr
ceph:ceph:  check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used pFc 
dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcrwbl 
ceph:ceph:   mds0 revoking Fsc
ceph:ceph:  __cap_delay_cancel ffff8800a6251d88

...but that never happens.  Probably the CPU got blocked somewhere?  Can 
you see what the system is doing at this point?  sysrq-t, or check the 
process list for ceph-msgr and cat it's stack (/proc/$pid/stack)?  The 
task should be blocked in ceph_check_caps() somewhere...

(BTW, if you're building your own kernel, one thing that I've found 
helpful is enabling the CONFIG_PRINTK_TIME option in .config, and updating 
kernel/printk.c to also include current->pid in the line prefix.  That 
helps sort out what tasks are doing what when.  But if you're stuck on 
2.6.32 for some reason that probably not the case!)

Thanks!
sage
