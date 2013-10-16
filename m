From: Sage Weil <sage@inktank.com>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Wed, 16 Oct 2013 09:16:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55464 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3JPQQd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 12:16:33 -0400
In-Reply-To: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: linux-lvm@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi,

On Wed, 16 Oct 2013, Ugis wrote:
> Hello ceph&LVM communities!
> 
> I noticed very slow reads from xfs mount that is on ceph
> client(rbd+gpt partition+LVM PV + xfs on LE)
> To find a cause I created another rbd in the same pool, formatted it
> straight away with xfs, mounted.
> 
> Write performance for both xfs mounts is similar ~12MB/s
> 
> reads with "dd if=/mnt/somefile bs=1M | pv | dd of=/dev/null" as follows:
> with LVM ~4MB/s
> pure xfs ~30MB/s
> 
> Watched performance while doing reads with atop. In LVM case atop
> shows LVM overloaded:
> LVM | s-LV_backups  | busy     95% |  read   21515 | write      0  |
> KiB/r      4 |               | KiB/w      0 |  MBr/s   4.20 | MBw/s
> 0.00  | avq     1.00 |  avio 0.85 ms |
> 
> client kernel 3.10.10
> ceph version 0.67.4
> 
> My considerations:
> I have expanded rbd under LVM couple of times(accordingly expanding
> gpt partition, PV,VG,LV, xfs afterwards), but that should have no
> impact on performance(tested clean rbd+LVM, same read performance as
> for expanded one).
> 
> As with device-mapper, after LVM is initialized it is just a small
> table with LE->PE  mapping that should reside in close CPU cache.
> I am guessing this could be related to old CPU used, probably caching
> near CPU does not work well(I tested also local HDDs with/without LVM
> and got read speed ~13MB/s vs 46MB/s with atop showing same overload
> in  LVM case).
> 
> What could make so great difference when LVM is used and what/how to
> tune? As write performance does not differ, DM extent lookup should
> not be lagging, where is the trick?

My first guess is that LVM is shifting the content of hte device such that 
it no longer aligns well with the RBD striping (by default, 4MB).  The 
non-aligned reads/writes would need to touch two objects instead of 
one, and dd is generally doing these synchronously (i.e., lots of 
waiting).

I'm not sure what options LVM provides for aligning things to the 
underlying storage...

sage


> 
> CPU used:
> # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 4
> model name      : Intel(R) Xeon(TM) CPU 3.20GHz
> stepping        : 10
> microcode       : 0x2
> cpu MHz         : 3200.077
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 1
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 5
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr ss
>                                                        e sse2 ss ht tm
> pbe syscall nx lm constant_tsc pebs bts nopl pni dtes64 monitor ds_cpl
> cid cx16 xtpr lahf_lm
> bogomips        : 6400.15
> clflush size    : 64
> cache_alignment : 128
> address sizes   : 36 bits physical, 48 bits virtual
> power management:
> 
> Br,
> Ugis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
