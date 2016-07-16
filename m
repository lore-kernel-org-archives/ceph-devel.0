From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: segfault in bluestore during random writes
Date: Sat, 16 Jul 2016 01:38:38 +0000
Message-ID: <BL2PR02MB2115BE890B4C4FD5D963F600F4340@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <0b69c134-ffa9-1918-b4f5-ca9cc0cd7fbe@redhat.com>
 <BL2PR02MB211526CD238E75118F88A573F43A0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <6AA21C22F0A5DA478922644AD2EC308C373B4AFA@SHSMSX101.ccr.corp.intel.com>
 <BLUPR0201MB1908EF2D0EF0D05D452016E4E23B0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <9349d912-9eda-bed8-3942-38db05fcbb79@mirantis.com>
 <BLUPR0201MB190886F6FCDFAB1641F1CEB8E23B0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <8a36418c-c853-703d-73c3-e36a3fda5846@mirantis.com>
 <alpine.DEB.2.11.1607071456180.10848@piezo.us.to>
 <BL2PR02MB2115EC4084CE08D51AA5353BF43B0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1607072021070.11303@piezo.us.to>
 <BL2PR02MB2115064A8E0B872E3857FFC4F43B0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB2115AE4E958D6B5963E92B27F4330@BL2PR02MB2115.namprd02.prod.outlook.com>
 <4e9c391e-90c9-79fe-52c2-e2b24c72bfbd@mirantis.com>
 <BL2PR02MB2115B7ECEA5F6BDB71F38BAFF4330@BL2PR02MB2115.namprd02.prod.outlook.com>
 <d1e3ec4e-0b9b-9339-8e7b-8b1a52ffd2ea@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:22991
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751172AbcGPBin convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jul 2016 21:38:43 -0400
In-Reply-To: <d1e3ec4e-0b9b-9339-8e7b-8b1a52ffd2ea@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sweil@redhat.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, "Ma, Jianpeng" <jianpeng.ma@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

Mark,
It is working for me so far. Please go ahead and give it a try.

https://github.com/ceph/ceph/pull/10220

Thanks & Regards
Somnath

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com] 
Sent: Friday, July 15, 2016 10:54 AM
To: Somnath Roy; Igor Fedotov; Sage Weil
Cc: Varada Kari; Ma, Jianpeng; ceph-devel
Subject: Re: segfault in bluestore during random writes



On 07/15/2016 12:51 PM, Somnath Roy wrote:
> I saw in the following cases it is using destination collection id (as a second collection within a transaction) and all other cases it is single collection id within a transaction.
>
> collection_move         ----- depricated
> collection_move_rename
> split_collection
>
> All these operation is protected by Buestore-> coll_lock and not touching onodes.
> Only object operations are touching onodes and it is locked by first_collection lock .
> So, IMO, it should be enough to fix this bug.
>
> Mark,
> I will update the pull request after doing some more tests today and you can give it a shot. Will let you know.

Excellent.  I'm going to try to do a wip-testing branch this weekend and see if I can get some of the outstanding pull requests that have passed ceph_test_objectstore tests and performance tests merged.

Thanks,
Mark

