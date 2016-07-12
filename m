From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 15:40:02 +0300
Message-ID: <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33853 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933170AbcGLMkF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 08:40:05 -0400
Received: by mail-lf0-f53.google.com with SMTP id h129so12205359lfh.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 05:40:05 -0700 (PDT)
In-Reply-To: <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

That's similar to what I have while running my test case with vstart...=
=20
Without Somnath's settings though..


On 12.07.2016 15:34, Mark Nelson wrote:
> Hi Somnath,
>
> I accidentally screwed up my first run with your settings but reran=20
> last night.  With your tuning the OSDs are failing to allocate to=20
> bdev0 after about 30 minutes of testing:
>
> 2016-07-12 03:48:51.127781 7f0cef8b7700 -1 bluefs _allocate failed to=
=20
> allocate 1048576 on bdev 0, free 0; fallback to bdev 1
>
> They are able to continue running, but ultimately this leads to an=20
> assert later on.  I wonder if it's not compacting fast enough and end=
s=20
> up consuming the entire disk with stale metadata.
>
> 2016-07-12 04:31:02.631982 7f0cef8b7700 -1=20
> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: In function=
=20
> 'int BlueFS::_allocate(unsigned int, uint64_t,=20
> std::vector<bluefs_extent_t>*)' thread 7f0cef8b7700 time 2016-07-12=20
> 04:31:02.627138
> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: 1398: FAILE=
D=20
> assert(0 =3D=3D "allocate failed... wtf")
>
>  ceph version v10.0.4-6936-gc7da2f7=20
> (c7da2f7c869694246650a9276a2b67aed9bf818f)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char=20
> const*)+0x85) [0xd4cb75]
>  2: (BlueFS::_allocate(unsigned int, unsigned long,=20
> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t>=20
> >*)+0x760) [0xb98220]
>  3: (BlueFS::_compact_log()+0xd5b) [0xb9b5ab]
>  4: (BlueFS::_maybe_compact_log()+0x2a0) [0xb9c040]
>  5: (BlueFS::sync_metadata()+0x20f) [0xb9d28f]
>  6: (BlueRocksDirectory::Fsync()+0xd) [0xbb2fad]
>  7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,=20
> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,=20
> unsigned long, bool)+0x1456) [0xbfdb96]
>  8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,=20
> rocksdb::WriteBatch*)+0x27) [0xbfe7a7]
>  9:=20
> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::Tr=
ansactionImpl>)+0x6b)=20
> [0xb3df2b]
>  10: (BlueStore::_kv_sync_thread()+0xedb) [0xaf935b]
>  11: (BlueStore::KVSyncThread::entry()+0xd) [0xb21e8d]
>  12: (()+0x7dc5) [0x7f0d185c4dc5]
>  13: (clone()+0x6d) [0x7f0d164bf28d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
> needed to interpret this.
>
>
> On 07/12/2016 02:13 AM, Somnath Roy wrote:
>> Thanks Mark !
>> Yes, quite similar result I am also seeing for 4K RW. BTW, did you=20
>> get chance to try out the rocksdb tuning I posted earlier ? It may=20
>> reduce the stalls in your environment.
>>
>> Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Tuesday, July 12, 2016 12:03 AM
>> To: ceph-devel
>> Subject: bluestore onode diet and encoding overhead
>>
>> Hi All,
>>
>> With Igor's patch last week I was able to get some bluestore=20
>> performance runs in without segfaulting and started looking int the=20
>> results.
>> Somewhere along the line we really screwed up read performance, but=20
>> that's another topic.  Right now I want to focus on random writes.
>> Before we put the onode on a diet we were seeing massive amounts of=20
>> read traffic in RocksDB during compaction that caused write stalls=20
>> during 4K random writes.  Random write performance on fast hardware=20
>> like NVMe devices was often below filestore at anything other than=20
>> very large IO sizes.  This was largely due to the size of the onode=20
>> compounded with RocksDB's tendency toward read and write amplificati=
on.
>>
>> The new test results look very promising.  We've dramatically=20
>> improved performance of random writes at most IO sizes, so that they=
=20
>> are now typically quite a bit higher than both filestore and older=20
>> bluestore code.  Unfortunately for very small IO sizes performance=20
>> hasn't improved much.  We are no longer seeing huge amounts of=20
>> RocksDB read traffic and fewer write stalls.  We are however seeing=20
>> huge memory usage (~9GB RSS per OSD) and very high CPU usage.  I=20
>> think this confirms some of the memory issues somnath was continuing=
=20
>> to see.  I don't think it's a leak exactly based on how the OSDs wer=
e=20
>> behaving, but we need to run through massif still to be sure.
>>
>> I ended up spending some time tonight with perf and digging through=20
>> the encode code.  I wrote up some notes with graphs and code snippet=
s=20
>> and decided to put them up on the web.  Basically some of the=20
>> encoding changes we implemented last month to reduce the onode size=20
>> also appear to result in more buffer::list appends and the associate=
d=20
>> overhead.
>> I've been trying to think through ways to improve the situation and=20
>> thought other people might have some ideas too.  Here's a link to th=
e=20
>> short writeup:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view?us=
p=3Dsharing=20
>>
>>
>> Thanks,
>> Mark
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail=20
>> message is intended only for the use of the designated recipient(s)=20
>> named above. If the reader of this message is not the intended=20
>> recipient, you are hereby notified that you have received this=20
>> message in error and that any review, dissemination, distribution, o=
r=20
>> copying of this message is strictly prohibited. If you have received=
=20
>> this communication in error, please notify the sender by telephone o=
r=20
>> e-mail (as shown above) immediately and destroy any and all copies o=
f=20
>> this message in your possession (whether hard copies or=20
>> electronically stored copies).
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D=20
>>
>>
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
