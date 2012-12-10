From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] e6a154: osx: compile on OSX
Date: Mon, 10 Dec 2012 09:01:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212100901110.17288@cobra.newdream.net>
References: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail> <4685D39E3A8A4352B08C753D91FC4A5A@inktank.com> <sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie> <CA+Hcz5-z4=aYGaTb3tU28B0Qanb=a+iR+yq_RKqc9EVsJZ-GAQ@mail.gmail.com>
 (sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie) <C29C365E-91F0-46D8-8559-99BF78E0B098@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35974 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2LJRBa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 12:01:30 -0500
In-Reply-To: <C29C365E-91F0-46D8-8559-99BF78E0B098@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: Noah Watkins <noah.watkins@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Mon, 10 Dec 2012, Jimmy Tang wrote:
> 
> On 9 Dec 2012, at 18:22, Noah Watkins wrote:
> 
> > On Sun, Dec 9, 2012 at 10:05 AM, Gregory Farnum <greg@inktank.com> wrote:
> >> Oooh, very nice! Do you have a list of the dependencies that you actually needed to install?
> > 
> > I can put that together. They were boost, gperf, fuse4x, cryptopp. I
> > think that might have been it.
> > 
> 
> Is libaio really needed to build ceph-fuse? I use macports on my system 
> and the last time I tried to make a change set to let ceph/ceph-fuse 
> build on my laptop failed as I didn't have libaio, though I could just 
> write a port for it.

libaio is only used by ceph-osd.  Not needed by fuse.

sage


> 
> >> Apart from breaking this up into smaller patches, we'll also want to reformat some of it. Rather than sticking an #if APPLE on top of every spin lock, we should have utility functions that do this for us. ;)
> > 
> > Definitely. OSX has spinlock implementations for user space, but it's
> > going to take some reading. For example, spinlocks in Ceph are
> > initialized for shared memory, rather than the default private. It
> > isn't clear from documentation what the semantics are of OSX
> > spinlocks, nor is it clear if the shared memory attribute is needed.
> > 
> >> Also, we should be able to find libatomic_ops for OS X (its parent project works under OS X), and we can use that to construct a spin lock if we think it'll be useful. I'm not too sure how effective its muteness are at spinlock-y workloads.
> > 
> > This patch set uses the OSX atomic inc/dec ops, rather than spinlocks.
> > 
> > Another fun fact:
> > 
> > msg/Pipe.cc and common/pipe.c are compiled into libcommon_la-Pipe.o
> > and libcommon_la-pipe.o, but HFS+ is case-insensitive by default.
> > Result is duplicate symbols. That took a while to figure out :P
> > 
> 
> good catch, that might explain why my last look at ceph on osx failed so miserably.
> 
> 
> Jimmy.
> 
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI)
> Trinity Centre for High Performance Computing,
> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie
> Tel: +353-1-896-3847
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
