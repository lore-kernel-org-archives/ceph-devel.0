From: Sage Weil <sweil@redhat.com>
Subject: RE: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 16:56:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607121655130.497@piezo.us.to>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com> <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com> <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com> <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
 <e2538609-7724-5e2f-b71a-8a32c45f4479@redhat.com> <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com> <fcd816f1-057d-7cc7-d989-4c8ee5ede2db@redhat.com> <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1584280268-1468342595=:497"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52541 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbcGLQ4g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 12:56:36 -0400
In-Reply-To: <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1584280268-1468342595=:497
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jul 2016, Somnath Roy wrote:
> Mark,
> Recently, the default allocator is changed to Bitmap and I saw it is 
> returning < 0 return value only in the following case.
> 
>   count = m_bit_alloc->alloc_blocks_res(nblks, &start_blk);
>   if (count == 0) {
>     return -ENOSPC;
>   }
> 
> So, it seems it may not be the memory but db partition is getting out of 
> space (?). I never faced it so far as I was running with 100GB of db 
> partition may be. The amount of metadata write going on to the db even 
> after onode diet is starting from ~1K and over time it is reaching > 4k 
> or so (I checked for 4K RW). It is growing as extents are growing. So, 8 
> GB may not be enough. If this is true, next challenge is , how to 
> automatically (or document) the size of rocksdb db partition based on 
> the data partition size. For example, in the ZS case, we have calculated 
> that we need ~9G db space per TB. We need to do similar calculation for 
> rocksbd as well.

We can precalculate or otherwise pre-size the db partition because we 
don't know what kind of data the user is going to store, and that data 
might even be 100% omap.  This is why BlueStore and BlueFS balance their 
free space--so that the bluefs/db usage can grow and shrink dynamically as 
needed.

We'll need to implement something similar for ZS.

sage


 > 