>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Friday, July 15, 2016 6:46 AM
> To: Somnath Roy; Sage Weil
> Cc: Varada Kari; Ma, Jianpeng; Mark Nelson; ceph-devel
> Subject: Re: segfault in bluestore during random writes
>
>
>
> On 15.07.2016 5:04, Somnath Roy wrote:
>> Resurrecting the old thread..
>> Igor/Sage,
>> I had multiple update on the pull request as I kept hitting this crash after long run.
>> In my last update, I did only protect _wctx_finish() along with txc->write_onode with osr->qlock , but, it eventually crashed on me by running different pattern.
>> I think it is pretty similar to Igor's patch where a new lock is protecting blobs only from _wctx_finish(). The reason is, onodes are on collection and osr is again per collection. So, to touch an onode and it's blobs osr->qlock should be sufficient IMO.
>> IF that is true, it means protecting _wctx_finish() is not sufficient, there are other places from where these blobs are touched. One place is probably, c->cache->trim().
> yeah, probably other places that access blob_map should be protected too. Varada shared his patch that contains additional locations, not sure that was a full set though..
>
>> Also, what if onode itself is been erased , this won't be protected as well.
> onode can't be removed while we hold a reference to it.
>>
>> Guarding entire _txc_add_transaction() with osr-qlock worked well for 
>> me but that induced a deadlock in case of small block wal write :-( I got another solution now and that is working so far is to protect only the following part with collection lock like this.
>>
>>        if (txc->first_collection) {
>>          (txc->first_collection)->lock.get_read();
>>        }
>>        for (auto& o : txc->onodes) {
>>          for (auto& p : o->blob_map.blob_map) {
>>              p.bc.finish_write(txc->seq);
>>          }
>>        }
>>        if (txc->first_collection) {
>>          (txc->first_collection)->lock.put_read();
>>        }
>>
>> But, this again probably depends on my earlier question is it possible to have multiple collection id on a transaction and what is the use case of first_transaction.
>> Thoughts ?
> lgtm if my suggestion about primary collection notion is correct.
>
>
> There is probably another approach to fix the issue.
> See my PR: https://github.com/ceph/ceph/pull/10215
>
> Actually its' main purpose iss to avoid total blob_map enumeration on IO completion. But as a side effect it should probably fix the original multi-thread access issue for the current topic.
>
>>
>> Thanks & Regards
>> Somnath
>>
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org 
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Thursday, July 07, 2016 1:58 PM
>> To: Sage Weil
>> Cc: Igor Fedotov; Varada Kari; Ma, Jianpeng; Mark Nelson; ceph-devel
>> Subject: RE: segfault in bluestore during random writes
>>
>> Just for analogy, in filestore ::_do_op we do carry out transactions (_do_transactions) within osr->lock()....
>>
>> << Hmm, I think perhaps everything in submit_transaction after the 
>> osr is identified should be protected by the osr lock
>>
>> Submit_transaction or you meant Bluestore::queue_transaction() ?
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sweil@redhat.com]
>> Sent: Thursday, July 07, 2016 1:22 PM
>> To: Somnath Roy
>> Cc: Igor Fedotov; Varada Kari; Ma, Jianpeng; Mark Nelson; ceph-devel
>> Subject: RE: segfault in bluestore during random writes
>>
>> On Thu, 7 Jul 2016, Somnath Roy wrote:
>>> Sage/Igor/Varada,
>>> Shouldn't we guard _txc_add_transaction with osr->qlock as well , this resolved the issue for me..I don't think it will add any extra cost as ops within sequencer anyway is serialized.
>>>
>>>    for (vector<Transaction>::iterator p = tls.begin(); p != tls.end(); ++p) {
>>>      (*p).set_osr(osr);
>>>      txc->ops += (*p).get_num_ops();
>>>      txc->bytes += (*p).get_num_bytes();
>>>      std::lock_guard<std::mutex> l(osr->qlock);
>>>      _txc_add_transaction(txc, &(*p));
>>>    }
>> Hmm, I think perhaps everything in submit_transaction after the osr is identified should be protected by the osr lock.
>>
>> sage
>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sweil@redhat.com]
>>> Sent: Thursday, July 07, 2016 8:00 AM
>>> To: Igor Fedotov
>>> Cc: Varada Kari; Ma, Jianpeng; Somnath Roy; Mark Nelson; ceph-devel
>>> Subject: Re: segfault in bluestore during random writes
>>>
>>> On Thu, 7 Jul 2016, Igor Fedotov wrote:
>>>> Varada,
>>>>
>>>> originally I was thinking about introduction additional container 
>>>> for dirty Blobs for a transaction. By using smart pointers to Blob 
>>>> class instances one can easily implement this. But it appeared that 
>>>> we don't use such pointers for Blobs in other places hence it's not 
>>>> that easy to introduce. And probably additional lock is good enough 
>>>> solution in the current code. Will think about that a bit more though. Or let's wait for comments from Sage.
>>> Your diagnosis is right... I was thinking the cache->lock covered this but it doesn't protect us while we enumerate the Blobs.
>>>
>>> I think the best way to solve this is probably to fix
>>>
>>>        // FIXME: use a per-txc dirty blob list?
>>>
>>> at the same time, and to make Blob refcounted.  Take a reference to Blob when it is part of the BlobMap intrusive set, and take another when it is on the txc writing list(/vector).  That we we don't need a new lock *and* we avoid traversing the entire blob_map looking for blob buffers to mark clean.
>>>
>>>> BTW probably I missed something but I can't find the location where 
>>>> Blob instance is released now for out case (i.e. when it's erased 
>>>> from the blob map).  The only release location I found is at 
>>>> BlobMap::_clear but it doesn't cover our case IMHO. Any ideas? Or we have some mem leak here?
>>> Yeah I think it's a leak.  Probably need a delete b (or rather, b->put(), if we make Blob a RefCountedObject) in _wctx_finish.
>>>
>>> sage
>>>
>>>>
>>>>
>>>> On 07.07.2016 16:30, Varada Kari wrote:
>>>>> Hi Igor,
>>>>>
>>>>> I also have the similar fix. Haven't tested yet completely.
>>>>> When i checked the blob id in the failed case, it was zero all the time.
>>>>> That verifies the same theory what you have.
>>>>>
>>>>> But i am wondering, how can we eliminate the lock here? we still 
>>>>> need to have the lock when reading the blob_map entries and we 
>>>>> have to maintain the order while making the changes to blob_map.
>>>>> please correct me i have understood wrongly.
>>>>>
>>>>> Varada
>>>>>
>>>>> On Thursday 07 July 2016 06:44 PM, Igor Fedotov wrote:
>>>>>> Below is the patch that seems to fix the issue.
>>>>>>
>>>>>> The root cause IMO is a conflict between blob map removal at 
>>>>>> _wctx_finish and enumerating over the same blob_map performed at 
>>>>>> io completion (_txt_state_proc).
>>>>>>
>>>>>> The case occurs when the first transaction did the async write to 
>>>>>> some blob and subsequent transaction overwrite this blob. As a 
>>>>>> result transaction 1 IO completion may interfere with write 
>>>>>> finish processing for the second one - trans 1 updates buffer 
>>>>>> cache and enumerates dirty blobs while trans 2 erases overwritten blob.
>>>>>>
>>>>>>
>>>>>> This patch isn't  a final fix, it's rather a way to confirm that 
>>>>>> the root cause is correct.
>>>>>>
>>>>>> Works for me but I'd like someone else to verify it fixes the issue too.
>>>>>>
>>>>>> Proper fix should probably refactor the code and introduce 
>>>>>> additional container for dirty blobs as suggested by the FIXME at _txt_state_proc.
>>>>>>
>>>>>>
>>>>>> diff --git a/src/os/bluestore/BlueStore.cc 
>>>>>> b/src/os/bluestore/BlueStore.cc
>>>>>>
>>>>>> index 823ec14..8571e17 100644
>>>>>> --- a/src/os/bluestore/BlueStore.cc
>>>>>> +++ b/src/os/bluestore/BlueStore.cc
>>>>>> @@ -4618,6 +4618,7 @@ void BlueStore::_txc_state_proc(TransContext *txc)
>>>>>>           txc->state = TransContext::STATE_KV_QUEUED;
>>>>>>           // FIXME: use a per-txc dirty blob list?
>>>>>>           for (auto& o : txc->onodes) {
>>>>>> +    std::unique_lock<std::mutex> lck(o->blobmap_lock);
>>>>>>         for (auto& p : o->blob_map.blob_map) {
>>>>>>           p.bc.finish_write(txc->seq);
>>>>>>         }
>>>>>> @@ -6137,6 +6138,7 @@ void BlueStore::_wctx_finish(
>>>>>>           dout(20) << __func__ << " rm blob " << *b << dendl;
>>>>>>           txc->statfs_delta.compressed() -=
>>>>>> b->blob.get_compressed_payload_length();
>>>>>>           if (l.blob >= 0) {
>>>>>> +    std::unique_lock<std::mutex> lck(o->blobmap_lock);
>>>>>>         o->blob_map.erase(b);
>>>>>>           } else {
>>>>>>         o->bnode->blob_map.erase(b); diff --git 
>>>>>> a/src/os/bluestore/BlueStore.h b/src/os/bluestore/BlueStore.h 
>>>>>> index f380cc9..7493f18 100644
>>>>>> --- a/src/os/bluestore/BlueStore.h
>>>>>> +++ b/src/os/bluestore/BlueStore.h
>>>>>> @@ -482,6 +482,8 @@ public:
>>>>>>         BlobMap blob_map;       ///< local blobs (this onode onode)
>>>>>>
>>>>>>         std::mutex flush_lock;  ///< protect flush_txns
>>>>>> +    std::mutex blobmap_lock;
>>>>>> +
>>>>>>         std::condition_variable flush_cond;   ///< wait here for unapplied
>>>>>> txns
>>>>>>         set<TransContext*> flush_txns;   ///< committing or wal txns
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 07.07.2016 11:30, Varada Kari wrote:
>>>>>>> One more observation on the same lines as Ma Jianpeng,
>>>>>>>
>>>>>>> For the same onode i see 17 references and 16 flushing_txns. I 
>>>>>>> think we are getting parallel txns running on the same object.
>>>>>>> (gdb) p *(o.px)
>>>>>>> $8 = {
>>>>>>>      nref = {
>>>>>>>        _M_i = 17
>>>>>>>      },
>>>>>>>      oid = {
>>>>>>>        hobj = {
>>>>>>>          oid = {
>>>>>>>            name = "rbd_data.100f6b8b4567.", '0' <repeats 14 times>, "1d"
>>>>>>> ...
>>>>>>> flush_txns = std::set with 16 elements = {
>>>>>>>        [0] = 0x7fdbbcb73980,
>>>>>>>        [1] = 0x7fdbe7dd3400,
>>>>>>>        [2] = 0x7fdbe7dd3900,
>>>>>>>        [3] = 0x7fdbf7c3cd00,
>>>>>>>        [4] = 0x7fdc00f46280,
>>>>>>>        [5] = 0x7fdc00f46c80,
>>>>>>>        [6] = 0x7fdc00f47900,
>>>>>>>        [7] = 0x7fdc00f48080,
>>>>>>>        [8] = 0x7fdc00f48300,
>>>>>>>        [9] = 0x7fdc00f48800,
>>>>>>>        [10] = 0x7fdc00f49200,
>>>>>>>        [11] = 0x7fdc00f49700,
>>>>>>>        [12] = 0x7fdc09a63680,
>>>>>>>        [13] = 0x7fdc0ca11e00,
>>>>>>>        [14] = 0x7fdc0ca12a80,
>>>>>>>        [15] = 0x7fdc12c2f480
>>>>>>>
>>>>>>> I have written my object with 8K before and overwriting with 64k 
>>>>>>> now, which is showing this behavior.
>>>>>>> But does allowing parallel writes harm if they are writing to 
>>>>>>> different offset and length and guarantee the order? we can 
>>>>>>> check the overlap and not allow write if they have a overlap, 
>>>>>>> else we are okay to run parallel writes to the object.
>>>>>>> In this case we are missing some locking while updating the blob_map.
>>>>>>> Still not able to figure of the exact location.
>>>>>>>
>>>>>>> Varada
>>>>>>>
>>>>>>>
>>>>>>> On Thursday 07 July 2016 01:23 PM, Ma, Jianpeng wrote:
>>>>>>>> I add some debug messges  and the message as followings when 
>>>>>>>> bug
>>>>>>>> reproduce:
>>>>>>>>
>>>>>>>> 3305972   -102> 2016-07-07 23:48:12.541535 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) queue_transactions existing
>>>>>>>> 0xac78760 osr(0.4f 0xb6d2d80)
>>>>>>>> 3305973   -101> 2016-07-07 23:48:12.541548 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_create osr
>>>>>>>> 0xac78760 =
>>>>>>>> 0x177b0000 seq 611
>>>>>>>> 3305974   -100> 2016-07-07 23:48:12.541563 7f7f4449c700 15
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _write 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 0x1a0000~10000
>>>>>>>> 3305975    -99> 2016-07-07 23:48:12.541574 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 0x1a0000~10000 - have 0x400000 (4194304) bytes         in 64 lextents
>>>>>>>> 3305976    -98> 2016-07-07 23:48:12.541581 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write prefer csum_order 
>>>>>>>> 12 comp_blob_size 0x40000
>>>>>>>> 3305977    -97> 2016-07-07 23:48:12.541608 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write_big
>>>>>>>> 0x1a0000~10000 max_blob_len 0x10000 compress 0
>>>>>>>> 3305978    -96> 2016-07-07 23:48:12.541617 7f7f4449c700 20
>>>>>>>> bluestore.BufferSpace(0x12012ea8 in 0xa02f240) _discard 0x0~10000
>>>>>>>> 3305979    -95> 2016-07-07 23:48:12.541626 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write_big  lex 0x1a0000:
>>>>>>>> 0x0~10000->91
>>>>>>>> 3305980    -94> 2016-07-07 23:48:12.541630 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write_big  blob 
>>>>>>>> 91:blob([] clen 0x0 ref_map(0x0~10000=1))
>>>>>>>> 3305981    -93> 2016-07-07 23:48:12.541634 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_alloc_write txc
>>>>>>>> 0x177b0000 1 blobs
>>>>>>>> 3305982    -92> 2016-07-07 23:48:12.541638 7f7f4449c700 10
>>>>>>>> bitmapalloc:reserve instance 174395776 num_used 1600847 total 18350080
>>>>>>>> 3305983    -91> 2016-07-07 23:48:12.541641 7f7f4449c700 10
>>>>>>>> bitmapalloc:allocate instance 174395776 want_size 0x10000 
>>>>>>>> alloc_unit
>>>>>>>> 0x1000 hint 0x0
>>>>>>>> 3305984    -90> 2016-07-07 23:48:12.541642 7f7f55cbf700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0xedfef00 aio_wait
>>>>>>>> 3305985    -89> 2016-07-07 23:48:12.541651 7f7f55cbf700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finish_io 0xedfef00
>>>>>>>> 3305986    -88> 2016-07-07 23:48:12.541653 7f7f55cbf700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0xedfef00 io_done
>>>>>>>> 3305987    -87> 2016-07-07 23:48:12.541656 7f7f55cbf700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_procIO_DONE txc
>>>>>>>> 0xedfef00
>>>>>>>> 3305988    -86> 2016-07-07 23:48:12.541659 7f7f55cbf700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc onode 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# 0 size=65
>>>>>>>> 3305989    -85> 2016-07-07 23:48:12.541674 7f7f55cbf700 20
>>>>>>>> bluestore.BufferSpace(0x12012548 in 0xa02f240) finish_write
>>>>>>>> buffer(0x177d7480 space 0x12012548 0x0~10000 writing nocache)
>>>>>>>> 3305990    -84> 2016-07-07 23:48:12.541680 7f7f55cbf700 20
>>>>>>>> bluestore.BufferSpace(0x12012ea8 in 0xa02f240) finish_write
>>>>>>>> buffer(0x177d75c0 space 0x12012ea8 0x0~10000 writing nocache)
>>>>>>>> 3305991    -83> 2016-07-07 23:48:12.541684 7f7f55cbf700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc 2
>>>>>>>> 3305992    -82> 2016-07-07 23:48:12.541715 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _kv_sync_thread wake
>>>>>>>> 3305993    -81> 2016-07-07 23:48:12.541742 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _kv_sync_thread committing
>>>>>>>> 1 cleaning 0
>>>>>>>> 3305994    -80> 2016-07-07 23:48:12.541747 7f7f4ccad700 10
>>>>>>>> bitmapalloc:commit_start instance 174395776 releasing 65536 in 
>>>>>>>> extents
>>>>>>>> 1
>>>>>>>> 3305995    -79> 2016-07-07 23:48:12.541752 7f7f4449c700 20
>>>>>>>> bitmapalloc:allocate instance 174395776 offset 0xc0520000 
>>>>>>>> length
>>>>>>>> 0x10000
>>>>>>>> 3305996    -78> 2016-07-07 23:48:12.541757 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_alloc_write blob 
>>>>>>>> 91:blob([0xc0520000~10000] clen 0x0 mutable ref_map(0x0~10000=1))
>>>>>>>> csum_order 12 csum_length 0x        10000
>>>>>>>> 3305997    -77> 2016-07-07 23:48:12.541784 7f7f4449c700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish onode 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 3305998    -76> 2016-07-07 23:48:12.541795 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish lex_old 
>>>>>>>> [0x0~10000->27]
>>>>>>>> 3305999    -75> 2016-07-07 23:48:12.541801 7f7f4449c700 20
>>>>>>>> bluestore.BufferSpace(0xd2c7c98 in 0xa02f240) _discard 0x0~10000
>>>>>>>> 3306000    -74> 2016-07-07 23:48:12.541804 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish release
>>>>>>>> 0xc06d0000~10000
>>>>>>>> 3306001    -73> 2016-07-07 23:48:12.541807 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish rm blob 
>>>>>>>> 27:blob([!~10000] clen 0x0 mutable+csum crc32c/0x1000)
>>>>>>>> 3306002    -72> 2016-07-07 23:48:12.541818 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _write 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 0x1a0000~10000 = 0
>>>>>>>> 3306003    -71> 2016-07-07 23:48:12.541829 7f7f4449c700 15
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _setattrs 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# 2 keys
>>>>>>>> 3306004    -70> 2016-07-07 23:48:12.541836 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _setattrs 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# 2 keys = 0
>>>>>>>> 3306005    -69> 2016-07-07 23:48:12.541844 7f7f4449c700 15
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _omap_setkeys 0.4f_head 
>>>>>>>> #0:f2000000::::head#
>>>>>>>> 3306006    -68> 2016-07-07 23:48:12.541856 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _omap_setkeys 0.4f_head 
>>>>>>>> #0:f2000000::::head# = 0
>>>>>>>> 3306007    -67> 2016-07-07 23:48:12.541855 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finalize_kv txc
>>>>>>>> 0xedfef00 allocated 0x[c0510000~10000] released 0x[c06c0000~10000]
>>>>>>>> 3306008    -66> 2016-07-07 23:48:12.541863 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_write_nodes txc
>>>>>>>> 0x177b0000 onodes 0xa662000 bnodes
>>>>>>>> 3306009    -65> 2016-07-07 23:48:12.541864 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finalize_kv overlap 
>>>>>>>> 0x[], new allocated 0x[c0510000~10000] released 0x[c06c0000~10000]
>>>>>>>> 3306010    -64> 2016-07-07 23:48:12.541868 7f7f4ccad700 10 freelist
>>>>>>>> allocate 0xc0510000~10000
>>>>>>>> 3306011    -63> 2016-07-07 23:48:12.541870 7f7f4ccad700 20 freelist
>>>>>>>> _xor first_key 0xc0500000 last_key 0xc0500000
>>>>>>>> 3306012    -62> 2016-07-07 23:48:12.541881 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finalize_kv release
>>>>>>>> 0xc06c0000~10000
>>>>>>>> 3306013    -61> 2016-07-07 23:48:12.541884 7f7f4ccad700 10 freelist
>>>>>>>> release 0xc06c0000~10000
>>>>>>>> 3306014    -60> 2016-07-07 23:48:12.541886 7f7f4ccad700 20 freelist
>>>>>>>> _xor first_key 0xc0680000 last_key 0xc0680000
>>>>>>>> 3306015    -59> 2016-07-07 23:48:12.541890 7f7f4ccad700 10
>>>>>>>> bitmapalloc:release 0xc06c0000~10000
>>>>>>>> 3306016    -58> 2016-07-07 23:48:12.541954 7f7f4ccad700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2)
>>>>>>>> _balance_bluefs_freespace bluefs
>>>>>>>> 2868 M free (0.999654) bluestore 65426 M free (0.91276), 
>>>>>>>> bluefs_ratio
>>>>>>>> 0.0419945
>>>>>>>> 3306017    -57> 2016-07-07 23:48:12.541967 7f7f4449c700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_write_nodes  onode 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# is 6551
>>>>>>>> 3306018    -56> 2016-07-07 23:48:12.542026 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0x177b0000 prepare
>>>>>>>> 3306019    -55> 2016-07-07 23:48:12.542031 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _kv_sync_thread committed
>>>>>>>> 1 cleaned 0 in 0.000284
>>>>>>>> 3306020    -54> 2016-07-07 23:48:12.542037 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_aio_submit txc 0x177b0000
>>>>>>>> 3306021    -53> 2016-07-07 23:48:12.542037 7f7f4ccad700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0xedfef00 kv_queued
>>>>>>>> 3306022    -52> 2016-07-07 23:48:12.542044 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finish_kv txc 0xedfef00
>>>>>>>> 3306023    -51> 2016-07-07 23:48:12.542054 7f7f4ccad700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0xedfef00 finishing
>>>>>>>> 3306024    -50> 2016-07-07 23:48:12.542057 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finish 0xedfef00 
>>>>>>>> onodes
>>>>>>>> 0xa662000
>>>>>>>> 3306025    -49> 2016-07-07 23:48:12.542059 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finish onode
>>>>>>>> 0xa662000 had
>>>>>>>> 0xedfef00,0x177b0000
>>>>>>>> 3306026    -48> 2016-07-07 23:48:12.542066 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _osr_reap_done osr 0xac78760
>>>>>>>> 3306027    -47> 2016-07-07 23:48:12.542068 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _osr_reap_done  txc 0xedfef00 done
>>>>>>>> 3306028    -46> 2016-07-07 23:48:12.542074 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _osr_reap_done  txc
>>>>>>>> 0x177b0000 aio_wait
>>>>>>>> 3306029    -45> 2016-07-07 23:48:12.542077 7f7f4ccad700 20
>>>>>>>> bluestore.2QCache(0xa02f240) trim onodes 140 / 16384 buffers
>>>>>>>> 0 /
>>>>>>>> 536870912
>>>>>>>> 3306030    -44> 2016-07-07 23:48:12.542081 7f7f4ccad700 10
>>>>>>>> bitmapalloc:commit_finish instance 174395776 released 65536 in 
>>>>>>>> extents
>>>>>>>> 1
>>>>>>>> 3306031    -43> 2016-07-07 23:48:12.542084 7f7f4ccad700 20
>>>>>>>> bitmapalloc:insert_free instance 174395776 off 0xc06b0000 len 0x10000
>>>>>>>> 3306032    -42> 2016-07-07 23:48:12.542090 7f7f4ccad700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _reap_collections all reaped
>>>>>>>> 3306033    -41> 2016-07-07 23:48:12.542093 7f7f4ccad700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _kv_sync_thread sleep
>>>>>>>> 3306034    -40> 2016-07-07 23:48:12.542110 7f7f4449c700  5 -- op
>>>>>>>> tracker -- seq: 57709, time: 2016-07-07 23:48:12.542109, event:
>>>>>>>> reached_pg, op: osd_op(client.4112.0:176011 0.de0d304f
>>>>>>>> (undecoded)
>>>>>>>> ack+ondisk+wri        te+known_if_redirected e19)
>>>>>>>> 3306035    -39> 2016-07-07 23:48:12.542168 7f7f4449c700  5 -- op
>>>>>>>> tracker -- seq: 57709, time: 2016-07-07 23:48:12.542167, event:
>>>>>>>> started, op: osd_op(client.4112.0:176011 0.de0d304f
>>>>>>>> rbd_data.100d2ae8944a.0000000        000000095 [write 1769472~65536]
>>>>>>>> snapc 0=[] ack+ondisk+write+known_if_redirected e19)
>>>>>>>> 3306036    -38> 2016-07-07 23:48:12.542248 7f7f4449c700  5 write_log
>>>>>>>> with: dirty_to: 0'0, dirty_from:
>>>>>>>> 4294967295'18446744073709551615,
>>>>>>>> dirty_divergent_priors: false, divergent_priors: 0, writeout_from:
>>>>>>>> 19'604,         trimmed:
>>>>>>>> 3306037    -37> 2016-07-07 23:48:12.542276 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) queue_transactions existing
>>>>>>>> 0xac78760 osr(0.4f 0xb6d2d80)
>>>>>>>> 3306038    -36> 2016-07-07 23:48:12.542288 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_create osr
>>>>>>>> 0xac78760 =
>>>>>>>> 0x1252f980 seq 612
>>>>>>>> 3306039    -35> 2016-07-07 23:48:12.542303 7f7f4449c700 15
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _write 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 0x1b0000~10000
>>>>>>>> 3306040    -34> 2016-07-07 23:48:12.542315 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 0x1b0000~10000 - have 0x400000 (4194304) bytes         in 64 lextents
>>>>>>>> 3306041    -33> 2016-07-07 23:48:12.542321 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write prefer csum_order 
>>>>>>>> 12 comp_blob_size 0x40000
>>>>>>>> 3306042    -32> 2016-07-07 23:48:12.542324 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write_big
>>>>>>>> 0x1b0000~10000 max_blob_len 0x10000 compress 0
>>>>>>>> 3306043    -31> 2016-07-07 23:48:12.542328 7f7f4449c700 20
>>>>>>>> bluestore.BufferSpace(0x12013358 in 0xa02f240) _discard 0x0~10000
>>>>>>>> 3306044    -30> 2016-07-07 23:48:12.542336 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write_big  lex 0x1b0000:
>>>>>>>> 0x0~10000->92
>>>>>>>> 3306045    -29> 2016-07-07 23:48:12.542339 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_write_big  blob 
>>>>>>>> 92:blob([] clen 0x0 ref_map(0x0~10000=1))
>>>>>>>> 3306046    -28> 2016-07-07 23:48:12.542344 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_alloc_write txc
>>>>>>>> 0x1252f980 1 blobs
>>>>>>>> 3306047    -27> 2016-07-07 23:48:12.542346 7f7f4449c700 10
>>>>>>>> bitmapalloc:reserve instance 174395776 num_used 1600847 total 18350080
>>>>>>>> 3306048    -26> 2016-07-07 23:48:12.542350 7f7f4449c700 10
>>>>>>>> bitmapalloc:allocate instance 174395776 want_size 0x10000 
>>>>>>>> alloc_unit
>>>>>>>> 0x1000 hint 0x0
>>>>>>>> 3306049    -25> 2016-07-07 23:48:12.542442 7f7f4449c700 20
>>>>>>>> bitmapalloc:allocate instance 174395776 offset 0xc0530000 
>>>>>>>> length
>>>>>>>> 0x10000
>>>>>>>> 3306050    -24> 2016-07-07 23:48:12.542455 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _do_alloc_write blob 
>>>>>>>> 92:blob([0xc0530000~10000] clen 0x0 mutable ref_map(0x0~10000=1))
>>>>>>>> csum_order 12 csum_length 0x        10000
>>>>>>>> 3306051    -23> 2016-07-07 23:48:12.542437 7f7f55cbf700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0x177b0000 aio_wait
>>>>>>>> 3306052    -22> 2016-07-07 23:48:12.542482 7f7f4449c700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish onode 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 3306053    -21> 2016-07-07 23:48:12.542488 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish lex_old 
>>>>>>>> [0x0~10000->28]
>>>>>>>> 3306054    -20> 2016-07-07 23:48:12.542485 7f7f55cbf700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_finish_io 0x177b0000
>>>>>>>> 3306055    -19> 2016-07-07 23:48:12.542492 7f7f55cbf700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0x177b0000 io_done
>>>>>>>> 3306056    -18> 2016-07-07 23:48:12.542493 7f7f4449c700 20
>>>>>>>> bluestore.BufferSpace(0xd661088 in 0xa02f240) _discard 0x0~10000
>>>>>>>> 3306057    -17> 2016-07-07 23:48:12.542495 7f7f55cbf700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_procIO_DONE txc
>>>>>>>> 0x177b0000
>>>>>>>> 3306058    -16> 2016-07-07 23:48:12.542496 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish release
>>>>>>>> 0xc06e0000~10000
>>>>>>>> 3306059    -15> 2016-07-07 23:48:12.542500 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _wctx_finish rm blob 
>>>>>>>> 28:blob([!~10000] clen 0x0 mutable+csum crc32c/0x1000)
>>>>>>>> 3306060    -14> 2016-07-07 23:48:12.542499 7f7f55cbf700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc onode 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# 0 size=65
>>>>>>>> 3306061    -13> 2016-07-07 23:48:12.542510 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _write 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head#
>>>>>>>> 0x1b0000~10000 = 0
>>>>>>>> 3306062    -12> 2016-07-07 23:48:12.542520 7f7f4449c700 15
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _setattrs 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# 2 keys
>>>>>>>> 3306063    -11> 2016-07-07 23:48:12.542527 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _setattrs 0.4f_head 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# 2 keys = 0
>>>>>>>> 3306064    -10> 2016-07-07 23:48:12.542535 7f7f4449c700 15
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _omap_setkeys 0.4f_head 
>>>>>>>> #0:f2000000::::head#
>>>>>>>> 3306065     -9> 2016-07-07 23:48:12.542547 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _omap_setkeys 0.4f_head 
>>>>>>>> #0:f2000000::::head# = 0
>>>>>>>> 3306066     -8> 2016-07-07 23:48:12.542553 7f7f4449c700 20
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_write_nodes txc
>>>>>>>> 0x1252f980 onodes 0xa662000 bnodes
>>>>>>>> 3306067     -7> 2016-07-07 23:48:12.542656 7f7f4449c700  0
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_write_nodes  onode 
>>>>>>>> #0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head# is 6552
>>>>>>>> 3306068     -6> 2016-07-07 23:48:12.542703 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_state_proc txc
>>>>>>>> 0x1252f980 prepare
>>>>>>>> 3306069     -5> 2016-07-07 23:48:12.542712 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) _txc_aio_submit txc 0x1252f980
>>>>>>>> 3306070     -4> 2016-07-07 23:48:12.542800 7f7f4449c700  5 -- op
>>>>>>>> tracker -- seq: 57710, time: 2016-07-07 23:48:12.542800, event:
>>>>>>>> reached_pg, op: osd_op(client.4112.0:176012 0.de0d304f
>>>>>>>> (undecoded)
>>>>>>>> ack+ondisk+wri        te+known_if_redirected e19)
>>>>>>>> 3306071     -3> 2016-07-07 23:48:12.542860 7f7f4449c700  5 -- op
>>>>>>>> tracker -- seq: 57710, time: 2016-07-07 23:48:12.542859, event:
>>>>>>>> started, op: osd_op(client.4112.0:176012 0.de0d304f
>>>>>>>> rbd_data.100d2ae8944a.0000000        000000095 [write 1835008~65536]
>>>>>>>> snapc 0=[] ack+ondisk+write+known_if_redirected e19)
>>>>>>>> 3306072     -2> 2016-07-07 23:48:12.542940 7f7f4449c700  5 write_log
>>>>>>>> with: dirty_to: 0'0, dirty_from:
>>>>>>>> 4294967295'18446744073709551615,
>>>>>>>> dirty_divergent_priors: false, divergent_priors: 0, writeout_from:
>>>>>>>> 19'605,         trimmed:
>>>>>>>> 3306073     -1> 2016-07-07 23:48:12.542979 7f7f4449c700 10
>>>>>>>> bluestore(/mnt/ceph/build/dev/osd2) queue_transactions existing
>>>>>>>> 0xac78760 osr(0.4f 0xb6d2d80)
>>>>>>>> 3306074      0> 2016-07-07 23:48:12.547121 7f7f55cbf700 -1 *** Caught
>>>>>>>> signal (Segmentation fault) **
>>>>>>>> 3306075  in thread 7f7f55cbf700 thread_name:bstore_aio
>>>>>>>> 3306076
>>>>>>>> 3306077  ceph version v11.0.0-373-g7dedce8
>>>>>>>> (7dedce8a6e0474d4d14f9aa509428bab84d075af)
>>>>>>>> 3306078  1: /mnt/ceph/build/bin/ceph-osd() [0xc329ae]
>>>>>>>> 3306079  2: (()+0x10a00) [0x7f7f62923a00]
>>>>>>>> 3306080  3:
>>>>>>>> (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x8cb)
>>>>>>>> [0xb4798b]
>>>>>>>> 3306081  4:
>>>>>>>> (BlueStore::_txc_finish_io(BlueStore::TransContext*)+0x1bf)
>>>>>>>> [0xb4801f]
>>>>>>>> 3306082  5:
>>>>>>>> (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x27f)
>>>>>>>> [0xb4733f]
>>>>>>>> 3306083  6: (KernelDevice::_aio_thread()+0x912) [0xc1a872]
>>>>>>>> 3306084  7: (KernelDevice::AioCompletionThread::entry()+0xd)
>>>>>>>> [0xc1d81d]
>>>>>>>> 3306085  8: (()+0x761a) [0x7f7f6291a61a]
>>>>>>>> 3306086  9: (clone()+0x6d) [0x7f7f6059959d]
>>>>>>>> 3306087  NOTE: a copy of the executable, or `objdump -rdS 
>>>>>>>> <executable>` is needed to interpret this.
>>>>>>>>
>>>>>>>>
>>>>>>>> the previous TransContext (3306060)in STATE_IO_DONE and current 
>>>>>>>> TransaContext call _write(3306039 ). And they handle the same 
>>>>>>>> object(0:f20cb07b:::rbd_data.100d2ae8944a.0000000000000095:head). So the blob_map modify be current TransContext. I always thought:
>>>>>>>> objectstore don't allow the two or more write op for same object.
>>>>>>>> ObjectContext:: ondisk_write_lock will block the later write op 
>>>>>>>> until objectstore call on_commit/on_readable Context.
>>>>>>>> But in fact, ondisk_write_lock don't prevent other write op.
>>>>>>>>
>>>>>>>> I think the simple method is add o->flush().
>>>>>>>> Or am I missing something?
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: ceph-devel-owner@vger.kernel.org 
>>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath 
>>>>>>>> Roy
>>>>>>>> Sent: Wednesday, July 6, 2016 10:48 PM
>>>>>>>> To: Mark Nelson <mnelson@redhat.com>; Varada Kari 
>>>>>>>> <Varada.Kari@sandisk.com>; ceph-devel 
>>>>>>>> <ceph-devel@vger.kernel.org>
>>>>>>>> Subject: RE: segfault in bluestore during random writes
>>>>>>>>
>>>>>>>> I got it ~6/23 , so we need to look for commits before that..
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Mark Nelson [mailto:mnelson@redhat.com]
>>>>>>>> Sent: Wednesday, July 06, 2016 7:45 AM
>>>>>>>> To: Somnath Roy; Varada Kari; ceph-devel
>>>>>>>> Subject: Re: segfault in bluestore during random writes
>>>>>>>>
>>>>>>>> Ah, sorry I missed it.  Do you remember when you first encountered it?
>>>>>>>> Might help track down the commit where it first appeared.
>>>>>>>>
>>>>>>>> Mark
>>>>>>>>
>>>>>>>> On 07/06/2016 09:32 AM, Somnath Roy wrote:
>>>>>>>>> Mark,
>>>>>>>>> This is the same trace I got (and posted in community) while 
>>>>>>>>> you were in vacation. I can still reproduce this in my setup easily.
>>>>>>>>>
>>>>>>>>> Thanks & Regards
>>>>>>>>> Somnath
>>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: ceph-devel-owner@vger.kernel.org 
>>>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark 
>>>>>>>>> Nelson
>>>>>>>>> Sent: Wednesday, July 06, 2016 7:02 AM
>>>>>>>>> To: Varada Kari; ceph-devel
>>>>>>>>> Subject: Re: segfault in bluestore during random writes
>>>>>>>>>
>>>>>>>>> Oh, sorry, this wasn't memdbstore, this was trim cache on 
>>>>>>>>> reads which got applied earlier this week.  I was testing
>>>>>>>>> 06178de9 with the trim cache on reads PR applied.
>>>>>>>>>
>>>>>>>>> Mark
>>>>>>>>>
>>>>>>>>> On 07/06/2016 07:00 AM, Mark Nelson wrote:
>>>>>>>>>> Hi Varada,
>>>>>>>>>>
>>>>>>>>>> Ah, this version happens to be with the memstoredb patch 
>>>>>>>>>> applied, though it is unused in this test.  I don't believe 
>>>>>>>>>> this should be causing the problem, but I'll verify it is 
>>>>>>>>>> happening without that patch as well.
>>>>>>>>>>
>>>>>>>>>> Mark
>>>>>>>>>>
>>>>>>>>>> On 07/06/2016 01:45 AM, Varada Kari wrote:
>>>>>>>>>>> Hi mark,
>>>>>>>>>>>
>>>>>>>>>>> I have tried reproducing the issue with latest master, so 
>>>>>>>>>>> far no luck with 128k and 512k block sizes on a 1000GB rbd image.
>>>>>>>>>>> I couldn't find
>>>>>>>>>>> #5e07e5a3446ee39189c5b959be624411561175f5 in master, are you 
>>>>>>>>>>> using any private changes?
>>>>>>>>>>>
>>>>>>>>>>> I will try some more time today to reproduce the issue.
>>>>>>>>>>> Seems blob map got corrupted in your case.
>>>>>>>>>>>
>>>>>>>>>>> Varada
>>>>>>>>>>>
>>>>>>>>>>> On Tuesday 05 July 2016 09:06 PM, Mark Nelson wrote:
>>>>>>>>>>>> Hi Guys,
>>>>>>>>>>>>
>>>>>>>>>>>> This is primarily for Varada but if anyone else wants to 
>>>>>>>>>>>> take a look feel free.  We are hitting segfaults in 
>>>>>>>>>>>> tc_state_proc during random writes.  I was able to 
>>>>>>>>>>>> reproduce with logging enabled and got a core dump.
>>>>>>>>>>>> I've only briefly looked at the code/logs, but I haven't 
>>>>>>>>>>>> really looked through it in earnest yet.
>>>>>>>>>>>> Unfortunately the
>>>>>>>>>>>> logs are about 4GB and the core dump is 2GB, so I'll only 
>>>>>>>>>>>> attach the last 10k lines.
>>>>>>>>>>>> Hopefully it should be fairly reproducible.  I'll try to 
>>>>>>>>>>>> see if I can narrow down commits that have touched the 
>>>>>>>>>>>> write path over the last 4 weeks and see if anything looks 
>>>>>>>>>>>> relevant.
>>>>>>>>>>>>
>>>>>>>>>>>> Varada: let me know if you can reproduce.  Thanks!
>>>>>>>>>>>>
>>>>>>>>>>>> gdb bt:
>>>>>>>>>>>>
>>>>>>>>>>>>> (gdb) bt
>>>>>>>>>>>>> #0  0x00007f9c59708fcb in raise (sig=11) at
>>>>>>>>>>>>> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:37
>>>>>>>>>>>>> #1  0x0000000000bd7505 in reraise_fatal
>>>>>>>>>>>>> (signum=11) at
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/global/signal_ha
>>>>>>>>>>>>> nd
>>>>>>>>>>>>> ler.cc:69
>>>>>>>>>>>>> #2  handle_fatal_signal (signum=11) at 
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/global/signal_ha
>>>>>>>>>>>>> nd
>>>>>>>>>>>>> ler.cc:133
>>>>>>>>>>>>> #3  <signal handler called>
>>>>>>>>>>>>> #4  next_node (node=<synthetic pointer>) at 
>>>>>>>>>>>>> /usr/include/boost/intrusive/detail/tree_algorithms.
>>>>>>>>>>>>> hpp:446
>>>>>>>>>>>>> #5  next_node (p=<synthetic pointer>) at 
>>>>>>>>>>>>> /usr/include/boost/intrusive/rbtree_algorithms.hpp
>>>>>>>>>>>>> :3
>>>>>>>>>>>>> 52
>>>>>>>>>>>>> #6  operator++ (this=<synthetic pointer>) at
>>>>>>>>>>>>> /usr/include/boost/intrusive/detail/tree_node.hpp:
>>>>>>>>>>>>> 12
>>>>>>>>>>>>> 8
>>>>>>>>>>>>> #7  BlueStore::_txc_state_proc (this=this@entry=0xaff6000,
>>>>>>>>>>>>> txc=txc@entry=0x192c8c80) at 
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/Blu
>>>>>>>>>>>>> eS
>>>>>>>>>>>>> tore.cc:4568
>>>>>>>>>>>>> #8  0x0000000000aeddb7 in
>>>>>>>>>>>>> BlueStore::_txc_finish_io
>>>>>>>>>>>>> (this=this@entry=0xaff6000,
>>>>>>>>>>>>> txc=txc@entry=0x192c8c80) at 
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/Blu
>>>>>>>>>>>>> eS
>>>>>>>>>>>>> tore.cc:4669
>>>>>>>>>>>>> #9  0x0000000000aed23f in
>>>>>>>>>>>>> BlueStore::_txc_state_proc (this=0xaff6000,
>>>>>>>>>>>>> txc=0x192c8c80) at
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/Blu
>>>>>>>>>>>>> eS
>>>>>>>>>>>>> tore.cc:4559
>>>>>>>>>>>>> #10 0x0000000000bc134a in
>>>>>>>>>>>>> KernelDevice::_aio_thread
>>>>>>>>>>>>> (this=0xaf20960) at
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/Ker
>>>>>>>>>>>>> ne
>>>>>>>>>>>>> lDevice.cc:270
>>>>>>>>>>>>> #11 0x0000000000bc588d in
>>>>>>>>>>>>> KernelDevice::AioCompletionThread::entry
>>>>>>>>>>>>> (this=<optimized out>) at
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/Ker
>>>>>>>>>>>>> ne
>>>>>>>>>>>>> lDevice.h:49
>>>>>>>>>>>>> #12 0x00007f9c59701dc5 in start_thread
>>>>>>>>>>>>> (arg=0x7f9c4da2e700) at
>>>>>>>>>>>>> pthread_create.c:308
>>>>>>>>>>>>> #13 0x00007f9c575fc28d in clone () at
>>>>>>>>>>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
>>>>>>>>>>>>> (gdb) frame 7
>>>>>>>>>>>>> #7  BlueStore::_txc_state_proc (this=this@entry=0xaff6000,
>>>>>>>>>>>>> txc=txc@entry=0x192c8c80) at 
>>>>>>>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/Blu
>>>>>>>>>>>>> eS
>>>>>>>>>>>>> tore.cc:4568 4568for (auto& p :
>>>>>>>>>>>>> o->blob_map.blob_map) {
>>>>>>>>>>>> Mark
>>>>>>>>>>> PLEASE NOTE: The information contained in this electronic 
>>>>>>>>>>> mail message is intended only for the use of the designated
>>>>>>>>>>> recipient(s)
>>>>>>>>>>> named above. If the reader of this message is not the 
>>>>>>>>>>> intended recipient, you are hereby notified that you have 
>>>>>>>>>>> received this message in error and that any review, 
>>>>>>>>>>> dissemination, distribution, or copying of this message is 
>>>>>>>>>>> strictly prohibited. If you have received this communication 
>>>>>>>>>>> in error, please notify the sender by telephone or e-mail 
>>>>>>>>>>> (as shown above) immediately and destroy any and all copies 
>>>>>>>>>>> of this message in your possession (whether hard copies or 
>>>>>>>>>>> electronically stored copies).
>>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>>>>>>> ceph-devel"
>>>>>>>>>> in the body of a message to majordomo@vger.kernel.org More 
>>>>>>>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>>>>>> ceph-devel"
>>>>>>>>> in the body of a message to majordomo@vger.kernel.org More 
>>>>>>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>>>> PLEASE NOTE: The information contained in this electronic mail 
>>>>>>>>> message is intended only for the use of the designated
>>>>>>>>> recipient(s) named above. If the reader of this message is not 
>>>>>>>>> the intended recipient, you are hereby notified that you have 
>>>>>>>>> received this message in error and that any review, 
>>>>>>>>> dissemination, distribution, or copying of this message is 
>>>>>>>>> strictly prohibited. If you have received this communication 
>>>>>>>>> in error, please notify the sender by telephone or e-mail (as 
>>>>>>>>> shown above) immediately and destroy any and all copies of 
>>>>>>>>> this message in your possession (whether hard copies or electronically stored copies).
>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>>>> in the body of a message to majordomo@vger.kernel.org More 
>>>>>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>>>> ceph-devel" in the body of a message to 
>>>>>>> majordomo@vger.kernel.org More majordomo info at 
>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More 
>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>
