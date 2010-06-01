From: Sage Weil <sage@newdream.net>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Tue, 1 Jun 2010 10:28:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net>
References: <20100531125156.GJ1211@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60767 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab0FAR2Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 13:28:16 -0400
In-Reply-To: <20100531125156.GJ1211@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ceph-devel@vger.kernel.org

Hi Andre,

On Mon, 31 May 2010, Andre Noll wrote:
> we're trying to give ceph a try on our compute cluster Initial stress
> tests passed without problems,

Cool!

> but over the weekend a couple of cosd processes died and now access to 
> the ceph mount point blocks and mounting the ceph dir fails with

Hmm :(

> Stracing the cosd process shows that it calls mmap() with silly values
> for the "fd" and the "length" parameter:
> 
> 	mmap(NULL, 18446744073709436928, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)

So, the mmap code in buffer.h is actually never called, so my guess is 
that posix_memalign() or some other library implementation is doing it.  
Can you get a stack trace?  Either look at the core file with gdb or run 
cosd via gdb?  Alternatively, the osd startup log with

	debug osd = 20
	debug filestore = 20

in the [osd] section of ceph.conf would help narrow it down.  There is 
probably a missing check in the osd mount/initialization code but it's 
hard to guess where.

Thanks!
sage



> 
> I briefly looked at the source code and noticed that raw_mmap_pages()
> in include/buffer.h of seems to call mmap() with an unsigned int
> rather than with a size_t as the second (length) parameter. Since
> 
> 	18446744073709436928 = 0xfffffffffffe4000
> 
> this looks like an integer overflow. But maybe it is just uninitialized
> garbage.
> 
> I've tried the v0.20.2 and the testing branch of the ceph git
> repo. Both versions of cosd show the same behaviour.
> 
> Our ceph file system 5.5T large, we have 7 cosds, 3 cmons and 3 cmds,
> see the ceph.conf below for details.
> 
> Any idea how to get back the data? If you need further debugging info,
> don't hesitate to ask.
> 
> Thanks
> Andre
> ---
> 
> [global]
> 	; enable secure authentication
> 	auth supported = cephx
> 	osd journal size = 100    ; measured in MB 
> 
> ; You need at least one monitor. You need at least three if you want to
> ; tolerate any node failures. Always create an odd number.
> [mon]
> 	mon data = /var/ceph/mon$id
> 	; some minimal logging (just message traffic) to aid debugging
> 	debug ms = 1
> [mon0]
> 	host = node141
> 	mon addr = 192.168.1.141:6789
> [mon1]
> 	host = node145
> 	mon addr = 192.168.1.145:6789
> [mon2]
> 	host = node150
> 	mon addr = 192.168.1.150:6789
> 
> ; You need at least one mds. Define two to get a standby.
> [mds]
> 	; where the mds keeps it's secret encryption keys
> 	keyring = /var/ceph/keyring.$name
> [mds0]
> 	host = node141
> [mds1]
> 	host = node145
> [mds2]
> 	host = node150
> 
> ; osd
> ;  You need at least one.  Two if you want data to be replicated.
> ;  Define as many as you like.
> [osd]
> 	; This is where the btrfs volume will be mounted.
> 	osd data = /var/ceph/osd$id
> 
> 	; Ideally, make this a separate disk or partition.  A few GB
>  	; is usually enough; more if you have fast disks.  You can use
>  	; a file under the osd data dir if need be
>  	; (e.g. /data/osd$id/journal), but it will be slower than a
>  	; separate disk or partition.
> 	osd journal = /var/ceph/osd$id/journal
> 
> [osd0]
> 	host = node141
> [osd1]
> 	host = node145
> [osd2]
> 	host = node150
> [osd3]
> 	host = node146
> [osd4]
> 	host = node147
> [osd5]
> 	host = node149
> [osd6]
> 	host = node142
> -- 
> The only person who always got his work done by Friday was Robinson Crusoe
> 
