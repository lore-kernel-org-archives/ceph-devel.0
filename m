From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Fri, 8 Oct 2010 12:05:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33026 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab0JHTDI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 15:03:08 -0400
In-Reply-To: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

On Sat, 9 Oct 2010, DongJin Lee wrote:

> > Hmmm. I just noticed that IsHeapProfilerRunning is actually the second
> > tcmalloc profiler function to get referenced in that #if block. Can
> > you comment out just that one line and let me know if that lets it
> > compile?
>
> I've also removed libgoogle-perf and reinstalled, but still the same
> error, so I followed your suggestion,
> I've removed that line in cosd, and as well as cmds, now it compiles
> and seems working.
> Just unsure why IsHeapProfilerRunning is not detected?

Yeah, it's still a mystery, especially given that the line above it 
references another libgoogle-perf symbol and doesn't throw an error.  It 
really sounds like some mismatched versions or stray headers/libraries on 
your system.

> Also, I'm still getting the terrible performance, running dbench -t20
> 20 shows 11MB/s.
> I've also tried on other disks, too. Do you think it is because the
> Fuse does not have -o direct_io or big_writes support?
> Setting the journal wasn't much of difference, something seems to be
> fundamentally slow.
> Again, I'm running on the simplest setup, just 1OSD (1TB), 1MDS, 1MON.
> all following the quick start guide.
> How do others get in their performance?

I see similar numbers when I do my testing on a single machine (kenrel 
client running under UML).  The limitation with dbench, remember, is the 
round trip time to the MDS on each metadata update (create, unlink, 
rename, etc.).  The "bandwidth" is meaningless, as most of that data 
probably doesn't even end up going to disk, and data throughput (writes to 
the OSD) is not the bottleneck.

Just to be clear, are you using the kernel client in this case, or cfuse?  
Generally speaking the kernel is better optimized and faster.

> Also, I keep getting unknown freezes when benchmarking and file copying.

What kind of freezes?  Do they resolve themselves?

> So this time, I've set everything on a single high-end rackmount,
> ubuntu 10.04.1 x64.
> Maybe this could be due to the 2.6.32 kernel, so I decided update to 2.6.35.7.
> I'd thought that the ceph-client would be there by default, but the
> somehow ceph mount hangs,

Anything in dmesg?  The client in 2.6.35 should work out of the box.

> so I just git the latest ceph-client-standalone, set to the master and
> did the make. I get
> 
> WARNING: "account_page_dirtied"
> [/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!
>   LD [M]  /home/aaa/ceph/ceph-client-standalone/ceph.ko
> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-generic'
> 
> So when I tried to modprobe ceph, I get
> FATAL: Error inserting ceph
> (/lib/modules/2.6.35-02063507-generic/extra/ceph.ko): Unknown symbol
> in module, or unknown parameter (see dmesg)
> 
> dmesg just shows "ceph: Unknown symbol account_page_dirtied (err 0)"

This symbol was introduced for 2.6.36; you need master-backport.

> For "unstable" branch, I get lots of errors starting from
> 
> make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-generic'
>   CC [M]  /home/aaa/ceph/ceph-client-standalone/super.o
> /home/aaa/ceph/ceph-client-standalone/super.c:2:35: error:
> linux/ceph/ceph_debug.h: No such file or directory
> In file included from /home/aaa/ceph/ceph-client-standalone/super.c:18:
> /home/aaa/ceph/ceph-client-standalone/super.h:17:32: error:
> linux/ceph/libceph.h: No such file or directory
> In file included from /home/aaa/ceph/ceph-client-standalone/super.c:18:
> /home/aaa/ceph/ceph-client-standalone/super.h: In function ?ceph_put_cap_snap?:
> /home/aaa/ceph/ceph-client-standalone/super.h:153: error: implicit
> declaration of function ?ceph_buffer_put?
> /home/aaa/ceph/ceph-client-standalone/super.h: At top level:
> /home/aaa/ceph/ceph-client-standalone/super.h:234: error: field
> ?i_vino? has incomplete type
> ...
> 
> unstable-backport is the only thing that seems to modprobed,
> however it gives "failed to parse ceph_options" when I tried to mount..

You definitely need to use one of the -backport branches, unless you're 
running on the latest kernel (the master and unstable branches don't 
include any backport code).  The master-backport is probably the best 
choice, as unstable is in a bit of limbo pending the upcoming merge 
window, rbd, and some reorganization of the code into mulitple modules 
(libceph, ceph, rbd).

sage

> 
> Thank a lot.
> 
> On Fri, Oct 8, 2010 at 5:17 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> > On Thu, Oct 7, 2010 at 3:48 AM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
> >>> Hmmm -- it looks like the scripts are split on whether you have
> >>> tcmalloc installed in your system, and I don't see any obvious issues
> >>> when I go over them. Do you have tcmalloc installed? Did you try a
> >>> "make clean; make" cycle?
> >>
> >> Sadly, I still get the error in some of other PCs.
> >> cosd.cc: In function ?int main(int, const char**)?:
> >> cosd.cc:65: error: ?IsHeapProfilerRunning? was not declared in this scope
> >> cosd.cc:310: warning: ignoring return value of ?int chdir(const
> >> char*)?, declared with attribute warn_unused_result
> >> make[2]: *** [cosd-cosd.o] Error 1
> > Hmmm. I just noticed that IsHeapProfilerRunning is actually the second
> > tcmalloc profiler function to get referenced in that #if block. Can
> > you comment out just that one line and let me know if that lets it
> > compile?
> > IsHeapProfilerRunning has been in the profiler since 2008, but the
> > prototype changed this year to return an int instead of a bool, so
> > maybe your installed libraries and header don't match?
> > -Greg
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
