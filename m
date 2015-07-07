From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: trying to compile with-jemalloc but ceph-osd is still linked
 to libtcmalloc
Date: Tue, 07 Jul 2015 11:17:34 +0200
Message-ID: <559B992E.4050005@profihost.ag>
References: <5596529F.8060709@profihost.ag> <EA545303A8F8E842820A172C3D641D6E1B076636@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:47281 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513AbbGGJRg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 05:17:36 -0400
In-Reply-To: <EA545303A8F8E842820A172C3D641D6E1B076636@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shishir Gowda <Shishir.Gowda@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 07.07.2015 um 09:56 schrieb Shishir Gowda:
> Hi Stefan,
> 
> I built it with ./configure --without-tcmalloc and --with-jemalloc, and resulting binaries are not being linked with tcmalloc.

It works for me if i remove the google perftools dev package. But if it
is installed hammer always builds against tcmalloc.

> ldd src/ceph-osd
>         linux-vdso.so.1 =>  (0x00007fff2a5fe000)
>         libjemalloc.so.1 => /usr/lib/x86_64-linux-gnu/libjemalloc.so.1 (0x00007f99d1c7b000)
>         libaio.so.1 => /lib/x86_64-linux-gnu/libaio.so.1 (0x00007f99d1a79000)
>         libleveldb.so.1 => /usr/lib/x86_64-linux-gnu/libleveldb.so.1 (0x00007f99d182b000)
>         liblttng-ust.so.0 => /usr/lib/x86_64-linux-gnu/liblttng-ust.so.0 (0x00007f99d15dc000)
>         libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f99d13be000)
>         libcrypto++.so.9 => /usr/lib/libcrypto++.so.9 (0x00007f99d0cc1000)
>         libuuid.so.1 => /lib/x86_64-linux-gnu/libuuid.so.1 (0x00007f99d0abc000)
>         libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f99d08b8000)
>         libboost_thread.so.1.54.0 => /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.54.0 (0x00007f99d06a1000)
>         librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f99d0499000)
>         libboost_system.so.1.54.0 => /usr/lib/x86_64-linux-gnu/libboost_system.so.1.54.0 (0x00007f99d0295000)
>         libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f99cff90000)
>         libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f99cfc8a000)
>         libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f99cfa74000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f99cf6ae000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007f99d1ec2000)
>         libsnappy.so.1 => /usr/lib/libsnappy.so.1 (0x00007f99cf4a8000)
>         liblttng-ust-tracepoint.so.0 => /usr/lib/x86_64-linux-gnu/liblttng-ust-tracepoint.so.0 (0x00007f99cf28e000)
>         liburcu-bp.so.2 => /usr/lib/x86_64-linux-gnu/liburcu-bp.so.2 (0x00007f99cf086000)
>         liburcu-cds.so.2 => /usr/lib/x86_64-linux-gnu/liburcu-cds.so.2 (0x00007f99cee7f000)
> 
> I tried it with upstream master, what branch are you using.
> 
> With regards,
> Shishir
> 
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Stefan Priebe
>> Sent: Friday, July 03, 2015 2:45 PM
>> To: ceph-devel@vger.kernel.org
>> Subject: trying to compile with-jemalloc but ceph-osd is still linked to
>> libtcmalloc
>>
>> Hi,
>>
>> i'm trying to compile current hammer with-jemalloc.
>>
>> configure .. --without-tcmalloc --with-jemalloc
>>
>> but resulting ceph-osd is still linked against tcmalloc:
>> ldd /usr/bin/ceph-osd
>>          linux-vdso.so.1 =>  (0x00007fffbf3b9000)
>>          libjemalloc.so.1 => /usr/lib/x86_64-linux-gnu/libjemalloc.so.1
>> (0x00007fc44bc25000)
>>          libaio.so.1 => /lib/x86_64-linux-gnu/libaio.so.1
>> (0x00007fc44ba23000)
>>          libleveldb.so.1 => /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>> (0x00007fc44b7d2000)
>>          libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
>> (0x00007fc44b5b6000)
>>          libcrypto++.so.9 => /usr/lib/libcrypto++.so.9 (0x00007fc44aea8000)
>>          libuuid.so.1 => /lib/x86_64-linux-gnu/libuuid.so.1
>> (0x00007fc44aca2000)
>>          libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fc44aa9e000)
>>          libboost_thread.so.1.49.0 => /usr/lib/libboost_thread.so.1.49.0
>> (0x00007fc44aa81000)
>>          librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fc44a878000)
>>          libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>> (0x00007fc44a571000)
>>          libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fc44a2ef000)
>>          libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1
>> (0x00007fc44a0d8000)
>>          libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc449d4d000)
>>          /lib64/ld-linux-x86-64.so.2 (0x00007fc44be65000)
>>          libsnappy.so.1 => /usr/lib/libsnappy.so.1 (0x00007fc449b47000)
>>          libtcmalloc.so.4 => /usr/lib/libtcmalloc.so.4 (0x00007fc4498d4000)
>>          libunwind.so.7 => /usr/lib/libunwind.so.7 (0x00007fc4496bb000)
>>
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
