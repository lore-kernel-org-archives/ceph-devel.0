From: Mark Nelson <mnelson@redhat.com>
Subject: Re: A way to reduce BlueStore KV traffic
Date: Tue, 13 Dec 2016 11:01:16 -0600
Message-ID: <9b74c666-0ce6-e80d-76a0-141f70cdf821@redhat.com>
References: <es4in77lf83vwmserwh0urhs.1481225501151@email.android.com>
 <dc12e490-1c62-93a1-e65a-8e8fb423b8f7@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932754AbcLMRBR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 12:01:17 -0500
In-Reply-To: <dc12e490-1c62-93a1-e65a-8e8fb423b8f7@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 12/13/2016 10:21 AM, Igor Fedotov wrote:
> Hey cephers!
>
> We are fighting for KV traffic reduction in BlueStore for a while.
> We're pushing huge amount of data to KV (object meta data,  write ahead
> log, block device allocation map etc ) and this impacts the performance
> dramatically. Below I'm trying to fix that by storing most of object
> meta data to block device directly. Actually we should use a second
> (fast) block device that can be physically co-located with DB or WAL
> devices.

Indeed!  KV traffic (specifically Rocksdb compaction) is probably my #1 
concern right now for Bluestore.  Based on what we saw when separating 
data out into different column families, about 2/3 of the compaction 
traffic was for object metadata and the other 1/3 for pglog.  WAL 
writes, at least in my setup, were leaking very minimally into the 
higher levels and was less of a concern.

> Let's start from onode meta data only for the sake of simplicity.
> We have somewhat 4K - 64K and even more meta data per single onode for
> 4M object.  That includes user attrs, csum info, logical to physical
> extent mappings etc. This information is updated (partially or totally)
> on each write. The idea is to save that info to fast block device by
> direct use of an additional BlockDevice instance. E.g. one can allocate
> additional partition sharing the same physical device with DB for that.

The big problem we have right now is the combination of all of that 
per-IO metadata compounded with the write-amp / compaction overhead in 
RocksDB.  I think it's going to take a concerted effort to further audit 
what we are writing out (like determining if we really need things like 
the per-blob header info as Varada mentioned) along with getting that 
data out of rocksdb.  Whether that means simply switching to something 
like zetascale, or the idea you are proposing here I'm not sure. 
Hopefully I will be testing Somnath's zetascale branch soon.

> Instead of full onode representation KV DB will contain allocated
> physical extents layout for this meta data similar to blob pextents
> vector on per-onode basis - i.e. some indexing info.  Plus some minor
> data too if needed. Additionally KV to hold free space tracking info
> from the second FreeList manager for fast block device.
> When saving onode bluestore has to allocate required space at fast
> device, mark old extents for release, write both onode and user data to
> block devices (in parallel) and update a db with space allocations. I.e.
> meta data overwrite procedure starts to resemble user data overwrite.
>
> Similar idea can be applied for WAL - one can store user data to fast
> device directly and update indexing information in KV only.

I don't think the WAL is actually hurting us much right now fwiw.

>
> Indexing information is pretty short and perhaps one should read it into
> memory on store mount and do not retrieve from DB during the operation.
>
> This way DB traffic is reduced considerably and hence compaction will
> happen less frequently. Moreover we might probably remove var encoding
> stuff since we can be less careful about serialized onode size from now on.

I think your proposal is heading in the right direction if we intend to 
stick with rocksdb.  If we decide to move toward zetascale, we'll need 
to think about some kind of WAL solution, but I'm less sure if we need 
to move data out of the KV store.  Maybe Somnath or Allen will comment. 
I agree regarding varint encoding regardless of what we do, I'd much 
rather at least batch into prefixVarint or even just focus on 
compression of the 0/1 case.

>
> There is some POC code located at
> https://github.com/ifed01/ceph/tree/wip_bluestore_minimize_db
> POC code lacks WAL support, index retrieval on startup, var encoding
> elimination at the moment.
> Performance testing are still in progress.
>
> Any thoughts/comments?

I'd be happy to take it for a test drive once I've got some of the 
zetascale testing done.  There's plenty of merit for trying it at least.

>
> Thanks,
> Igor
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
