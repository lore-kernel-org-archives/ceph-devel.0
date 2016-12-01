From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueStore Latency Breakdown
Date: Thu, 1 Dec 2016 17:37:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612011647400.2702@piezo.novalocal>
References: <9919FCA5-993E-4153-9A6E-AA64E592A3A4@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-278993621-1480613844=:2702"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbcLARhZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 12:37:25 -0500
In-Reply-To: <9919FCA5-993E-4153-9A6E-AA64E592A3A4@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-278993621-1480613844=:2702
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

[adding ceph-devel]

On Thu, 1 Dec 2016, LIU, Fei wrote:
> Hi Sage:
> 
>     Here are the benchmark results that we got:        
> 
>         1. With bluestore storage engine，The latency of fio 16KB, single IO
> with three replicas is  around 1.2ms
> 
>         2. With bluestore storage engine，The latenc of fio 16KB, single IO
> with single replicas is  around 0.7ms
> 
>         3. With filestore storage engine，The latenc of fio 16KB, single IO
> with three replicas is  around 0.8ms
> 
>     The IO flow including space allocation, data write and metadata write.
> All of these operations are serialized . The data was written to block
> device(SATA SSD) through AIO. The metadata was written to  RocksDB (NVMe
> SSD).
> 
>  
> 
> Here are what we observed and latency breakdown through percounter and log:
> 
> 1.       Prepare stage of transaction：90us
> 
> 2.       Data was written through AIO(SATA SSD): 110us(3520 16k random write
> latency is around 80-90us)
> 
> 3.       Metadata was written twice by calling submit_transaction_sync, The
> total latency is around 350us(The logging mechanism was used in bluefs,
> everytime, the IO to bluefs will be written to log then to data, so here is
> total four IOs.)

This is part of the problem.  The bluefs logging path should not be 
triggered unless it is a totally fresh OSD and the wal log files haven't 
been recycled yet.  There is an option to precondition the rocksdb log

	OPTION(bluestore_precondition_bluefs, OPT_U64, 512*1024*1024)  // write this much data at mkfs

that you may have adjusted or might not be writing enough data?  Have you 
adjusted the rocksdb parameters at all?

Actually, testing this now, it looks like the preconditioning isn't 
working the way it should.  You can work around this just by writing a 
bunch of data to bluestore to get the rocksdb logs to roll over.  The 
easiest way to do this is

  rados -p rbd bench 30 write -b 65536 --write-omap

and be sure to write serveral hundred megabytes to each OSD.  After that, 
you should see the latency drop way down.

> The whole process for a bluestore write hence take : 90+110+350=550us
> 
>     Three replicas were used in Ceph:  We first wrote to primary then to two
> replicas and return. The total latency including the networking latency will
> be  
> 
>     network_latency + primary_osd_bluestore_latency +
> slave_osd_bluestore_latency which equals to 200+550+550=1.3ms(the networking
> latency is around 200us for three replicas) . It is pretty close to 1.2ms .
> 
>  
> 
>    For further verified , we have test the cluster with single replics with
> below latency calculation:
> 
>    network_latency + primary_osd_bluestore_latency which is equal to
> 100+550＝0.65us (networking latency is 100us with single replica), it is
> pretty close to to 0.7ms.
> 
>  
> 
> Here is our preliminary conclusion:
> 
>             1. Latency of Bluestore is worse than filestore because metadata
> and data write twice in difference place in bluestore.

As mentioned during the perf call, I think the path we should take is an 
option or some auto-tuning so that in BlueStore can choose to do 
write-ahead logging of the data write even when it is <= min_alloc_size.  
This will allow the operation to commit with a single IO + flush to the 
nvme wal device and the data write to the slower device to happen 
asynchronously.

>             2. It take too much time for calling submit_sync_latency twice
> to write metadata 。more optimization should be made over here

This is a easist thing to fix... I've opened a ticket:

	http://tracker.ceph.com/issues/18105

>             3. Could be possible to make metadata and data write in parallel
> for improving the latency.    

Definitely not.  We cannot write any metadata that references data until 
the data is on stable storage or else a power failure will lead to 
corruption.

Thanks for the detailed breakdown!

sage
--8323329-278993621-1480613844=:2702--
