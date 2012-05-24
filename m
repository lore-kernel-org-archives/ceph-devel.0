From: Felix Feinhals <ff@turtle-entertainment.de>
Subject: Re: MDS crash, wont startup again
Date: Thu, 24 May 2012 14:29:58 +0200
Message-ID: <CA+WUqKxKPTArjxy-sceuAy9eN7mQJ=jU-9_dRQuQAbUd-4aFHQ@mail.gmail.com>
References: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com>
 <CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com>
 <4FB56FD1.5090805@inktank.com> <CA+WUqKz5HQ77p7TYxJhiOPfY6Tm+12O+FRFr19ra6t9bZb6YSg@mail.gmail.com>
 <CAPYLRzjTs19air=7cT3PGSWiHGFUyKuTeX9OHzTBfBPyMXan+g@mail.gmail.com>
 <CA+WUqKyH6bro4u-PXoKC0WEi37bn85YaG8jxi9SZ+fvpZFx--g@mail.gmail.com>
 <DF93AE65E2C74807A83392C93D9EDA0B@inktank.com> <CA+WUqKy2DrEM90HrSF8ju68gjLhVv3TWEFTb68fi+5GpifOLTg@mail.gmail.com>
 <CAPYLRzhGQscvJ1g73OwJ8ENKog-CtMp03a3LtB2e+bXSD0Eecg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32812 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756751Ab2EXMaP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 08:30:15 -0400
Received: by lbbgm6 with SMTP id gm6so5821342lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 05:30:14 -0700 (PDT)
In-Reply-To: <CAPYLRzhGQscvJ1g73OwJ8ENKog-CtMp03a3LtB2e+bXSD0Eecg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

i was using the Debian Packages, but i tried now from source.
I used the same version from GIT
(cb7f1c9c7520848b0899b26440ac34a8acea58d1) and compiled it. Same crash
report.
Then i applied your patch but again the same crash, i think the
backtrace is also the same:

 (gdb) thread 1
[Switching to thread 1 (Thread 9564)]#0  0x00007f33a3e58ebb in raise
(sig=3D<value optimized out>)
    at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
41      in ../nptl/sysdeps/unix/sysv/linux/pt-raise.c
(gdb) backtrace
#0  0x00007f33a3e58ebb in raise (sig=3D<value optimized out>)
    at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
#1  0x000000000081423e in reraise_fatal (signum=3D11) at
global/signal_handler.cc:58
#2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc:104
#3  <signal handler called>
#4  SnapRealm::have_past_parents_open (this=3D0x0, first=3D..., last=3D=
=2E..)
at mds/snap.cc:112
#5  0x000000000055d58b in MDCache::check_realm_past_parents
(this=3D0x27a7200, realm=3D0x0)
    at mds/MDCache.cc:4495
#6  0x0000000000572eec in
MDCache::choose_lock_states_and_reconnect_caps (this=3D0x27a7200)
    at mds/MDCache.cc:4533
#7  0x00000000005931a0 in MDCache::rejoin_gather_finish
(this=3D0x27a7200) at mds/MDCache.cc:4444
#8  0x000000000059b9d5 in MDCache::rejoin_send_rejoins
(this=3D0x27a7200) at mds/MDCache.cc:3388
#9  0x00000000004a8721 in MDS::rejoin_joint_start (this=3D0x27bc000) at
mds/MDS.cc:1404
#10 0x00000000004c253a in MDS::handle_mds_map (this=3D0x27bc000,
m=3D<value optimized out>)
    at mds/MDS.cc:968
#11 0x00000000004c4513 in MDS::handle_core_message (this=3D0x27bc000,
m=3D0x27ab800) at mds/MDS.cc:1651
#12 0x00000000004c45ef in MDS::_dispatch (this=3D0x27bc000, m=3D0x27ab8=
00)
at mds/MDS.cc:1790
#13 0x00000000004c628b in MDS::ms_dispatch (this=3D0x27bc000,
m=3D0x27ab800) at mds/MDS.cc:1602
#14 0x0000000000732609 in Messenger::ms_deliver_dispatch
(this=3D0x279f680) at msg/Messenger.h:178
#15 SimpleMessenger::dispatch_entry (this=3D0x279f680) at
msg/SimpleMessenger.cc:363
#16 0x00000000007207ad in SimpleMessenger::DispatchThread::entry() ()
#17 0x00007f33a3e508ca in start_thread (arg=3D<value optimized out>) at
pthread_create.c:300
#18 0x00007f33a26d892d in clone () at
=2E./sysdeps/unix/sysv/linux/x86_64/clone.S:112
#19 0x0000000000000000 in ?? ()

