From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: BlueStore Performance issue
Date: Wed, 9 Mar 2016 15:29:08 +0000
Message-ID: <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0062.outbound.protection.outlook.com ([157.56.111.62]:57103
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932983AbcCIP3M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 10:29:12 -0500
In-Reply-To: <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Allen Samuels
Software Architect, Emerging Storage Solutions

2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Wednesday, March 09, 2016 5:54 AM
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: BlueStore Performance issue

On Wed, 9 Mar 2016, Allen Samuels wrote:
> We are in the process of evaluating the performance of the BlueStore
> when using ZetaScale in place of RocksDB. Currently, we see one major
> performance bottleneck that is dictated by the current implementation
> of BlueStore. We believe that this bottleneck is artificial and can be
> easily removed. Further, we believe that this will provide a
> performance improvement for both the BlueStore/ZetaScale as well as
> the BlueStore/RocksDB combinations.
>
> We are currently implementing a revision of this area of the code and
> are looking for community comments and constructive criticism. It's
> also possible that we don't properly understand this code -- in which
> case an early course correction would be beneficial.
>
> For this discussion, we consider the write-path of BlueStore to
> consist of 4 steps:
>
> 1. Preparation and asynchronous initiation of data writes.
> 2. Detection of asynchronous write completions 3. KV transaction
> commit.
> 4. WAL stuff.
>
> Currently, stage 2 is performed by a single "aio_thread" for data
> block device, essentially one global thread. This thread waits for
> each I/O to complete. Once an I/O has completed, it checks to see if
> the associated transaction has any remaining I/O operations and if
> not, moves that transaction into the global kv_sync queue, waking up
> the kv_sync thread if needed.
>
> Stage 3 is a single system-wide thread that removes transactions from
> the kv_sync queue and submits them to the KeyValueDB one at a time
> (synchronously).

Note that it actually grabs all of the pending transactions at once, and it submits them all asynchrnonously (doesn't wait for completeion), and then submits a final blocking/synchronous transaction (with the wal cleanup work) to wait for them to hit disk.

[Allen] We saw the whole queue thing, but missed the asynchronous commit thing. We'll revisit this.

> Stage 3 is serious bottleneck in that it guarantees that you will
> never exceed QD=1 for your logging device. We believe there is no need
> to serialize the KV commit operations.

It's potentially a bottleneck, yes, but it's also what keeps the commit rate self-throttling.  If we assume that there are generally lots of other IOs in flight because every op isn't metadata-only the QD will be higher.
If it's a separate log device, though, yes.. it will have QD=1.  In those situations, though, the log device is probably faster than the other devices, and a shallow QD probably isn't going to limit throughput--just marginally increase latency?

[Allen] No a shallow queue depth will directly impact BW on many (most?/all?) SSDs. I agree that in a hybrid model (DB on flash, data on HDD) that the delivered performance delta may not be large. As for the throttling, we haven't focused on that area yet (just enough to put it on the list of future things to investigate).

> We propose to modify this mechanism as follows:
>
> Stage 2 will be performed by a separate pool of threads (each with an
> associated io completion context). During Stage 1, one thread is
> allocated from the pool for each transaction. The asynchronous data
> writes that are created for that transaction point to the newly
> allocated io completion context/thread.
>
> Each of these I/O completion threads will now wait for all of the data
> writes associated with their individual transactions to be completed
> and then will synchronously commit to the KeyValueDB. Once the KV
> commit is completed, the completion handlers are invoked (possibly
> eliminating an extra thread switch for the synchronous completion
> callbacks) and then the transaction is destroyed or passed off to the
> existing WAL logic (which we believe can be eliminated -- but that's a
> discussion for another day :)).
>
> This new mechanism has the effect of allowing 'N' simultaneous KV
> commit operations to be outstanding (N is the size of the completion
> thread pool). We believe that both ZetaScale and RocksDB will support
> much higher transaction rates in this situation, which should lead to
> significant performance improvement for small transactions.
>
> There are two major changes that we are nervous about.
>
> (1) Having multiple KV commits outstanding. We're certain that the
> underlying KV implementations will properly handle this but we're
> concerned that there might be hidden dependencies in the upper level
> OSD code that aren't apparent to us.

This is the crux of it.  And smooshing stage 2 + 3 together and doing the kv commit synchronously from the io completion thread mostly amounts to the same set of problems to solve.  And it mostly is the same as making bluestore_sync_transaction work.

The problem is the freelist updates that happen during each _kv_thread iteration.  Each txn that commits has to update the freelist atomically, but the represetnation of that update is fundamentally ordered.  E.g., if the freelist is

0~1000

and two transactions allocate 0~50 and 50~50, if they commit in order the updates would be

 delete 0, insert 50=950
 delete 50, insert 100=900

but if the order reverses it'd be

 delete 0, insert 0=50, insert 100=900
 delete 0

Just to make it work given the current representation you'd need to serialize on a lock and submit only one txn at a time to ensure the order.  That might avoid funneling through a single thread but doesn't really change things otherwise.  To truly submit parallel transactions we have to not care about their order, which means the freespace has to be partitioned among the different commit threads and we need to be allocating into different regions of the device (e.g., allocation groups in XFS).

It's possible, but a lot of complexity... are you sure it's going to make a significant difference?  How fast does a device have to be before it does?  We'd certainly never want to do this on a disk, but it would work for solid state.  Even so, we'll need to be clever about balancing freespace between regions.

[Allen] Yes, we missed this and we'll study this area today. Hopefully we can find a simpler solution that allocation groups.

> (2) Similar to (1), the handling of the completion callbacks is now
> parallelized -- with the same concerns.

This shouldn't be a problem, as long as a given Sequencer always maps to the same thread, and thus keeps its own requests ordered.

sage

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
