From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 08:55:52 -0600
Message-ID: <4FEB1EF8.4050307@sandia.gov>
References: <4FEB04CC.4050008@profihost.ag>
 <4FEB10DA.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:45730 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab2F0O4M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 10:56:12 -0400
In-Reply-To: <4FEB10DA.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

On 06/27/2012 07:55 AM, Mark Nelson wrote:
>
> For what it's worth, I've got a pair of Dell R515 setup with a single 2.8GHz 6-core 4184 Opteron, 16GB of RAM, and 10 SSDs that are capable of about 200MB/s each.  Currently I'm topping out at about 600MB/s with rados bench using half of the drives for data and half for journals (at 2x replication).  Putting journals on the same drive and doing 10 OSDs on each node is slower.  Still working on figuring out why.

Just for fun, try the following tunings to see if they make
a difference for you.

This is my current best tuning for my hardware, which uses
24 SAS drives/server, and 1 OSD/drive with a journal partition
on the outer tracks and btrfs for the data store.

	journal dio = true
	osd op threads = 24
	osd disk threads = 24
	filestore op threads = 6
	filestore queue max ops = 24

	osd client message size cap = 14000000
	ms dispatch throttle bytes =  17500000

I'd be very curious to hear how these work for you.
My current testing load is streaming writes from
166 linux clients, and the above tunings let me
sustain ~2 GB/s on each server (2x replication,
so 500 MB/s per server aggregate client bandwidth).

I have dual-port 10 GbE NICs, and use one port
for the cluster and one for the clients.  I use
jumbo frames because it freed up ~10% CPU cycles over
the default config of 1500-byte frames + GRO/GSO/etc
on the load I'm currently testing with.

FWIW these servers are dual-socket Intel 5675 Xeons,
so total 12 cores at 3.0 GHz.  On the above load I
usually see 15-30% idle.

FWIW, "perf top" has this to say about where time is being spent
under the above load under normal conditions.

    PerfTop:   19134 irqs/sec  kernel:79.2%  exact:  0.0% [1000Hz cycles],  (all, 24 CPUs)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

              samples  pcnt function                                       DSO
              _______ _____ ______________________________________________ ________________________________________________________________________________________

             37656.00 15.3% ceph_crc32c_le                                 /usr/bin/ceph-osd
             23221.00  9.5% copy_user_generic_string                       [kernel.kallsyms]
             16857.00  6.9% btrfs_end_transaction_dmeta                    /lib/modules/3.5.0-rc4-00011-g15d0694/kernel/fs/btrfs/btrfs.ko
             16787.00  6.8% __crc32c_le                                    [kernel.kallsyms]


But, sometimes I see this:

    PerfTop:    4930 irqs/sec  kernel:97.8%  exact:  0.0% [1000Hz cycles],  (all, 24 CPUs)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

              samples  pcnt function                                       DSO
              _______ _____ ______________________________________________ ________________________________________________________________________________________

            147565.00 45.8% _raw_spin_lock_irqsave                         [kernel.kallsyms]
             24427.00  7.6% isolate_freepages_block                        [kernel.kallsyms]
             23759.00  7.4% ceph_crc32c_le                                 /usr/bin/ceph-osd
             16521.00  5.1% copy_user_generic_string                       [kernel.kallsyms]
             10549.00  3.3% __crc32c_le                                    [kernel.kallsyms]
              8901.00  2.8% btrfs_end_transaction_dmeta                    /lib/modules/3.5.0-rc4-00011-g15d0694/kernel/fs/btrfs/btrfs.ko

When this happens, OSDs cannot process heartbeats in a timely fashion,
get wrongly marked down, thrashing ensues, clients stall.  I'm still
trying to  learn how to get perf to tell me more....

-- Jim

