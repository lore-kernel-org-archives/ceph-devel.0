From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 15:48:58 -0500
Message-ID: <c40e296d-5db7-d3d6-3988-c973876d3fb7@redhat.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com>
 <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
 <e2538609-7724-5e2f-b71a-8a32c45f4479@redhat.com>
 <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com>
 <fcd816f1-057d-7cc7-d989-4c8ee5ede2db@redhat.com>
 <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <34330d24-a43d-8c4b-aeaf-a7023e193aa1@mirantis.com>
 <BL2PR02MB2115DAD48209093E5449AA6DF4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <b6ea38cf-732d-2867-d0b4-f3d94885e242@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34482 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbcGLUtH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 16:49:07 -0400
In-Reply-To: <b6ea38cf-732d-2867-d0b4-f3d94885e242@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

Ok, good news and bad news.  I can confirm that stupid allocator is=20
letting me get past where I hit the allocation issues with Somnaths's=20
RockSDB tuning last time.  Memory usage is still crazy and continues to=
=20
grow most during random reads (It does release periodically, but never=20
enough to return to previous levels).

Random write performance is generally lower than the default tuning wit=
h=20
bitmap allocator.  Seq write performance is much better at small/medium=
=20
IO sizes though (it had regressed since jewel). Not sure if that's=20
Somnath's tuning or stupid allocator vs bitmap.  I'll to have to try a=20
stupid allocator run without Somnath's tuning to check.  Read/Randread=20
performance is still pretty terrible (actually even worse).

Mark

On 07/12/2016 10:46 AM, Mark Nelson wrote:
> I'm seeing the majority of memory growth happening during random read=
s
> still.  After looking through the massif output, it looks like it may=
 be
> associated with the bufferptr creation in KernelDevice::read here:
>
> https://github.com/ceph/ceph/blob/master/src/os/bluestore/KernelDevic=
e.cc#L477
>
>
> On 07/12/2016 10:36 AM, Somnath Roy wrote:
>> << And another observation - the issue isn't reproduced with stupid
>> allocator hence I suspect some bug in bitmap one
>> I was about to co-relate that , it seems a bug in Bitamp allocator t=
hen.
>> I need to check the memory growth is also related to Bitmap allocato=
r
>> related or not. I will do some digging.
>>
>> Thanks & Regards
>> Somnath
>> -----Original Message-----
>> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
>> Sent: Tuesday, July 12, 2016 8:32 AM
>> To: Somnath Roy; Mark Nelson; ceph-devel
>> Subject: Re: bluestore onode diet and encoding overhead
>>
>> Somnath,
>>
>> yeah,  you're right about db partition is getting out of space:
>>
>> -876> 2016-07-12 18:19:26.133795 7f8e6ddb7700 10 bluefs get_usage bd=
ev 0
>> free 0 (0 B) / 268431360 (255 MB), used 100%
>> -875> 2016-07-12 18:19:26.133796 7f8e6ddb7700 10 bluefs get_usage bd=
ev 1
>> free 193986560 (185 MB) / 268427264 (255 MB), used 27%
>> -874> 2016-07-12 18:19:26.133797 7f8e6ddb7700 10 bluefs get_usage bd=
ev 2
>> free 1073741824 (1024 MB) / 1074782208 (1024 MB), used 0%
>>
>> And I don't see much RAM consumption in this case.
>>
>> But the curious thing about my test case is that it shouldn't increa=
se
>> amount of metadata written as I'm doing writes within the first mega=
byte
>> only( see fio script I posted last week).
>>
>> Looks like somebody wastes DB space - usage at bdev 0 is constantly
>> growing while I'm running the test case...
>> And another observation - the issue isn't reproduced with stupid
>> allocator hence I suspect some bug in bitmap one...
>>
>> Thanks,
>> Igor
>>
>>
>> On 12.07.2016 18:14, Somnath Roy wrote:
>>> Mark,
>>> Recently, the default allocator is changed to Bitmap and I saw it i=
s
>>> returning < 0 return value only in the following case.
>>>
>>>    count =3D m_bit_alloc->alloc_blocks_res(nblks, &start_blk);
>>>    if (count =3D=3D 0) {
>>>      return -ENOSPC;
>>>    }
>>>
>>> So, it seems it may not be the memory but db partition is getting o=
ut
>>> of space (?). I never faced it so far as I was running with 100GB o=
f
>>> db partition may be.
>>> The amount of metadata write going on to the db even after onode di=
et
>>> is starting from ~1K and over time it is reaching > 4k or so (I
>>> checked for 4K RW). It is growing as extents are growing. So, 8 GB
>>> may not be enough.
>>> If this is true, next challenge is , how to automatically (or
>>> document) the size of rocksdb db partition based on the data
>>> partition size. For example, in the ZS case, we have calculated tha=
t
>>> we need ~9G db space per TB. We need to do similar calculation for
>>> rocksbd as well.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>>
>>> -----Original Message-----
>>> From: Mark Nelson [mailto:mnelson@redhat.com]
>>> Sent: Tuesday, July 12, 2016 6:03 AM
>>> To: Igor Fedotov; Somnath Roy; ceph-devel
>>> Subject: Re: bluestore onode diet and encoding overhead
>>>
>>> In this case I'm assigning per OSD:
>>>
>>> 1G Data (basically the top level OSD dir) 1G WAL 8G DB 140G Block
>>>
>>> Mark
>>>
>>> On 07/12/2016 07:57 AM, Igor Fedotov wrote:
>>>> Mark,
>>>>
>>>> you can find my post named 'yet another assertion in bluestore dur=
ing
>>>> random write' last week. It contains steps to reproduce in my case=
=2E
>>>>
>>>> Also I did some investigations (still incomplete though) with tuni=
ng
>>>> 'bluestore block db size' and 'bluestore block wal size'. Setting =
both
>>>> to 256M fixes the issue for me.
>>>>
>>>> But I'm still uncertain if that's a bug or just inappropriate
>>>> settings...
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Igor
>>>>
>>>>
>>>> On 12.07.2016 15:48, Mark Nelson wrote:
>>>>> Oh, that's good to know!  Have you tracked it down at all?  I not=
iced
>>>>> pretty extreme memory usage on the OSDs still, so that might be p=
art
>>>>> of it.  I'm doing a massif run now.
>>>>>
>>>>> Mark
>>>>>
>>>>> On 07/12/2016 07:40 AM, Igor Fedotov wrote:
>>>>>> That's similar to what I have while running my test case with
>>>>>> vstart...
>>>>>> Without Somnath's settings though..
>>>>>>
>>>>>>
>>>>>> On 12.07.2016 15:34, Mark Nelson wrote:
>>>>>>> Hi Somnath,
>>>>>>>
>>>>>>> I accidentally screwed up my first run with your settings but r=
eran
>>>>>>> last night.  With your tuning the OSDs are failing to allocate =
to
>>>>>>> bdev0 after about 30 minutes of testing:
>>>>>>>
>>>>>>> 2016-07-12 03:48:51.127781 7f0cef8b7700 -1 bluefs _allocate fai=
led
>>>>>>> to allocate 1048576 on bdev 0, free 0; fallback to bdev 1
>>>>>>>
>>>>>>> They are able to continue running, but ultimately this leads to=
 an
