From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 08:02:55 -0500
Message-ID: <fcd816f1-057d-7cc7-d989-4c8ee5ede2db@redhat.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com>
 <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
 <e2538609-7724-5e2f-b71a-8a32c45f4479@redhat.com>
 <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41690 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933381AbcGLNC6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 09:02:58 -0400
In-Reply-To: <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

In this case I'm assigning per OSD:

1G Data (basically the top level OSD dir)
1G WAL
8G DB
140G Block

Mark

On 07/12/2016 07:57 AM, Igor Fedotov wrote:
> Mark,
>
> you can find my post named 'yet another assertion in bluestore during
> random write' last week. It contains steps to reproduce in my case.
>
> Also I did some investigations (still incomplete though) with tuning
> 'bluestore block db size' and 'bluestore block wal size'. Setting bot=
h
> to 256M fixes the issue for me.
>
> But I'm still uncertain if that's a bug or just inappropriate setting=
s...
>
>
> Thanks,
>
> Igor
>
>
> On 12.07.2016 15:48, Mark Nelson wrote:
>> Oh, that's good to know!  Have you tracked it down at all?  I notice=
d
>> pretty extreme memory usage on the OSDs still, so that might be part
>> of it.  I'm doing a massif run now.
>>
>> Mark
>>
>> On 07/12/2016 07:40 AM, Igor Fedotov wrote:
>>> That's similar to what I have while running my test case with vstar=
t...
>>> Without Somnath's settings though..
>>>
>>>
>>> On 12.07.2016 15:34, Mark Nelson wrote:
>>>> Hi Somnath,
>>>>
>>>> I accidentally screwed up my first run with your settings but rera=
n
>>>> last night.  With your tuning the OSDs are failing to allocate to
>>>> bdev0 after about 30 minutes of testing:
>>>>
>>>> 2016-07-12 03:48:51.127781 7f0cef8b7700 -1 bluefs _allocate failed=
 to
