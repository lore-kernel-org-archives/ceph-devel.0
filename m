From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Rados Bench Scaling question from today's Ceph Perf Call
Date: Thu, 6 Jul 2017 15:07:28 -0500
Message-ID: <3a4ccee0-4dcc-6dd8-a161-1c235695f816@redhat.com>
References: <A29DFE4C-C497-4812-8F6C-4BD264BC2D58@teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbdGFUH3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Jul 2017 16:07:29 -0400
In-Reply-To: <A29DFE4C-C497-4812-8F6C-4BD264BC2D58@teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "McFarland, Bruce" <Bruce.McFarland@Teradata.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Bruce,

Sorry, my earlier reply wasn't to the list so reposting here along with 
a bit more info.

In that specific test, bluestore was on an OSD with the data on an HDD 
and the metadata on an NVMe drive.  The cliff corresponded with reads 
during writes to the HDD, which typically means we've filled up the 
entire rocksdb metadata partition on the NVMe drive and bluefs is 
rolling new SST files over to the spinning disk (with the associated 
slowdown).

That was about 98GB of metadata for 6M objects.  I suspect that if I run 
another test with a larger metadata partition the cliff will get pushed 
farther out.  It's also possible that if rocksdb compression were 
enabled we might also be able to fit far more onodes in the database at 
the expense of higher CPU usage.

In this case larger onode cache doesn't seem to help much since these 
are new objects and the getattr reads happening in 
PGBackend::objects_get_attr don't return anything.  The trace from 
dequeue_op on looks something like:

+ 86.30% PrimaryLogPG::do_op
| + 84.75% PrimaryLogPG::find_object_context
| | + 84.75% PrimaryLogPG::get_object_context
| |   + 84.70% PGBackend::objects_get_attr
| |   | + 84.70% BlueStore::getattr
| |   |   + 84.70% BlueStore::Collection::get_onode
| |   |     + 84.65% RocksDBStore::get
| |   |     | + 84.65% rocksdb::DB::Get
| |   |     |   + 84.65% rocksdb::DB::Get
| |   |     |     + 84.65% rocksdb::DBImpl::Get
| |   |     |       + 84.65% rocksdb::DBImpl::GetImpl
| |   |     |         + 84.65% rocksdb::Version::Get
| |   |     |           + 84.65% rocksdb::TableCache::Get
| |   |     |             + 84.65% rocksdb::BlockBasedTable::Get
| |   |     |               + 84.50% 
rocksdb::BlockBasedTable::NewDataBlockIterator
| |   |     |               | + 84.50% 
rocksdb::BlockBasedTable::NewDataBlockIterator
| |   |     |               |   + 84.50% 
rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache
| |   |     |               |     + 84.45% rocksdb::(anonymous 
namespace)::ReadBlockFromFile
| |   |     |               |     | + 84.45% rocksdb::ReadBlockContents
| |   |     |               |     |   + 84.45% ReadBlock
| |   |     |               |     |     + 84.45% 
rocksdb::RandomAccessFileReader::Read
| |   |     |               |     |       + 84.45% 
BlueRocksRandomAccessFile::Read
| |   |     |               |     |         + 84.45% read_random
| |   |     |               |     |           + 84.45% BlueFS::_read_random
| |   |     |               |     |             + 84.45% 
KernelDevice::read_random
| |   |     |               |     |               + 84.45% 
KernelDevice::direct_read_unaligned
| |   |     |               |     |                 + 84.45% pread
| |   |     |               |     |                   + 84.45% pread64


Mark

On 07/06/2017 01:24 PM, McFarland, Bruce wrote:
> Mark,
>
> In today’s perf call you showed filestore and bluestore write cliffs.
> What, in your opinion, is the cause of the bluestore write cliff? Is
> that the size of the bluefs and/or rocksdb cache? You mentioned it could
> be solved by more HW which I took to mean bigger cache. Is that a
> correct assumption?
>
> Thanks for the presentation.
>
> Bruce
>
>
>
>
>
