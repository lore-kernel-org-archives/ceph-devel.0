From: Samuel Just <sam.just@inktank.com>
Subject: Re: [ceph-users] Significant slowdown of osds since v0.67 Dumpling
Date: Mon, 19 Aug 2013 00:29:43 -0700
Message-ID: <CA+4uBUZK1TJ2i6PvhWoeroELs2s+a8rDchEYCUVaXs++CZU=_w@mail.gmail.com>
References: <1376737988.3951.10.camel@X200s-oli.fritz.box>
	<520F77B3.9040903@inktank.com>
	<1376776126.3951.26.camel@X200s-oli.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:53095 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3HSH3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 03:29:44 -0400
Received: by mail-ve0-f176.google.com with SMTP id b10so2764688vea.35
        for <ceph-devel@vger.kernel.org>; Mon, 19 Aug 2013 00:29:43 -0700 (PDT)
In-Reply-To: <1376776126.3951.26.camel@X200s-oli.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Daudey <oliver@xs4all.nl>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You're right, PGLog::undirty() looks suspicious.  I just pushed a
branch wip-dumpling-pglog-undirty with a new config
(osd_debug_pg_log_writeout) which if set to false will disable some
strictly debugging checks which occur in PGLog::undirty().  We haven't
actually seen these checks causing excessive cpu usage, so this may be
a red herring.
-Sam

On Sat, Aug 17, 2013 at 2:48 PM, Oliver Daudey <oliver@xs4all.nl> wrote:
> Hey Mark,
>
> On za, 2013-08-17 at 08:16 -0500, Mark Nelson wrote:
>> On 08/17/2013 06:13 AM, Oliver Daudey wrote:
>> > Hey all,
>> >
>> > This is a copy of Bug #6040 (http://tracker.ceph.com/issues/6040) I
>> > created in the tracker.  Thought I would pass it through the list as
>> > well, to get an idea if anyone else is running into it.  It may only
>> > show under higher loads.  More info about my setup is in the bug-report
>> > above.  Here goes:
>> >
>> >
>> > I'm running a Ceph-cluster with 3 nodes, each of which runs a mon, osd
>> > and mds. I'm using RBD on this cluster as storage for KVM, CephFS is
>> > unused at this time. While still on v0.61.7 Cuttlefish, I got 70-100
>> > +MB/sec on simple linear writes to a file with `dd' inside a VM on this
>> > cluster under regular load and the osds usually averaged 20-100%
>> > CPU-utilisation in `top'. After the upgrade to Dumpling, CPU-usage for
>> > the osds shot up to 100% to 400% in `top' (multi-core system) and the
>> > speed for my writes with `dd' inside a VM dropped to 20-40MB/sec. Users
>> > complained that disk-access inside the VMs was significantly slower and
>> > the backups of the RBD-store I was running, also got behind quickly.
>> >
>> > After downgrading only the osds to v0.61.7 Cuttlefish and leaving the
>> > rest at 0.67 Dumpling, speed and load returned to normal. I have
>> > repeated this performance-hit upon upgrade on a similar test-cluster
>> > under no additional load at all. Although CPU-usage for the osds wasn't
>> > as dramatic during these tests because there was no base-load from other
>> > VMs, I/O-performance dropped significantly after upgrading during these
>> > tests as well, and returned to normal after downgrading the osds.
>> >
>> > I'm not sure what to make of it. There are no visible errors in the logs
>> > and everything runs and reports good health, it's just a lot slower,
>> > with a lot more CPU-usage.
>>
>> Hi Oliver,
>>
>> If you have access to the perf command on this system, could you try
>> running:
>>
>> "sudo perf top"
>>
>> And if that doesn't give you much,
>>
>> "sudo perf record -g"
>>
>> then:
>>
>> "sudo perf report | less"
>>
>> during the period of high CPU usage?  This will give you a call graph.
>> There may be symbols missing, but it might help track down what the OSDs
>> are doing.
>
> Thanks for your help!  I did a couple of runs on my test-cluster,
> loading it with writes from 3 VMs concurrently and measuring the results
> at the first node with all 0.67 Dumpling-components and with the osds
> replaced by 0.61.7 Cuttlefish.  I let `perf top' run and settle for a
> while, then copied anything that showed in red and green into this post.
> Here are the results (sorry for the word-wraps):
>
> First, with 0.61.7 osds:
>
>  19.91%  [kernel]                    [k] intel_idle
>  10.18%  [kernel]                    [k] _raw_spin_lock_irqsave
>   6.79%  ceph-osd                    [.] ceph_crc32c_le
>   4.93%  [kernel]                    [k]
> default_send_IPI_mask_sequence_phys
>   2.71%  [kernel]                    [k] copy_user_generic_string
>   1.42%  libc-2.11.3.so              [.] memcpy
>   1.23%  [kernel]                    [k] find_busiest_group
>   1.13%  librados.so.2.0.0           [.] ceph_crc32c_le_intel
>   1.11%  [kernel]                    [k] _raw_spin_lock
>   0.99%  kvm                         [.] 0x1931f8
>   0.92%  [igb]                       [k] igb_poll
>   0.87%  [kernel]                    [k] native_write_cr0
>   0.80%  [kernel]                    [k] csum_partial
>   0.78%  [kernel]                    [k] __do_softirq
>   0.63%  [kernel]                    [k] hpet_legacy_next_event
>   0.53%  [ip_tables]                 [k] ipt_do_table
>   0.50%  libc-2.11.3.so              [.] 0x74433
>
> Second test, with 0.67 osds:
>
>  18.32%  [kernel]                      [k] intel_idle
>   7.58%  [kernel]                      [k] _raw_spin_lock_irqsave
>   7.04%  ceph-osd                      [.] PGLog::undirty()
>   4.39%  ceph-osd                      [.] ceph_crc32c_le_intel
>   3.92%  [kernel]                      [k]
> default_send_IPI_mask_sequence_phys
>   2.25%  [kernel]                      [k] copy_user_generic_string
>   1.76%  libc-2.11.3.so                [.] memcpy
>   1.56%  librados.so.2.0.0             [.] ceph_crc32c_le_intel
>   1.40%  libc-2.11.3.so                [.] vfprintf
>   1.12%  libc-2.11.3.so                [.] 0x7217b
>   1.05%  [kernel]                      [k] _raw_spin_lock
>   1.01%  [kernel]                      [k] find_busiest_group
>   0.83%  kvm                           [.] 0x193ab8
>   0.80%  [kernel]                      [k] native_write_cr0
>   0.76%  [kernel]                      [k] __do_softirq
>   0.73%  libc-2.11.3.so                [.] _IO_default_xsputn
>   0.70%  [kernel]                      [k] csum_partial
>   0.68%  [igb]                         [k] igb_poll
>   0.58%  [kernel]                      [k] hpet_legacy_next_event
>   0.54%  [kernel]                      [k] __schedule
>
>
> What jumps right out, is the "PGLog::undirty()", which doesn't show up
> with 0.61.7 at all, but is an extra drag right at top-usage in 0.67.
> Note that I didn't manage to fully load the test-cluster CPU-wise,
> because of network-constraints and I don't want to take any extra risks
> on the production-cluster and test it there, but it seems we found a
> possible culprit.
>
> Any ideas?  Thanks again!
>
>
>
>    Regards,
>
>       Oliver
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