> Thanks & Regards
> Somnath
> 
> 
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Tuesday, July 12, 2016 6:03 AM
> To: Igor Fedotov; Somnath Roy; ceph-devel
> Subject: Re: bluestore onode diet and encoding overhead
> 
> In this case I'm assigning per OSD:
> 
> 1G Data (basically the top level OSD dir) 1G WAL 8G DB 140G Block
> 
> Mark
> 
> On 07/12/2016 07:57 AM, Igor Fedotov wrote:
> > Mark,
> >
> > you can find my post named 'yet another assertion in bluestore during
> > random write' last week. It contains steps to reproduce in my case.
> >
> > Also I did some investigations (still incomplete though) with tuning
> > 'bluestore block db size' and 'bluestore block wal size'. Setting both
> > to 256M fixes the issue for me.
> >
> > But I'm still uncertain if that's a bug or just inappropriate settings...
> >
> >
> > Thanks,
> >
> > Igor
> >
> >
> > On 12.07.2016 15:48, Mark Nelson wrote:
> >> Oh, that's good to know!  Have you tracked it down at all?  I noticed
> >> pretty extreme memory usage on the OSDs still, so that might be part
> >> of it.  I'm doing a massif run now.
> >>
> >> Mark
> >>
> >> On 07/12/2016 07:40 AM, Igor Fedotov wrote:
> >>> That's similar to what I have while running my test case with vstart...
> >>> Without Somnath's settings though..
> >>>
> >>>
> >>> On 12.07.2016 15:34, Mark Nelson wrote:
> >>>> Hi Somnath,
> >>>>
> >>>> I accidentally screwed up my first run with your settings but reran
> >>>> last night.  With your tuning the OSDs are failing to allocate to
> >>>> bdev0 after about 30 minutes of testing:
> >>>>
> >>>> 2016-07-12 03:48:51.127781 7f0cef8b7700 -1 bluefs _allocate failed
> >>>> to allocate 1048576 on bdev 0, free 0; fallback to bdev 1
> >>>>
> >>>> They are able to continue running, but ultimately this leads to an
> >>>> assert later on.  I wonder if it's not compacting fast enough and
> >>>> ends up consuming the entire disk with stale metadata.
> >>>>
> >>>> 2016-07-12 04:31:02.631982 7f0cef8b7700 -1
> >>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: In
> >>>> function 'int BlueFS::_allocate(unsigned int, uint64_t,
> >>>> std::vector<bluefs_extent_t>*)' thread 7f0cef8b7700 time 2016-07-12
> >>>> 04:31:02.627138
> >>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: 1398:
> >>>> FAILED
> >>>> assert(0 == "allocate failed... wtf")
> >>>>
> >>>>  ceph version v10.0.4-6936-gc7da2f7
> >>>> (c7da2f7c869694246650a9276a2b67aed9bf818f)
> >>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >>>> const*)+0x85) [0xd4cb75]
> >>>>  2: (BlueFS::_allocate(unsigned int, unsigned long,
> >>>> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t>
> >>>> >*)+0x760) [0xb98220]
> >>>>  3: (BlueFS::_compact_log()+0xd5b) [0xb9b5ab]
> >>>>  4: (BlueFS::_maybe_compact_log()+0x2a0) [0xb9c040]
> >>>>  5: (BlueFS::sync_metadata()+0x20f) [0xb9d28f]
> >>>>  6: (BlueRocksDirectory::Fsync()+0xd) [0xbb2fad]
> >>>>  7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
> >>>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
> >>>> unsigned long, bool)+0x1456) [0xbfdb96]
> >>>>  8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
> >>>> rocksdb::WriteBatch*)+0x27) [0xbfe7a7]
> >>>>  9:
> >>>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::
> >>>> TransactionImpl>)+0x6b)
> >>>>
> >>>> [0xb3df2b]
> >>>>  10: (BlueStore::_kv_sync_thread()+0xedb) [0xaf935b]
> >>>>  11: (BlueStore::KVSyncThread::entry()+0xd) [0xb21e8d]
> >>>>  12: (()+0x7dc5) [0x7f0d185c4dc5]
> >>>>  13: (clone()+0x6d) [0x7f0d164bf28d]
> >>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >>>> needed to interpret this.
> >>>>
> >>>>
> >>>> On 07/12/2016 02:13 AM, Somnath Roy wrote:
> >>>>> Thanks Mark !
> >>>>> Yes, quite similar result I am also seeing for 4K RW. BTW, did you
> >>>>> get chance to try out the rocksdb tuning I posted earlier ? It may
> >>>>> reduce the stalls in your environment.
> >>>>>
> >>>>> Regards
> >>>>> Somnath
> >>>>>
> >>>>> -----Original Message-----
> >>>>> From: ceph-devel-owner@vger.kernel.org
> >>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> >>>>> Sent: Tuesday, July 12, 2016 12:03 AM
> >>>>> To: ceph-devel
> >>>>> Subject: bluestore onode diet and encoding overhead
> >>>>>
> >>>>> Hi All,
> >>>>>
> >>>>> With Igor's patch last week I was able to get some bluestore
> >>>>> performance runs in without segfaulting and started looking int
> >>>>> the results.
> >>>>> Somewhere along the line we really screwed up read performance,
> >>>>> but that's another topic.  Right now I want to focus on random writes.
> >>>>> Before we put the onode on a diet we were seeing massive amounts
> >>>>> of read traffic in RocksDB during compaction that caused write
> >>>>> stalls during 4K random writes.  Random write performance on fast
> >>>>> hardware like NVMe devices was often below filestore at anything
> >>>>> other than very large IO sizes.  This was largely due to the size
> >>>>> of the onode compounded with RocksDB's tendency toward read and
> >>>>> write amplification.
> >>>>>
> >>>>> The new test results look very promising.  We've dramatically
> >>>>> improved performance of random writes at most IO sizes, so that
> >>>>> they are now typically quite a bit higher than both filestore and
> >>>>> older bluestore code.  Unfortunately for very small IO sizes
> >>>>> performance hasn't improved much.  We are no longer seeing huge
> >>>>> amounts of RocksDB read traffic and fewer write stalls.  We are
> >>>>> however seeing huge memory usage (~9GB RSS per OSD) and very high
> >>>>> CPU usage.  I think this confirms some of the memory issues
> >>>>> somnath was continuing to see.  I don't think it's a leak exactly
> >>>>> based on how the OSDs were behaving, but we need to run through massif still to be sure.
> >>>>>
> >>>>> I ended up spending some time tonight with perf and digging
> >>>>> through the encode code.  I wrote up some notes with graphs and
> >>>>> code snippets and decided to put them up on the web.  Basically
> >>>>> some of the encoding changes we implemented last month to reduce
> >>>>> the onode size also appear to result in more buffer::list appends
> >>>>> and the associated overhead.
> >>>>> I've been trying to think through ways to improve the situation
> >>>>> and thought other people might have some ideas too.  Here's a link
> >>>>> to the short writeup:
> >>>>>
> >>>>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view?
> >>>>> usp=sharing
> >>>>>
> >>>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Mark
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>>>> in the body of a message to majordomo@vger.kernel.org More
> >>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
> >>>>> PLEASE NOTE: The information contained in this electronic mail
> >>>>> message is intended only for the use of the designated
> >>>>> recipient(s) named above. If the reader of this message is not the
> >>>>> intended recipient, you are hereby notified that you have received
> >>>>> this message in error and that any review, dissemination,
> >>>>> distribution, or copying of this message is strictly prohibited.
> >>>>> If you have received this communication in error, please notify
> >>>>> the sender by telephone or e-mail (as shown above) immediately and
> >>>>> destroy any and all copies of this message in your possession
> >>>>> (whether hard copies or electronically stored copies).
> >>>>> N     r  y   b X  ǧv ^ )޺{.n +   z ]z   {ay ʇڙ ,j
> >>>>>   f   h   z  w
>    j:+v   w j m         zZ+     ݢj"  !tml=
> >>>>>
> >>>>>
> >>>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe
> >>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> >>>
> >
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-1584280268-1468342595=:497--
