From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Sat, 9 Oct 2010 02:13:27 +1300
Message-ID: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:64586 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab0JHNNe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 09:13:34 -0400
Received: by fxm14 with SMTP id 14so375259fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Oct 2010 06:13:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

> Hmmm. I just noticed that IsHeapProfilerRunning is actually the secon=
d
> tcmalloc profiler function to get referenced in that #if block. Can
> you comment out just that one line and let me know if that lets it
> compile?
I've also removed libgoogle-perf and reinstalled, but still the same
error, so I followed your suggestion,
I've removed that line in cosd, and as well as cmds, now it compiles
and seems working.
Just unsure why IsHeapProfilerRunning is not detected?

Also, I'm still getting the terrible performance, running dbench -t20
20 shows 11MB/s.
I've also tried on other disks, too. Do you think it is because the
=46use does not have -o direct_io or big_writes support?
Setting the journal wasn't much of difference, something seems to be
fundamentally slow.
Again, I'm running on the simplest setup, just 1OSD (1TB), 1MDS, 1MON.
all following the quick start guide.
How do others get in their performance?
Also, I keep getting unknown freezes when benchmarking and file copying=
=2E

So this time, I've set everything on a single high-end rackmount,
ubuntu 10.04.1 x64.
Maybe this could be due to the 2.6.32 kernel, so I decided update to 2.=
6.35.7.
I'd thought that the ceph-client would be there by default, but the
somehow ceph mount hangs,
so I just git the latest ceph-client-standalone, set to the master and
did the make. I get

WARNING: "account_page_dirtied"
[/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!
  LD [M]  /home/aaa/ceph/ceph-client-standalone/ceph.ko
make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-gene=
ric'

So when I tried to modprobe ceph, I get
=46ATAL: Error inserting ceph
(/lib/modules/2.6.35-02063507-generic/extra/ceph.ko): Unknown symbol
in module, or unknown parameter (see dmesg)

dmesg just shows "ceph: Unknown symbol account_page_dirtied (err 0)"

=46or "unstable" branch, I get lots of errors starting from

make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-gen=
eric'
  CC [M]  /home/aaa/ceph/ceph-client-standalone/super.o
/home/aaa/ceph/ceph-client-standalone/super.c:2:35: error:
linux/ceph/ceph_debug.h: No such file or directory
In file included from /home/aaa/ceph/ceph-client-standalone/super.c:18:
/home/aaa/ceph/ceph-client-standalone/super.h:17:32: error:
linux/ceph/libceph.h: No such file or directory
In file included from /home/aaa/ceph/ceph-client-standalone/super.c:18:
/home/aaa/ceph/ceph-client-standalone/super.h: In function =91ceph_put_=
cap_snap=92:
/home/aaa/ceph/ceph-client-standalone/super.h:153: error: implicit
declaration of function =91ceph_buffer_put=92
/home/aaa/ceph/ceph-client-standalone/super.h: At top level:
/home/aaa/ceph/ceph-client-standalone/super.h:234: error: field
=91i_vino=92 has incomplete type
=2E..

unstable-backport is the only thing that seems to modprobed,
however it gives "failed to parse ceph_options" when I tried to mount..

Thank a lot.

On Fri, Oct 8, 2010 at 5:17 AM, Gregory Farnum <gregf@hq.newdream.net> =
wrote:
> On Thu, Oct 7, 2010 at 3:48 AM, DongJin Lee <dongjin.lee@auckland.ac.=
nz> wrote:
>>> Hmmm -- it looks like the scripts are split on whether you have
>>> tcmalloc installed in your system, and I don't see any obvious issu=
es
>>> when I go over them. Do you have tcmalloc installed? Did you try a
>>> "make clean; make" cycle?
>>
>> Sadly, I still get the error in some of other PCs.
>> cosd.cc: In function =91int main(int, const char**)=92:
>> cosd.cc:65: error: =91IsHeapProfilerRunning=92 was not declared in t=
his scope
>> cosd.cc:310: warning: ignoring return value of =91int chdir(const
>> char*)=92, declared with attribute warn_unused_result
>> make[2]: *** [cosd-cosd.o] Error 1
> Hmmm. I just noticed that IsHeapProfilerRunning is actually the secon=
d
> tcmalloc profiler function to get referenced in that #if block. Can
> you comment out just that one line and let me know if that lets it
> compile?
> IsHeapProfilerRunning has been in the profiler since 2008, but the
> prototype changed this year to return an int instead of a bool, so
> maybe your installed libraries and header don't match?
> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
