From: Sage Weil <sage@inktank.com>
Subject: Re: syncfs via syscall doesn not work
Date: Sat, 24 Nov 2012 15:20:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211241519580.23552@cobra.newdream.net>
References: <50AF31AB.1050402@profihost.ag> <alpine.DEB.2.00.1211231907330.23552@cobra.newdream.net> <7D302B0D-898C-45F6-A60A-A43DB78C7479@profihost.ag> <alpine.DEB.2.00.1211240859340.23552@cobra.newdream.net> <50B12D01.3030308@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35539 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab2KXXUy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 18:20:54 -0500
In-Reply-To: <50B12D01.3030308@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 24 Nov 2012, Stefan Priebe wrote:
> Am 24.11.2012 18:16, schrieb Sage Weil:
> > On Sat, 24 Nov 2012, Stefan Priebe - Profihost AG wrote:
> > > At the machine compiling? Yes!
> > 
> > Hmm, I just tested on my wonky wheezy machine (glibc 2.13, 3.2) and
> > system(SYS_syncfs, ..) works for me.  But the #define is in libc6-dev:
> 
> But that means your glibc supports it. Then we don't need the syscall at 
> all.
>
> To me it's only present in the kernel headers (linux-libc-dev) like 
> this:
> 
> [pb64: ~]# grep -r syncfs /usr/include
> /usr/include/asm/unistd_64.h:#define __NR_syncfs      306
> /usr/include/asm/unistd_64.h:__SYSCALL(__NR_syncfs, sys_syncfs)
> /usr/include/asm/unistd_32.h:#define __NR_syncfs             344
> /usr/include/asm-generic/unistd.h:#define __NR_syncfs 267
> /usr/include/asm-generic/unistd.h:__SYSCALL(__NR_syncfs, sys_syncfs)

Can try wip-syncfs?  It checks for either SYS_syncfs or __NR_syncfs.

sage
