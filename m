From: Haodong Tang <tanghaodong25@gmail.com>
Subject: Re: Rados Bench Scaling question from today's Ceph Perf Call
Date: Fri, 7 Jul 2017 15:55:34 +0800
Message-ID: <CACYTDmiXtA2UryC-ncS32HGXzRV19y1pAC8vtz74F2vmXwLoUQ@mail.gmail.com>
References: <A29DFE4C-C497-4812-8F6C-4BD264BC2D58@teradata.com>
 <3a4ccee0-4dcc-6dd8-a161-1c235695f816@redhat.com> <5652413B-7DAD-4EF4-AF2D-0682A925FF18@teradata.com>
 <318341af-553b-d926-9bec-1635c6e33eca@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34595 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdGGHzf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jul 2017 03:55:35 -0400
Received: by mail-qt0-f169.google.com with SMTP id 32so21111709qtv.1
        for <ceph-devel@vger.kernel.org>; Fri, 07 Jul 2017 00:55:35 -0700 (PDT)
In-Reply-To: <318341af-553b-d926-9bec-1635c6e33eca@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "McFarland, Bruce" <Bruce.McFarland@teradata.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

There seems to be a rocksdb bug here when considering if it need
shared/secondary
device(https://github.com/facebook/rocksdb/blob/master/db/compaction_picker=
.cc#L1281).
As a result, rocksdb need more disk size than it theoretically need.
According to the size calculating methodology rocksdb currently using,
if we set the size of level 0 to 512(MB), then we need
512*max_bytes_for_level_multiplier^n(MB) for rocksdb. But the correct
size needed should be 512*max_bytes_for_level_multiplier^(n-1)(MB),
cause we always set the size of level 0 similar to level 1 to make the
compaction from level 0 to level 1 as fast as possible.

We also find the performance cliff in our environment with bluestore.
With larger db size, we can delay the performance cliff, because
shared device is always slower device, like hdd or sata ssd.

Thanks,
Haodong

On 7 July 2017 at 06:02, Mark Nelson <mnelson@redhat.com> wrote:
> That's the million dollar question, and sadly the answer as in most
> situations like this is that it depends.
>
> If my math is right in this case it looks like we are using somewhere
> vaguely around 16K per onode for 4K objects in the DB once you factor in
> rocksdb space-amp.  I don't know how variable that might be as data gets
> compacted and moved around between different levels in rocksdb.  Beyond
> that, things like enabling/disabling crc checksums, the min_alloc size, a=
nd
> the number of extents per object are going to affect the onode size too.
>
> We should probably do a more extensive analysis of all of the key/value
> pairs associated with the onode for different sized objects.  Things like
> the encoding method used (varint, etc) will have an impact on this too.
>
> Mark
>
>
> On 07/06/2017 03:29 PM, McFarland, Bruce wrote:
>>
>> Mark,
>> Thanks. Hopeing this response doesn=E2=80=99t get bounced by ceph-devel =
after
>> changing output to text from html. The question that immediately comes t=
o my
>> mind is =E2=80=9Cwhat size SSD partition would be necessary to avoid thi=
s write
>> cliff from ever occurring for a given sized HDD/OSD.=E2=80=9D Which of c=
ourse should
>> be workload dependent and up to the user to determine, but something to
>> consider when sizing Luminous clusters.
>>
>> Bruce
>>
>>
>> From: Mark Nelson <mnelson@redhat.com>
>> Date: Thursday, July 6, 2017 at 1:07 PM
>> To: "McFarland, Bruce" <Bruce.McFarland@Teradata.com>, ceph-devel
>> <ceph-devel@vger.kernel.org>
>> Subject: Re: Rados Bench Scaling question from today's Ceph Perf Call
>>
>> Hi Bruce,
>>
>> Sorry, my earlier reply wasn't to the list so reposting here along with
>> a bit more info.
>>
>> In that specific test, bluestore was on an OSD with the data on an HDD
>> and the metadata on an NVMe drive.  The cliff corresponded with reads
>> during writes to the HDD, which typically means we've filled up the
>> entire rocksdb metadata partition on the NVMe drive and bluefs is
>> rolling new SST files over to the spinning disk (with the associated
>> slowdown).
>>
>> That was about 98GB of metadata for 6M objects.  I suspect that if I run
>> another test with a larger metadata partition the cliff will get pushed
>> farther out.  It's also possible that if rocksdb compression were
>> enabled we might also be able to fit far more onodes in the database at
>> the expense of higher CPU usage.
>>
>> In this case larger onode cache doesn't seem to help much since these
>> are new objects and the getattr reads happening in
>> PGBackend::objects_get_attr don't return anything.  The trace from
>> dequeue_op on looks something like:
>>
>> + 86.30% PrimaryLogPG::do_op
>> | + 84.75% PrimaryLogPG::find_object_context
>> | | + 84.75% PrimaryLogPG::get_object_context
>> | |   + 84.70% PGBackend::objects_get_attr
>> | |   | + 84.70% BlueStore::getattr
>> | |   |   + 84.70% BlueStore::Collection::get_onode
>> | |   |     + 84.65% RocksDBStore::get
>> | |   |     | + 84.65% rocksdb::DB::Get
>> | |   |     |   + 84.65% rocksdb::DB::Get
>> | |   |     |     + 84.65% rocksdb::DBImpl::Get
>> | |   |     |       + 84.65% rocksdb::DBImpl::GetImpl
>> | |   |     |         + 84.65% rocksdb::Version::Get
>> | |   |     |           + 84.65% rocksdb::TableCache::Get
>> | |   |     |             + 84.65% rocksdb::BlockBasedTable::Get
>> | |   |     |               + 84.50%
>> rocksdb::BlockBasedTable::NewDataBlockIterator
>> | |   |     |               | + 84.50%
>> rocksdb::BlockBasedTable::NewDataBlockIterator
>> | |   |     |               |   + 84.50%
>> rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache
>> | |   |     |               |     + 84.45% rocksdb::(anonymous
>> namespace)::ReadBlockFromFile
>> | |   |     |               |     | + 84.45% rocksdb::ReadBlockContents
>> | |   |     |               |     |   + 84.45% ReadBlock
>> | |   |     |               |     |     + 84.45%
>> rocksdb::RandomAccessFileReader::Read
>> | |   |     |               |     |       + 84.45%
>> BlueRocksRandomAccessFile::Read
>> | |   |     |               |     |         + 84.45% read_random
>> | |   |     |               |     |           + 84.45%
>> BlueFS::_read_random
>> | |   |     |               |     |             + 84.45%
>> KernelDevice::read_random
>> | |   |     |               |     |               + 84.45%
>> KernelDevice::direct_read_unaligned
>> | |   |     |               |     |                 + 84.45% pread
>> | |   |     |               |     |                   + 84.45% pread64
>>
>>
>> Mark
>>
>> On 07/06/2017 01:24 PM, McFarland, Bruce wrote:
>> Mark,
>>
>> In today=E2=80=99s perf call you showed filestore and bluestore write cl=
iffs.
>> What, in your opinion, is the cause of the bluestore write cliff? Is
>> that the size of the bluefs and/or rocksdb cache? You mentioned it could
>> be solved by more HW which I took to mean bigger cache. Is that a
>> correct assumption?
>>
>> Thanks for the presentation.
>>
>> Bruce
>>
>>
>>
>>
>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
