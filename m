From: Sage Weil <sweil@redhat.com>
Subject: RE: A way to reduce BlueStore KV traffic
Date: Tue, 13 Dec 2016 18:31:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612131811450.32565@piezo.novalocal>
References: <es4in77lf83vwmserwh0urhs.1481225501151@email.android.com> <dc12e490-1c62-93a1-e65a-8e8fb423b8f7@mirantis.com> <9b74c666-0ce6-e80d-76a0-141f70cdf821@redhat.com> <BY2PR02MB39675198B8FDE6594F9BACDF49B0@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1337818417-1481653094=:32565"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbcLMSkF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 13:40:05 -0500
In-Reply-To: <BY2PR02MB39675198B8FDE6594F9BACDF49B0@BY2PR02MB396.namprd02.prod.outlook.com>
Content-ID: <alpine.DEB.2.11.1612131820360.32565@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1337818417-1481653094=:32565
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1612131820361.32565@piezo.novalocal>

On Tue, 13 Dec 2016, Somnath Roy wrote:
> Igor,
> This is nice but I am not yet ready to give up on DBs yet :-) This is adding extra complexity on deployment  as well. Not sure about the extra read/write impact on slower devices as well , your benchmark should reveal that.
> There are lot of effort going on to reduce db traffic, optimize kvs etc. and hopefully that will resolve the matter. Otherwise, we need to go with this route probably.

I tend to agree.  I don't think the kv interface is not to blame here, but 
the implementation behind it.  It gives you efficient lookups and space 
utilization, locality, ordered object enumeration, and atomic 
transactions.  The current set of tradeoffs in rocksdb is proving to be 
less than ideal, but I think that's something that can be fixed either 
within rocksdb or by swapping in another kv db.

Managing onodes on disk manually means we have to implement the ordered 
lookup, or keep using kv just for the name -> onode block translation.  
And then deal with space reclamaition, etc.  I don't think it's just a 
complexity trade-off, though, where doing it ourselves means doing it 
better.. the same can be done by teh kv store itself.  For example, on 
flash, if we don't need locality, we could keep the name -> onode (nid?) 
mapping inline and put the metadata itself elsewhere.  Some kv db's do 
that, including LSM-based ones: they put all the keys in one set of sst 
files and the data/values in another set, and show pretty impressive gains 
(esp when, say, putting hte key data on ssd and value data on hdd).

I would be inclined to look at rocksdb alternatives like ZS or maybe 
tokudb (https://github.com/percona/PerconaFT) before scrapping the kv 
store entirely...

I also think there's opportunity to improve the pg log kv behavior with a 
time-series friendly column family or similar.  The current rocksdb 
compaction strategies aren't quite right, but i don't think they're too 
far off from something that will avoid any compaction of pg log data in 
the general case.

I'll take a look a mull this over some more...

> On 12/13/2016 10:21 AM, Igor Fedotov wrote:
> > Hey cephers!
> >
> > We are fighting for KV traffic reduction in BlueStore for a while.
> > We're pushing huge amount of data to KV (object meta data,  write
> > ahead log, block device allocation map etc ) and this impacts the
> > performance dramatically. Below I'm trying to fix that by storing most
> > of object meta data to block device directly. Actually we should use a
> > second
> > (fast) block device that can be physically co-located with DB or WAL
> > devices.
> 
> Indeed!  KV traffic (specifically Rocksdb compaction) is probably my #1 concern right now for Bluestore.  Based on what we saw when separating data out into different column families, about 2/3 of the compaction traffic was for object metadata and the other 1/3 for pglog.  WAL writes, at least in my setup, were leaking very minimally into the higher levels and was less of a concern.
> 
> > Let's start from onode meta data only for the sake of simplicity.
> > We have somewhat 4K - 64K and even more meta data per single onode for
> > 4M object.  That includes user attrs, csum info, logical to physical
> > extent mappings etc. This information is updated (partially or
> > totally) on each write. The idea is to save that info to fast block
> > device by direct use of an additional BlockDevice instance. E.g. one
> > can allocate additional partition sharing the same physical device with DB for that.
> 
> The big problem we have right now is the combination of all of that per-IO metadata compounded with the write-amp / compaction overhead in RocksDB.  I think it's going to take a concerted effort to further audit what we are writing out (like determining if we really need things like the per-blob header info as Varada mentioned) along with getting that data out of rocksdb.  Whether that means simply switching to something like zetascale, or the idea you are proposing here I'm not sure.
> Hopefully I will be testing Somnath's zetascale branch soon.
> 
> > Instead of full onode representation KV DB will contain allocated
> > physical extents layout for this meta data similar to blob pextents
> > vector on per-onode basis - i.e. some indexing info.  Plus some minor
> > data too if needed. Additionally KV to hold free space tracking info
> > from the second FreeList manager for fast block device.
> > When saving onode bluestore has to allocate required space at fast
> > device, mark old extents for release, write both onode and user data
> > to block devices (in parallel) and update a db with space allocations. I.e.
> > meta data overwrite procedure starts to resemble user data overwrite.
> >
> > Similar idea can be applied for WAL - one can store user data to fast
> > device directly and update indexing information in KV only.
> 
> I don't think the WAL is actually hurting us much right now fwiw.
> 
> >
> > Indexing information is pretty short and perhaps one should read it
> > into memory on store mount and do not retrieve from DB during the operation.

Any strategy that assumes we put everything in RAM is going to be 
problematic for some workloads.  We can't assume objects are 4MB.  RGW 
users, for example, are free to upload nothing for 4K objects if they 
like.

> > This way DB traffic is reduced considerably and hence compaction will
> > happen less frequently. Moreover we might probably remove var encoding
> > stuff since we can be less careful about serialized onode size from now on.
> 
> I think your proposal is heading in the right direction if we intend to stick with rocksdb.  If we decide to move toward zetascale, we'll need to think about some kind of WAL solution, but I'm less sure if we need to move data out of the KV store.  Maybe Somnath or Allen will comment.
> I agree regarding varint encoding regardless of what we do, I'd much rather at least batch into prefixVarint or even just focus on compression of the 0/1 case.
> 
> >
> > There is some POC code located at
> > https://github.com/ifed01/ceph/tree/wip_bluestore_minimize_db
> > POC code lacks WAL support, index retrieval on startup, var encoding
> > elimination at the moment.
> > Performance testing are still in progress.
> >
> > Any thoughts/comments?
> 
> I'd be happy to take it for a test drive once I've got some of the zetascale testing done.  There's plenty of merit for trying it at least.
> 
> >
> > Thanks,
> > Igor
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-1337818417-1481653094=:32565--