Any more ideas? :)
Or can i get you more debugging output?



2012/5/23 Gregory Farnum <greg@inktank.com>:
> On Wed, May 23, 2012 at 5:28 AM, Felix Feinhals
> <ff@turtle-entertainment.de> wrote:
>> Hey,
>>
>> ok i installed libc-dbg and run your commands now this comes up:
>>
>> gdb /usr/bin/ceph-mds core
>>
>> snip
>>
>> GNU gdb (GDB) 7.0.1-debian
>> Copyright (C) 2009 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/=
gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law. =A0Type "show =
copying"
>> and "show warranty" for details.
>> This GDB was configured as "x86_64-linux-gnu".
>> For bug reporting instructions, please see:
>> <http://www.gnu.org/software/gdb/bugs/>...
>> Reading symbols from /usr/bin/ceph-mds...Reading symbols from
>> /usr/lib/debug/usr/bin/ceph-mds...done.
>> (no debugging symbols found)...done.
>> [New Thread 22980]
>> [New Thread 22984]
>> [New Thread 22986]
>> [New Thread 22979]
>> [New Thread 22970]
>> [New Thread 22981]
>> [New Thread 22971]
>> [New Thread 22976]
>> [New Thread 22973]
>> [New Thread 22975]
>> [New Thread 22974]
>> [New Thread 22972]
>> [New Thread 22978]
>> [New Thread 22982]
>>
>> warning: Can't read pathname for load map: Input/output error.
>> Reading symbols from /lib/libpthread.so.0...Reading symbols from
>> /usr/lib/debug/lib/libpthread-2.11.3.so...done.
>> (no debugging symbols found)...done.
>> Loaded symbols for /lib/libpthread.so.0
>> Reading symbols from /usr/lib/libcrypto++.so.8...(no debugging symbo=
ls
>> found)...done.
>> Loaded symbols for /usr/lib/libcrypto++.so.8
>> Reading symbols from /lib/libuuid.so.1...(no debugging symbols found=
)...done.
>> Loaded symbols for /lib/libuuid.so.1
>> Reading symbols from /lib/librt.so.1...Reading symbols from
>> /usr/lib/debug/lib/librt-2.11.3.so...done.
>> (no debugging symbols found)...done.
>> Loaded symbols for /lib/librt.so.1
>> Reading symbols from /usr/lib/libtcmalloc.so.0...(no debugging symbo=
ls
>> found)...done.
>> Loaded symbols for /usr/lib/libtcmalloc.so.0
>> Reading symbols from /usr/lib/libstdc++.so.6...(no debugging symbols
>> found)...done.
>> Loaded symbols for /usr/lib/libstdc++.so.6
>> Reading symbols from /lib/libm.so.6...Reading symbols from
>> /usr/lib/debug/lib/libm-2.11.3.so...done.
>> (no debugging symbols found)...done.
>> Loaded symbols for /lib/libm.so.6
>> Reading symbols from /lib/libgcc_s.so.1...(no debugging symbols foun=
d)...done.
>> Loaded symbols for /lib/libgcc_s.so.1
>> Reading symbols from /lib/libc.so.6...Reading symbols from
>> /usr/lib/debug/lib/libc-2.11.3.so...done.
>> (no debugging symbols found)...done.
>> Loaded symbols for /lib/libc.so.6
>> Reading symbols from /lib64/ld-linux-x86-64.so.2...Reading symbols
>> from /usr/lib/debug/lib/ld-2.11.3.so...done.
>> (no debugging symbols found)...done.
>> Loaded symbols for /lib64/ld-linux-x86-64.so.2
>> Reading symbols from /usr/lib/libunwind.so.7...(no debugging symbols
>> found)...done.
>> Loaded symbols for /usr/lib/libunwind.so.7
>> Core was generated by `/usr/bin/ceph-mds -i c --pid-file
>> /var/run/ceph/mds.c.pid -c /etc/ceph/ceph.con'.
>> Program terminated with signal 11, Segmentation fault.
>> #0 =A00x00007f10c00d2ebb in raise (sig=3D<value optimized out>) at
>> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
>> 41 =A0 =A0 =A0../nptl/sysdeps/unix/sysv/linux/pt-raise.c: No such fi=
le or directory.
>> =A0 =A0 =A0 =A0in ../nptl/sysdeps/unix/sysv/linux/pt-raise.c
>>
>> snip
>>
>> Now
>>
>> thread apply all bt
>>
>> ...
>>
>> thread 1
>> [Switching to thread 1 (Thread 22977)]#0 =A00x00007f10c00d2ebb in ra=
ise
>> (sig=3D<value optimized out>) at
>> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
>> 41 =A0 =A0 =A0in ../nptl/sysdeps/unix/sysv/linux/pt-raise.c
>>
>>
>> Thread 1 (Thread 22977):
>> ---Type <return> to continue, or q <return> to quit---
>> #0 =A00x00007f10c00d2ebb in raise (sig=3D<value optimized out>) at
>> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
>> #1 =A00x000000000081469e in reraise_fatal (signum=3D11) at
>> global/signal_handler.cc:58
>> #2 =A0handle_fatal_signal (signum=3D11) at global/signal_handler.cc:=
104
>> #3 =A0<signal handler called>
>> #4 =A0SnapRealm::have_past_parents_open (this=3D0x0, first=3D..., la=
st=3D...)
>> at mds/snap.cc:112
>>
>> #5 =A00x000000000055d58b in MDCache::check_realm_past_parents
>> (this=3D0x2b49200, realm=3D0x0) at mds/MDCache.cc:4495
>> #6 =A00x0000000000572eec in
>> MDCache::choose_lock_states_and_reconnect_caps (this=3D0x2b49200) at
>> mds/MDCache.cc:4533
>> #7 =A00x00000000005931a0 in MDCache::rejoin_gather_finish
>> (this=3D0x2b49200) at mds/MDCache.cc:4444
>> #8 =A00x000000000059b9d5 in MDCache::rejoin_send_rejoins
>> (this=3D0x2b49200) at mds/MDCache.cc:3388
>> #9 =A00x00000000004a8721 in MDS::rejoin_joint_start (this=3D0x2b5e00=
0) at
>> mds/MDS.cc:1404
>> #10 0x00000000004c253a in MDS::handle_mds_map (this=3D0x2b5e000,
>> m=3D<value optimized out>) at mds/MDS.cc:968
>> #11 0x00000000004c4513 in MDS::handle_core_message (this=3D0x2b5e000=
,
>> m=3D0x2b4d800) at mds/MDS.cc:1651
>> #12 0x00000000004c45ef in MDS::_dispatch (this=3D0x2b5e000, m=3D0x2b=
4d800)
>> at mds/MDS.cc:1790
>> #13 0x00000000004c628b in MDS::ms_dispatch (this=3D0x2b5e000,
>> m=3D0x2b4d800) at mds/MDS.cc:1602
>> #14 0x00000000007acb49 in Messenger::ms_deliver_dispatch
>> (this=3D0x2b41680) at msg/Messenger.h:178
>> #15 SimpleMessenger::dispatch_entry (this=3D0x2b41680) at
>> msg/SimpleMessenger.cc:363
>> #16 0x00000000007336ed in SimpleMessenger::DispatchThread::entry() (=
)
>> #17 0x00007f10c00ca8ca in start_thread (arg=3D<value optimized out>)=
 at
>> pthread_create.c:300
>> #18 0x00007f10be95292d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
>> #19 0x0000000000000000 in ?? ()
>>
>> So i wonder is the crash because of the missing file message?
>
> Okay, that is what I wanted. It looks like it can't find the
> snaprealm, and I have a pretty good guess why.
> If you're building your own binaries, you can apply the patch below
> and I bet things will work. (Let me know if they do or don't!)
> -Greg
>
>
> diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
> index 70faeb8..becccf5 100644
> --- a/src/mds/CInode.cc
> +++ b/src/mds/CInode.cc
> @@ -2130,7 +2130,7 @@ SnapRealm *CInode::find_snaprealm()
> =A0 while (!cur->snaprealm) {
> =A0 =A0 if (cur->get_parent_dn())
> =A0 =A0 =A0 cur =3D cur->get_parent_dn()->get_dir()->get_inode();
> - =A0 =A0else if (get_projected_parent_dn())
> + =A0 =A0else if (cur->get_projected_parent_dn())
> =A0 =A0 =A0 cur =3D cur->get_projected_parent_dn()->get_dir()->get_in=
ode();
> =A0 =A0 else
> =A0 =A0 =A0 break;
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
