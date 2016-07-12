From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 18:31:32 +0300
Message-ID: <34330d24-a43d-8c4b-aeaf-a7023e193aa1@mirantis.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com>
 <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
 <e2538609-7724-5e2f-b71a-8a32c45f4479@redhat.com>
 <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com>
 <fcd816f1-057d-7cc7-d989-4c8ee5ede2db@redhat.com>
 <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33863 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbcGLPbf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 11:31:35 -0400
Received: by mail-lf0-f44.google.com with SMTP id h129so17107766lfh.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 08:31:34 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Somnath,

yeah,  you're right about db partition is getting out of space:

-876> 2016-07-12 18:19:26.133795 7f8e6ddb7700 10 bluefs get_usage bdev =
0=20
free 0 (0 B) / 268431360 (255 MB), used 100%
-875> 2016-07-12 18:19:26.133796 7f8e6ddb7700 10 bluefs get_usage bdev =
1=20
free 193986560 (185 MB) / 268427264 (255 MB), used 27%
-874> 2016-07-12 18:19:26.133797 7f8e6ddb7700 10 bluefs get_usage bdev =
2=20
free 1073741824 (1024 MB) / 1074782208 (1024 MB), used 0%

And I don't see much RAM consumption in this case.

But the curious thing about my test case is that it shouldn't increase=20
amount of metadata written as I'm doing writes within the first megabyt=
e=20
only( see fio script I posted last week).

Looks like somebody wastes DB space - usage at bdev 0 is constantly=20
growing while I'm running the test case...
And another observation - the issue isn't reproduced with stupid=20
allocator hence I suspect some bug in bitmap one...

Thanks,
Igor


On 12.07.2016 18:14, Somnath Roy wrote:
> Mark,
> Recently, the default allocator is changed to Bitmap and I saw it is =
returning < 0 return value only in the following case.
>
>    count =3D m_bit_alloc->alloc_blocks_res(nblks, &start_blk);
>    if (count =3D=3D 0) {
>      return -ENOSPC;
>    }
>
> So, it seems it may not be the memory but db partition is getting out=
 of space (?). I never faced it so far as I was running with 100GB of d=
b partition may be.
> The amount of metadata write going on to the db even after onode diet=
 is starting from ~1K and over time it is reaching > 4k or so (I checke=
d for 4K RW). It is growing as extents are growing. So, 8 GB may not be=
 enough.
