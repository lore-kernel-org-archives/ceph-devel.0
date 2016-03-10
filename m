From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore Performance issue
Date: Thu, 10 Mar 2016 08:58:25 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603100855580.14377@cpach.fuggernut.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com> <6AA21C22F0A5DA478922644AD2EC308C37354FB4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbcCJN6r (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 08:58:47 -0500
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C37354FB4@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 10 Mar 2016, Ma, Jianpeng wrote:
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Wednesday, March 9, 2016 9:54 PM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: BlueStore Performance issue
> > 
> > On Wed, 9 Mar 2016, Allen Samuels wrote:
> > > We are in the process of evaluating the performance of the BlueStore
> > > when using ZetaScale in place of RocksDB. Currently, we see one major
> > > performance bottleneck that is dictated by the current implementation
> > > of BlueStore. We believe that this bottleneck is artificial and can be
> > > easily removed. Further, we believe that this will provide a
> > > performance improvement for both the BlueStore/ZetaScale as well as
> > > the BlueStore/RocksDB combinations.
> > >
> > > We are currently implementing a revision of this area of the code and
> > > are looking for community comments and constructive criticism. It's
> > > also possible that we don't properly understand this code -- in which
> > > case an early course correction would be beneficial.
> > >
> > > For this discussion, we consider the write-path of BlueStore to
> > > consist of 4 steps:
> > >
> > > 1. Preparation and asynchronous initiation of data writes.
> > > 2. Detection of asynchronous write completions 3. KV transaction
> > > commit.
> > > 4. WAL stuff.
> > >
> > > Currently, stage 2 is performed by a single "aio_thread" for data
> > > block device, essentially one global thread. This thread waits for
> > > each I/O to complete. Once an I/O has completed, it checks to see if
> > > the associated transaction has any remaining I/O operations and if
> > > not, moves that transaction into the global kv_sync queue, waking up
> > > the kv_sync thread if needed.
> > >
> > > Stage 3 is a single system-wide thread that removes transactions from
> > > the kv_sync queue and submits them to the KeyValueDB one at a time
> > > (synchronously).
> > 
> > Note that it actually grabs all of the pending transactions at once, and it
> > submits them all asynchrnonously (doesn't wait for completeion), and then
> > submits a final blocking/synchronous transaction (with the wal cleanup work) to
> > wait for them to hit disk.
> > 
> > > Stage 3 is serious bottleneck in that it guarantees that you will
> > > never exceed QD=1 for your logging device. We believe there is no need
> > > to serialize the KV commit operations.
> > 
> > It's potentially a bottleneck, yes, but it's also what keeps the commit rate
> > self-throttling.  If we assume that there are generally lots of other IOs in flight
> > because every op isn't metadata-only the QD will be higher.
> > If it's a separate log device, though, yes.. it will have QD=1.  In those
> > situations, though, the log device is probably faster than the other devices, and
> > a shallow QD probably isn't going to limit throughput--just marginally increase
> > latency?
> > 
> > > We propose to modify this mechanism as follows:
> > >
> > > Stage 2 will be performed by a separate pool of threads (each with an
> > > associated io completion context). During Stage 1, one thread is
> > > allocated from the pool for each transaction. The asynchronous data
> > > writes that are created for that transaction point to the newly
> > > allocated io completion context/thread.
> > >
> > > Each of these I/O completion threads will now wait for all of the data
> > > writes associated with their individual transactions to be completed
> > > and then will synchronously commit to the KeyValueDB. Once the KV
> > > commit is completed, the completion handlers are invoked (possibly
> > > eliminating an extra thread switch for the synchronous completion
> > > callbacks) and then the transaction is destroyed or passed off to the
> > > existing WAL logic (which we believe can be eliminated -- but that's a
> > > discussion for another day :)).
> > >
> > > This new mechanism has the effect of allowing 'N' simultaneous KV
> > > commit operations to be outstanding (N is the size of the completion
> > > thread pool). We believe that both ZetaScale and RocksDB will support
> > > much higher transaction rates in this situation, which should lead to
> > > significant performance improvement for small transactions.
> > >
> > > There are two major changes that we are nervous about.
> > >
> > > (1) Having multiple KV commits outstanding. We're certain that the
> > > underlying KV implementations will properly handle this but we're
> > > concerned that there might be hidden dependencies in the upper level
> > > OSD code that aren't apparent to us.
> > 
> > This is the crux of it.  And smooshing stage 2 + 3 together and doing the kv
> > commit synchronously from the io completion thread mostly amounts to the
> > same set of problems to solve.  And it mostly is the same as making
> > bluestore_sync_transaction work.
> > 
> > The problem is the freelist updates that happen during each _kv_thread
> > iteration.  Each txn that commits has to update the freelist atomically, but the
> > represetnation of that update is fundamentally ordered.  E.g., if the freelist is
> > 
> > 0~1000
> > 
> > and two transactions allocate 0~50 and 50~50, if they commit in order the
> > updates would be
> > 
> >  delete 0, insert 50=950
> >  delete 50, insert 100=900
> > 
> > but if the order reverses it'd be
> > 
> >  delete 0, insert 0=50, insert 100=900
> >  delete 0
> > 
> > Just to make it work given the current representation you'd need to serialize on
> > a lock and submit only one txn at a time to ensure the order
> Hi sage, if for each _kv_thread, we get the release of transactions and submit in batch.
> Like :
> interval_set<uint64_t> released;
> allocator->queue_release(released) {
> 	mutex(lock)
> 	release_queue.push(released)
> 	unmutex()
> }
> In Allocated, there is a thread to do release work
> Do_relase()
> {
> 	List tmp;
> 	Mutex(lock)
> 	Tmp.swap(release_queue);
> 	Unmutex(lock);
> 	do_real_realse_work;
> }
> 
> How about that?

I'm not sure I follow. There *is* a WAL release field, so we could easily 
do a WAL entry to do deferred release work, and that would happen serially 
and asynchronously.  For allocate, though, the problem remains that 
updates to the freelist represetnation currently have to be serialized.

I think the range of solutions there include dividing up the device into 
regions or allocation groups, using a bitmap-based representation so that 
updates to different 'blocks' of the bitmap don't conflict (basically same 
as allocation groups of fine-grained), preallocation of soon-to-be-used 
regions that are explicitly claimed by WAL records, ...

sage

