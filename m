From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: yet another assertion in bluestore during random write
Date: Fri, 8 Jul 2016 16:14:44 +0300
Message-ID: <87849086-eb7c-85b4-8c4a-bfdc830d8026@mirantis.com>
References: <c8078e34-836e-6383-7540-d5fea731efb2@mirantis.com>
 <BLUPR0201MB19084645A0FC662D8AC72A97E23C0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35774 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbcGHNOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2016 09:14:47 -0400
Received: by mail-lf0-f52.google.com with SMTP id l188so28431941lfe.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 06:14:46 -0700 (PDT)
In-Reply-To: <BLUPR0201MB19084645A0FC662D8AC72A97E23C0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Varada,

I'm running vstart.sh hence default block db and block wal sizes: 64 M & 
128 M respectively.

Could you please elaborate why they go out of space - what information 
is being accumulated there in my case? Actually I know a little about 
this mechanics...

Thanks,

Igor


On 08.07.2016 14:29, Varada Kari wrote:
> Igor,
>
> How much is your db partition and wal partition size?
> Seems you are out of space on db partition, block.db, if we go out of
> space on block.db, we try to allocate block.wal.
> Seems both are failing in your case and log compaction gone out of space
> for next 4MB chunk.
> we shall discuss in the sync up today.
>
> Varada
>
> On Friday 08 July 2016 04:09 PM, Igor Fedotov wrote:
>> Hi All,
>>
>>
>> as I mentioned during yesterday's bluestore syncup I observed another
>> issue with bluestore during random write.
>>
>> Here is the backtrace:
>>
>>        0> 2016-07-07 17:05:10.520543 7ff393dbf700 -1
>> os/bluestore/BlueFS.cc: In function 'int BlueFS::_allocate(unsigned int,
>> uint64_t, std::vector<bluefs_extent_t>*)' thread 7ff393dbf700 time
>> 2016-07-07 17:05:10.507412
>> os/bluestore/BlueFS.cc: 1398: FAILED assert(0 == "allocate failed... wtf")
>>
>>    ceph version 11.0.0-289-g173e5a6
>> (173e5a6d85f624a714c0029db6f828cb1968cf3d)
>>    1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x82) [0x7ff3a9833452]
>>    2: (BlueFS::_allocate(unsigned int, unsigned long,
>> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t> >*)+0x760)
>> [0x7ff3a95186e0]
>>    3: (BlueFS::_compact_log()+0xd9b) [0x7ff3a951ba8b]
>>    4: (BlueFS::_maybe_compact_log()+0x2a0) [0x7ff3a951c510]
>>    5: (BlueFS::sync_metadata()+0x20f) [0x7ff3a951d77f]
>>    6: (BlueRocksDirectory::Fsync()+0xd) [0x7ff3a95300dd]
>>    7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned
>> long, bool)+0x14e1) [0x7ff3a95ea281]
>>    8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>> rocksdb::WriteBatch*)+0x1b) [0x7ff3a95eae1b]
>>    9:
>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x6b)
>> [0x7ff3a95b7d7b]
>>    10: (BlueStore::_kv_sync_thread()+0x167b) [0x7ff3a942aefb]
>>    11: (BlueStore::KVSyncThread::entry()+0xd) [0x7ff3a944af5d]
>>    12: (()+0x80a5) [0x7ff3a7a170a5]
>>    13: (clone()+0x6d) [0x7ff3a58f9cfd]
>>    NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> Looks like bitmap allocator returns a failure at some moment.
>>
>> My environment:
>>
>> * Ceph cluster run via vstart.sh.
>>
>> *rbd image created via:
>>
>> ./rbd create --size 1024 -c ceph.conf --image-feature layering fio_test
>> ./rbd map -c ceph.conf fio_test
>>
>> * fio script is as follows:
>>
>> [global]
>>
>> [rbd_iodepth32]
>> ioengine=libaio
>> iodepth=32
>> filename=/dev/rbd12
>> size=1m
>> io_size=8192m
>> bs=128k
>> rw=randwrite
>> numjobs=3
>>
>>
>> Bug is easily reproducible with the script when bluestore allocator is
>> set to bitmap (by default). I was unable to reproduce the issue with
>> stupid allocator hence I suppose it's rather bitmap allocator internal
>> issue. Maybe some leaks as it occurs rather by the end of the FIO script?
>>
>>    One should apply bluestore patch I posted yesterday prior to reproduce
>> this issue as one can hit another bug otherwise.
>>
>>
>> Thanks,
>>
>> Igor
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