>>>> allocate 1048576 on bdev 0, free 0; fallback to bdev 1
>>>>
>>>> They are able to continue running, but ultimately this leads to an
>>>> assert later on.  I wonder if it's not compacting fast enough and =
ends
>>>> up consuming the entire disk with stale metadata.
>>>>
>>>> 2016-07-12 04:31:02.631982 7f0cef8b7700 -1
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: In funct=
ion
>>>> 'int BlueFS::_allocate(unsigned int, uint64_t,
>>>> std::vector<bluefs_extent_t>*)' thread 7f0cef8b7700 time 2016-07-1=
2
>>>> 04:31:02.627138
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: 1398: FA=
ILED
>>>> assert(0 =3D=3D "allocate failed... wtf")
>>>>
>>>>  ceph version v10.0.4-6936-gc7da2f7
>>>> (c7da2f7c869694246650a9276a2b67aed9bf818f)
>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>> const*)+0x85) [0xd4cb75]
>>>>  2: (BlueFS::_allocate(unsigned int, unsigned long,
>>>> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t>
>>>> >*)+0x760) [0xb98220]
>>>>  3: (BlueFS::_compact_log()+0xd5b) [0xb9b5ab]
>>>>  4: (BlueFS::_maybe_compact_log()+0x2a0) [0xb9c040]
>>>>  5: (BlueFS::sync_metadata()+0x20f) [0xb9d28f]
>>>>  6: (BlueRocksDirectory::Fsync()+0xd) [0xbb2fad]
>>>>  7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>>>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
>>>> unsigned long, bool)+0x1456) [0xbfdb96]
>>>>  8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>>>> rocksdb::WriteBatch*)+0x27) [0xbfe7a7]
>>>>  9:
>>>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB:=
:TransactionImpl>)+0x6b)
>>>>
>>>> [0xb3df2b]
>>>>  10: (BlueStore::_kv_sync_thread()+0xedb) [0xaf935b]
>>>>  11: (BlueStore::KVSyncThread::entry()+0xd) [0xb21e8d]
>>>>  12: (()+0x7dc5) [0x7f0d185c4dc5]
>>>>  13: (clone()+0x6d) [0x7f0d164bf28d]
>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>> needed to interpret this.
>>>>
>>>>
>>>> On 07/12/2016 02:13 AM, Somnath Roy wrote:
>>>>> Thanks Mark !
>>>>> Yes, quite similar result I am also seeing for 4K RW. BTW, did yo=
u
>>>>> get chance to try out the rocksdb tuning I posted earlier ? It ma=
y
>>>>> reduce the stalls in your environment.
>>>>>
>>>>> Regards
>>>>> Somnath
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelso=
n
>>>>> Sent: Tuesday, July 12, 2016 12:03 AM
>>>>> To: ceph-devel
>>>>> Subject: bluestore onode diet and encoding overhead
>>>>>
>>>>> Hi All,
>>>>>
>>>>> With Igor's patch last week I was able to get some bluestore
>>>>> performance runs in without segfaulting and started looking int t=
he
>>>>> results.
>>>>> Somewhere along the line we really screwed up read performance, b=
ut
>>>>> that's another topic.  Right now I want to focus on random writes=
=2E
>>>>> Before we put the onode on a diet we were seeing massive amounts =
of
>>>>> read traffic in RocksDB during compaction that caused write stall=
s
>>>>> during 4K random writes.  Random write performance on fast hardwa=
re
>>>>> like NVMe devices was often below filestore at anything other tha=
n
>>>>> very large IO sizes.  This was largely due to the size of the ono=
de
>>>>> compounded with RocksDB's tendency toward read and write
>>>>> amplification.
>>>>>
>>>>> The new test results look very promising.  We've dramatically
>>>>> improved performance of random writes at most IO sizes, so that t=
hey
>>>>> are now typically quite a bit higher than both filestore and olde=
r
>>>>> bluestore code.  Unfortunately for very small IO sizes performanc=
e
>>>>> hasn't improved much.  We are no longer seeing huge amounts of
>>>>> RocksDB read traffic and fewer write stalls.  We are however seei=
ng
>>>>> huge memory usage (~9GB RSS per OSD) and very high CPU usage.  I
>>>>> think this confirms some of the memory issues somnath was continu=
ing
>>>>> to see.  I don't think it's a leak exactly based on how the OSDs =
were
>>>>> behaving, but we need to run through massif still to be sure.
>>>>>
>>>>> I ended up spending some time tonight with perf and digging throu=
gh
>>>>> the encode code.  I wrote up some notes with graphs and code snip=
pets
>>>>> and decided to put them up on the web.  Basically some of the
>>>>> encoding changes we implemented last month to reduce the onode si=
ze
>>>>> also appear to result in more buffer::list appends and the associ=
ated
>>>>> overhead.
>>>>> I've been trying to think through ways to improve the situation a=
nd
>>>>> thought other people might have some ideas too.  Here's a link to=
 the
>>>>> short writeup:
>>>>>
>>>>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view=
?usp=3Dsharing
>>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Mark
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>>>>> in the body of a message to majordomo@vger.kernel.org More majord=
omo
>>>>> info at http://vger.kernel.org/majordomo-info.html
>>>>> PLEASE NOTE: The information contained in this electronic mail
>>>>> message is intended only for the use of the designated recipient(=
s)
>>>>> named above. If the reader of this message is not the intended
>>>>> recipient, you are hereby notified that you have received this
>>>>> message in error and that any review, dissemination, distribution=
, or
>>>>> copying of this message is strictly prohibited. If you have recei=
ved
>>>>> this communication in error, please notify the sender by telephon=
e or
>>>>> e-mail (as shown above) immediately and destroy any and all copie=
s of
>>>>> this message in your possession (whether hard copies or
>>>>> electronically stored copies).
>>>>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BD=
y=EF=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD=
^=EF=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=
=BF=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=
=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=
=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=
=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>>>>>
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
