From: Luis Henriques <lhenriques@suse.com>
Subject: Re: =?utf-8?Q?Re=C2=A0=3A?= [ceph-users] general protection fault:
 0000 [#1] SMP
Date: Thu, 12 Oct 2017 14:58:47 +0100
Message-ID: <87lgkgcvs8.fsf@suse.com>
References: <1507732840.2812.10.camel@daevel.fr>
        <CAOi1vP--q8y696g5W_AUmR9Yxe5Xop3BH3xjEQG6_pmQmXO6kA@mail.gmail.com>
        <1507793194.26826.8.camel@daevel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdJLN6u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Oct 2017 09:58:50 -0400
In-Reply-To: <1507793194.26826.8.camel@daevel.fr> (Olivier Bonvalet's message
        of "Thu, 12 Oct 2017 09:26:34 +0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Jeff Layton <jlayton@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Users <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Olivier Bonvalet <ceph.list@daevel.fr> writes:

> Le jeudi 12 octobre 2017 à 09:12 +0200, Ilya Dryomov a écrit :
>> It's a crash in memcpy() in skb_copy_ubufs().  It's not in ceph, but
>> ceph-induced, it looks like.  I don't remember seeing anything
>> similar
>> in the context of krbd.
>> 
>> This is a Xen dom0 kernel, right?  What did the workload look like?
>> Can you provide dmesg before the crash?
>
> Hi,
>
> yes it's a Xen dom0 kernel. Linux 4.13.3, Xen 4.8.2, with an old
> 0.94.10 Ceph (so, Hammer).
>
> Before this error, I add this in logs :
>
> Oct 11 16:00:41 lorunde kernel: [310548.899082] libceph: read_partial_message ffff88021a910200 data crc 2306836368 != exp. 2215155875
> Oct 11 16:00:41 lorunde kernel: [310548.899841] libceph: osd117 10.0.0.31:6804 bad crc/signature
> Oct 11 16:02:25 lorunde kernel: [310652.695015] libceph: read_partial_message ffff880220b10100 data crc 842840543 != exp. 2657161714
> Oct 11 16:02:25 lorunde kernel: [310652.695731] libceph: osd3 10.0.0.26:6804 bad crc/signature
> Oct 11 16:07:24 lorunde kernel: [310952.485202] libceph: read_partial_message ffff88025d1aa400 data crc 938978341 != exp. 4154366769
> Oct 11 16:07:24 lorunde kernel: [310952.485870] libceph: osd117 10.0.0.31:6804 bad crc/signature
> Oct 11 16:10:44 lorunde kernel: [311151.841812] libceph: read_partial_message ffff880260300400 data crc 2988747958 != exp. 319958859
> Oct 11 16:10:44 lorunde kernel: [311151.842672] libceph: osd9 10.0.0.51:6802 bad crc/signature
> Oct 11 16:10:57 lorunde kernel: [311165.211412] libceph: read_partial_message ffff8802208b8300 data crc 369498361 != exp. 906022772
> Oct 11 16:10:57 lorunde kernel: [311165.212135] libceph: osd87 10.0.0.5:6800 bad crc/signature
> Oct 11 16:12:27 lorunde kernel: [311254.635767] libceph: read_partial_message ffff880236f9a000 data crc 2586662963 != exp. 2886241494
> Oct 11 16:12:27 lorunde kernel: [311254.636493] libceph: osd90 10.0.0.5:6814 bad crc/signature
> Oct 11 16:14:31 lorunde kernel: [311378.808191] libceph: read_partial_message ffff88027e633c00 data crc 1102363051 != exp. 679243837
> Oct 11 16:14:31 lorunde kernel: [311378.808889] libceph: osd13 10.0.0.21:6804 bad crc/signature
> Oct 11 16:15:01 lorunde kernel: [311409.431034] libceph: read_partial_message ffff88024ce0a800 data crc 2467415342 != exp. 1753860323
> Oct 11 16:15:01 lorunde kernel: [311409.431718] libceph: osd111 10.0.0.30:6804 bad crc/signature
> Oct 11 16:15:11 lorunde kernel: [311418.891238] general protection fault: 0000 [#1] SMP
>
>
> We had to switch to TCP Cubic (instead of badly configured TCP BBR, without FQ), to reduce the data crc errors.
> But since we still had some errors, last night we rebooted all the OSD nodes in Linux 4.4.91, instead of Linux 4.9.47 & 4.9.53.
>
> Since the last 7 hours, we haven't got any data crc errors from OSD, but we had one from a MON. Without hang/crash.

Since there are a bunch of errors before the GPF I suspect this bug is
related to some error paths that haven't been thoroughly tested (as it is
the case for error paths in general I guess).

My initial guess was a race in ceph_con_workfn:

 - An error returned from try_read() would cause a delayed retry (in
   function con_fault())
 - con_fault_finish() would then trigger a ceph_con_close/ceph_con_open in
   osd_fault.
 - the delayed retry kicks-in and the above close+open, which includes
   releasing con->in_msg and con->out_msg, could cause this GPF.

Unfortunately, I wasn't yet able to find any race there (probably because
there's none), but maybe there's a small window where this could occur.

I wonder if this occurred only once, or if this is something that is
easily triggerable.

Cheers,
-- 
Luis