> If this is true, next challenge is , how to automatically (or documen=
t) the size of rocksdb db partition based on the data partition size. F=
or example, in the ZS case, we have calculated that we need ~9G db spac=
e per TB. We need to do similar calculation for rocksbd as well.
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
>> Mark,
>>
>> you can find my post named 'yet another assertion in bluestore durin=
g
>> random write' last week. It contains steps to reproduce in my case.
>>
>> Also I did some investigations (still incomplete though) with tuning
>> 'bluestore block db size' and 'bluestore block wal size'. Setting bo=
th
>> to 256M fixes the issue for me.
>>
>> But I'm still uncertain if that's a bug or just inappropriate settin=
gs...
>>
>>
>> Thanks,
>>
>> Igor
>>
>>
>> On 12.07.2016 15:48, Mark Nelson wrote:
>>> Oh, that's good to know!  Have you tracked it down at all?  I notic=
ed
>>> pretty extreme memory usage on the OSDs still, so that might be par=
t
>>> of it.  I'm doing a massif run now.
>>>
>>> Mark
>>>
>>> On 07/12/2016 07:40 AM, Igor Fedotov wrote:
>>>> That's similar to what I have while running my test case with vsta=
rt...
>>>> Without Somnath's settings though..
>>>>
>>>>
>>>> On 12.07.2016 15:34, Mark Nelson wrote:
>>>>> Hi Somnath,
>>>>>
>>>>> I accidentally screwed up my first run with your settings but rer=
an
>>>>> last night.  With your tuning the OSDs are failing to allocate to
>>>>> bdev0 after about 30 minutes of testing:
>>>>>
>>>>> 2016-07-12 03:48:51.127781 7f0cef8b7700 -1 bluefs _allocate faile=
d
>>>>> to allocate 1048576 on bdev 0, free 0; fallback to bdev 1
>>>>>
>>>>> They are able to continue running, but ultimately this leads to a=
n
>>>>> assert later on.  I wonder if it's not compacting fast enough and
>>>>> ends up consuming the entire disk with stale metadata.
>>>>>
>>>>> 2016-07-12 04:31:02.631982 7f0cef8b7700 -1
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: In
>>>>> function 'int BlueFS::_allocate(unsigned int, uint64_t,
>>>>> std::vector<bluefs_extent_t>*)' thread 7f0cef8b7700 time 2016-07-=
12
>>>>> 04:31:02.627138
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: 1398:
>>>>> FAILED
>>>>> assert(0 =3D=3D "allocate failed... wtf")
>>>>>
>>>>>   ceph version v10.0.4-6936-gc7da2f7
>>>>> (c7da2f7c869694246650a9276a2b67aed9bf818f)
>>>>>   1: (ceph::__ceph_assert_fail(char const*, char const*, int, cha=
r
>>>>> const*)+0x85) [0xd4cb75]
>>>>>   2: (BlueFS::_allocate(unsigned int, unsigned long,
>>>>> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t>
>>>>>> *)+0x760) [0xb98220]
>>>>>   3: (BlueFS::_compact_log()+0xd5b) [0xb9b5ab]
>>>>>   4: (BlueFS::_maybe_compact_log()+0x2a0) [0xb9c040]
>>>>>   5: (BlueFS::sync_metadata()+0x20f) [0xb9d28f]
>>>>>   6: (BlueRocksDirectory::Fsync()+0xd) [0xbb2fad]
>>>>>   7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>>>>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
>>>>> unsigned long, bool)+0x1456) [0xbfdb96]
>>>>>   8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>>>>> rocksdb::WriteBatch*)+0x27) [0xbfe7a7]
>>>>>   9:
>>>>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB=
::
>>>>> TransactionImpl>)+0x6b)
>>>>>
>>>>> [0xb3df2b]
>>>>>   10: (BlueStore::_kv_sync_thread()+0xedb) [0xaf935b]
>>>>>   11: (BlueStore::KVSyncThread::entry()+0xd) [0xb21e8d]
>>>>>   12: (()+0x7dc5) [0x7f0d185c4dc5]
>>>>>   13: (clone()+0x6d) [0x7f0d164bf28d]
>>>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` =
is
>>>>> needed to interpret this.
>>>>>
>>>>>
>>>>> On 07/12/2016 02:13 AM, Somnath Roy wrote:
>>>>>> Thanks Mark !
>>>>>> Yes, quite similar result I am also seeing for 4K RW. BTW, did y=
ou
>>>>>> get chance to try out the rocksdb tuning I posted earlier ? It m=
ay
>>>>>> reduce the stalls in your environment.
>>>>>>
>>>>>> Regards
>>>>>> Somnath
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nels=
on
>>>>>> Sent: Tuesday, July 12, 2016 12:03 AM
>>>>>> To: ceph-devel
>>>>>> Subject: bluestore onode diet and encoding overhead
>>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> With Igor's patch last week I was able to get some bluestore
>>>>>> performance runs in without segfaulting and started looking int
>>>>>> the results.
>>>>>> Somewhere along the line we really screwed up read performance,
>>>>>> but that's another topic.  Right now I want to focus on random w=
rites.
>>>>>> Before we put the onode on a diet we were seeing massive amounts
>>>>>> of read traffic in RocksDB during compaction that caused write
>>>>>> stalls during 4K random writes.  Random write performance on fas=
t
>>>>>> hardware like NVMe devices was often below filestore at anything
>>>>>> other than very large IO sizes.  This was largely due to the siz=
e
>>>>>> of the onode compounded with RocksDB's tendency toward read and
>>>>>> write amplification.
>>>>>>
>>>>>> The new test results look very promising.  We've dramatically
>>>>>> improved performance of random writes at most IO sizes, so that
>>>>>> they are now typically quite a bit higher than both filestore an=
d
>>>>>> older bluestore code.  Unfortunately for very small IO sizes
>>>>>> performance hasn't improved much.  We are no longer seeing huge
>>>>>> amounts of RocksDB read traffic and fewer write stalls.  We are
>>>>>> however seeing huge memory usage (~9GB RSS per OSD) and very hig=
h
>>>>>> CPU usage.  I think this confirms some of the memory issues
>>>>>> somnath was continuing to see.  I don't think it's a leak exactl=
y
>>>>>> based on how the OSDs were behaving, but we need to run through =
massif still to be sure.
>>>>>>
>>>>>> I ended up spending some time tonight with perf and digging
>>>>>> through the encode code.  I wrote up some notes with graphs and
>>>>>> code snippets and decided to put them up on the web.  Basically
>>>>>> some of the encoding changes we implemented last month to reduce
>>>>>> the onode size also appear to result in more buffer::list append=
s
>>>>>> and the associated overhead.
>>>>>> I've been trying to think through ways to improve the situation
>>>>>> and thought other people might have some ideas too.  Here's a li=
nk
>>>>>> to the short writeup:
>>>>>>
>>>>>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/vie=
w?
>>>>>> usp=3Dsharing
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Mark
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>> PLEASE NOTE: The information contained in this electronic mail
>>>>>> message is intended only for the use of the designated
>>>>>> recipient(s) named above. If the reader of this message is not t=
he
>>>>>> intended recipient, you are hereby notified that you have receiv=
ed
>>>>>> this message in error and that any review, dissemination,
>>>>>> distribution, or copying of this message is strictly prohibited.
>>>>>> If you have received this communication in error, please notify
>>>>>> the sender by telephone or e-mail (as shown above) immediately a=
nd
>>>>>> destroy any and all copies of this message in your possession
>>>>>> (whether hard copies or electronically stored copies).
>>>>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=
=99 ,j
>>>>>>    f   h   z =1E w
>     j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>>>>
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