>>>>>>> assert later on.  I wonder if it's not compacting fast enough a=
nd
>>>>>>> ends up consuming the entire disk with stale metadata.
>>>>>>>
>>>>>>> 2016-07-12 04:31:02.631982 7f0cef8b7700 -1
>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: In
>>>>>>> function 'int BlueFS::_allocate(unsigned int, uint64_t,
>>>>>>> std::vector<bluefs_extent_t>*)' thread 7f0cef8b7700 time 2016-0=
7-12
>>>>>>> 04:31:02.627138
>>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: 1398:
>>>>>>> FAILED
>>>>>>> assert(0 =3D=3D "allocate failed... wtf")
>>>>>>>
>>>>>>>   ceph version v10.0.4-6936-gc7da2f7
>>>>>>> (c7da2f7c869694246650a9276a2b67aed9bf818f)
>>>>>>>   1: (ceph::__ceph_assert_fail(char const*, char const*, int, c=
har
>>>>>>> const*)+0x85) [0xd4cb75]
>>>>>>>   2: (BlueFS::_allocate(unsigned int, unsigned long,
>>>>>>> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t>
>>>>>>>> *)+0x760) [0xb98220]
>>>>>>>   3: (BlueFS::_compact_log()+0xd5b) [0xb9b5ab]
>>>>>>>   4: (BlueFS::_maybe_compact_log()+0x2a0) [0xb9c040]
>>>>>>>   5: (BlueFS::sync_metadata()+0x20f) [0xb9d28f]
>>>>>>>   6: (BlueRocksDirectory::Fsync()+0xd) [0xbb2fad]
>>>>>>>   7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>>>>>>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
>>>>>>> unsigned long, bool)+0x1456) [0xbfdb96]
>>>>>>>   8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>>>>>>> rocksdb::WriteBatch*)+0x27) [0xbfe7a7]
>>>>>>>   9:
>>>>>>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValue=
DB::
>>>>>>> TransactionImpl>)+0x6b)
>>>>>>>
>>>>>>> [0xb3df2b]
>>>>>>>   10: (BlueStore::_kv_sync_thread()+0xedb) [0xaf935b]
>>>>>>>   11: (BlueStore::KVSyncThread::entry()+0xd) [0xb21e8d]
>>>>>>>   12: (()+0x7dc5) [0x7f0d185c4dc5]
>>>>>>>   13: (clone()+0x6d) [0x7f0d164bf28d]
>>>>>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>=
` is
>>>>>>> needed to interpret this.
>>>>>>>
>>>>>>>
>>>>>>> On 07/12/2016 02:13 AM, Somnath Roy wrote:
>>>>>>>> Thanks Mark !
>>>>>>>> Yes, quite similar result I am also seeing for 4K RW. BTW, did=
 you
>>>>>>>> get chance to try out the rocksdb tuning I posted earlier ? It=
 may
>>>>>>>> reduce the stalls in your environment.
>>>>>>>>
>>>>>>>> Regards
>>>>>>>> Somnath
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Ne=
lson
>>>>>>>> Sent: Tuesday, July 12, 2016 12:03 AM
>>>>>>>> To: ceph-devel
>>>>>>>> Subject: bluestore onode diet and encoding overhead
>>>>>>>>
>>>>>>>> Hi All,
>>>>>>>>
>>>>>>>> With Igor's patch last week I was able to get some bluestore
>>>>>>>> performance runs in without segfaulting and started looking in=
t
>>>>>>>> the results.
>>>>>>>> Somewhere along the line we really screwed up read performance=
,
>>>>>>>> but that's another topic.  Right now I want to focus on random
>>>>>>>> writes.
>>>>>>>> Before we put the onode on a diet we were seeing massive amoun=
ts
>>>>>>>> of read traffic in RocksDB during compaction that caused write
>>>>>>>> stalls during 4K random writes.  Random write performance on f=
ast
>>>>>>>> hardware like NVMe devices was often below filestore at anythi=
ng
>>>>>>>> other than very large IO sizes.  This was largely due to the s=
ize
>>>>>>>> of the onode compounded with RocksDB's tendency toward read an=
d
>>>>>>>> write amplification.
>>>>>>>>
>>>>>>>> The new test results look very promising.  We've dramatically
>>>>>>>> improved performance of random writes at most IO sizes, so tha=
t
>>>>>>>> they are now typically quite a bit higher than both filestore =
and
>>>>>>>> older bluestore code.  Unfortunately for very small IO sizes
>>>>>>>> performance hasn't improved much.  We are no longer seeing hug=
e
>>>>>>>> amounts of RocksDB read traffic and fewer write stalls.  We ar=
e
>>>>>>>> however seeing huge memory usage (~9GB RSS per OSD) and very h=
igh
>>>>>>>> CPU usage.  I think this confirms some of the memory issues
>>>>>>>> somnath was continuing to see.  I don't think it's a leak exac=
tly
>>>>>>>> based on how the OSDs were behaving, but we need to run throug=
h
>>>>>>>> massif still to be sure.
>>>>>>>>
>>>>>>>> I ended up spending some time tonight with perf and digging
>>>>>>>> through the encode code.  I wrote up some notes with graphs an=
d
>>>>>>>> code snippets and decided to put them up on the web.  Basicall=
y
>>>>>>>> some of the encoding changes we implemented last month to redu=
ce
>>>>>>>> the onode size also appear to result in more buffer::list appe=
nds
>>>>>>>> and the associated overhead.
>>>>>>>> I've been trying to think through ways to improve the situatio=
n
>>>>>>>> and thought other people might have some ideas too.  Here's a =
link
>>>>>>>> to the short writeup:
>>>>>>>>
>>>>>>>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/v=
iew?
>>>>>>>> usp=3Dsharing
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Mark
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> ceph-devel"
>>>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>>> PLEASE NOTE: The information contained in this electronic mail
>>>>>>>> message is intended only for the use of the designated
>>>>>>>> recipient(s) named above. If the reader of this message is not=
 the
>>>>>>>> intended recipient, you are hereby notified that you have rece=
ived
>>>>>>>> this message in error and that any review, dissemination,
>>>>>>>> distribution, or copying of this message is strictly prohibite=
d.
>>>>>>>> If you have received this communication in error, please notif=
y
>>>>>>>> the sender by telephone or e-mail (as shown above) immediately=
 and
>>>>>>>> destroy any and all copies of this message in your possession
>>>>>>>> (whether hard copies or electronically stored copies).
>>>>>>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=
=DA=99 ,j
>>>>>>>>    f   h   z =1E w
>>>     j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>>>>>>
>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.o=
rg
>>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml
>>> PLEASE NOTE: The information contained in this electronic mail
>>> message is intended only for the use of the designated recipient(s)
>>> named above. If the reader of this message is not the intended
>>> recipient, you are hereby notified that you have received this
>>> message in error and that any review, dissemination, distribution, =
or
>>> copying of this message is strictly prohibited. If you have receive=
d
>>> this communication in error, please notify the sender by telephone =
or
>>> e-mail (as shown above) immediately and destroy any and all copies =
of
>>> this message in your possession (whether hard copies or
>>> electronically stored copies).
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
