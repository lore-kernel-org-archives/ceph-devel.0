From: Mark Nelson <mnelson@redhat.com>
Subject: Re: NewStore performance analysis
Date: Mon, 20 Apr 2015 10:55:22 -0500
Message-ID: <5535216A.10509@redhat.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC021D081C@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504200826500.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbbDTPzd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Apr 2015 11:55:33 -0400
In-Reply-To: <alpine.DEB.2.00.1504200826500.18547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "Duan, Jiangang" <jiangang.duan@intel.com>, "Zhang, Jian" <jian.zhang@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/20/2015 10:39 AM, Sage Weil wrote:
> On Mon, 20 Apr 2015, Chen, Xiaoxi wrote:
>> [Resend in plain text]
>>
>> Hi,
>>         I have played some tunable on RocksDB these days, try to optimize the performance of Newstore.   From the data now ,seems the WA of  RocksDB is not the issue that blocking the performance, and also seems not the fragment part(aio/dio, etc). The issue might be how much OPS rocksdb can offer under 1-write-per-sync workload. I cannot find the number online so I will do it by myself,  if that number is low, maybe we need holding multiple RocksDB instance in one OSD and do some sharding .
>>
>> The WAL log of Rocksdb, RocksDB data file and Newstore directory were backed by 3 separate SSDs.
>> /dev/sdc1      156172796    32928 156139868   1% /root/ceph-0-db
>> /dev/sdd1      195264572    32928 195231644   1% /root/ceph-0-db-wal
>> /dev/sdb1      156172796 10589552 145583244   7% /var/lib/ceph/osd/ceph-0
>>
>> Some interesting finds here:
>>
>> 1.  Avg_reqsz in SDB(newstore FS part) is 2KB, that is half of the request block size(4KB),  IOPS in iostat(2K) is ~ 2X of the number reported by FIO. BW matched
>>
>> Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
>> sda               0.00     0.00    0.00   58.33     0.00    28.98  1017.51     6.33  108.55    0.00  108.55   1.30   7.60
>> sdb               0.00     0.00    0.00 2038.00     0.00     3.98     4.00     0.13    0.07    0.00    0.07   0.07  13.33
>> sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
>> sdd               0.00   747.67    0.00 2099.67     0.00    11.28    11.00     0.76    0.36    0.00    0.36   0.36  75.73
>>
>> I believe newstore will not split the request, so there should be some very small IO(~0KB) goes with the data write(4KB), where the small IO comes from ?
>>
>> Also checked the Filestore data, this behavior is not present in Filestore, changing the WBThrottle will affect the number. So seems this behavior is related with the flushing mechanism? In newstore we are doing fdatasync more aggressively.
>
> Yeah, it sounds like the difference is that newstore is doing immediate
> fdatasync's (on new objects or appends, and on applying post-commit wal
> items).  The 2k IOs are probably the xfs journal commit?
>
>> 2. Notice that by tuning the write_buffer_size , wirte_buffer_num and
>> min_write_buffer_number_to_merge, we can make the DB write to ZERO
>>
>> Look at the iostat of SDC, actually there is almost no IO happened
>> there, that is because most of the WAL entries were merged before
>> flushing to Level0.
>>
>> Other RocksDB tuning are originally trying  to optimize the compaction
>> behavior, but since there is few data written to Level0, the compaction
>> is almost unmeasurable here.
>
> This is good news.  Was the overlay code being used in this case?  (By
> default it should kick in for 4k writes unless you do 'newstore overlay
> max = 0' or similar.  If we can confirm that our wal writes aren't being
> amplified at all that's great news.

So I should retest, but with overlay disabled I thought I was still 
seeing writes into level 0 (and ultimately propagated to level 4) when 
testing on the SSD using 6 512MB buffers and 
min_write_buffer_number_to_merge = 2 on my SSD setup.  I'll try poking 
at it some more using the other settings Xiaoxi tested.  The good news 
is that with all of the changes we've made, spinning disk write 
performance is getting much closer to (and sometimes beating!) 
filestore.  Sent some results along in the other thread.

>
>> 3. Disable RocksDB WAL can 3X  the performance(Although this is
>> definitely WRONG WAY)
>>
>> Just curious if there is no extra IO happened in DB side, what the
>> performance looks like. I turn off the WAL log of rocks DB, the
>> performance is 3x(799-2464 , lat from 10 -> 3.2)
>>
>> 4. The avg queue size is <1 in any case, both DB_WAL part and fragment
>> part.
>>
>> I guess there is some lock in rocksdb::WriteBatch() that preventing
>> multiple OSD_OP_THREAD working concurrently, not carefully analyzed.
>
> I think it's just newstore, actually.  The only thing that ever triggers a
> commit/sync is the _kv_sync_thread, which calls submit_transaction_sync(),
> and it's just one thread.  On the one hand it's kind of lame to have
> this loop pushing queued transactions to disk.  On the other hand it
> serves to throttle work and provide fairness with all the other IO we
> are generating.
>
> Again, I think the main limiting factor here though is going to be how
> rocksdb implements its WAL (as a file which requires 2 IOs per commit, one
> to write the data block(s) and one to update/journal the file size
> and/or allocation changes).

I'm still struck by the massive performance loss on my SSD configuration 
going from 4MB IOs to 2MB IOs.  SSD theoretical is around 1.7GB/s.  With 
4MB IOs on recent newstore we can achieve a little north of 1GB/s (ie 
better than filestore!), but as soon as we drop to 2MB IOs performance 
drops to 200MB/s while filestore stays around 600MB/s.  The partial 
object writes really hurt.

>
>> An easy way to measure might be comment out
>> db->submit_transaction(txc->t); in NewStore::_txc_submit_kv, to see if
>> we can get more QD in fragment part without issuing the DB.
>
> I'm not sure I totally understand the interface.. my assumption is that
> queue_transaction will give rocksdb the txn to commit whenever it finds it
> convenient (no idea what policy is used there) and queue_transaction_sync
> will trigger a commit now.  If we did have multiple threads doing
> queue_trandsaction_sync (by, say, calling it directly in _txc_submit_kv)
> would qa go up?
>
> Thanks!
> sage
>
>
>
>
>>
>>
>> ----------------------------------------------------------Configurations---------------------------------------------------------------------------------------------------------
>>         My setup is SSD based, 1 OSD, pool with 100pg and size =1. The pattern I am working on is 4KB random write(QD=8) on top of RBD(using fio-librbd).FIO configuration is:
>>                  bs=4k
>> iodepth=8
>> size=10g
>> iodepth_batch_submit=1
>> iodepth_batch_complete=1
>>
>>         The tuning I am using are listed here, this might not be the best but already showing something.
>>                      rocksdb_stats_dump_period_sec = 5
>>      rocksdb_max_background_compactions = 4
>>      rocksdb_compaction_threads = 4
>>      rocksdb_write_buffer_size = 536870912  //512MB
>>      rocksdb_write_buffer_num = 4
>>      rocksdb_min_write_buffer_number_to_merge = 2
>>      rocksdb_level0_file_num_compaction_trigger = 4
>>      rocksdb_max_bytes_for_level_base = 104857600 //100MB
>>      rocksdb_target_file_size_base = 10485760      //10MB
>>      rocksdb_num_levels = 3 // So the MAX_DB_SIZE would be ~10GB(100MB* 10^3), fair enough.
>> ?rocksdb_compression = none
>>
>>
>>                                                                                                                                                                                                                                                                                                                                                                                  Xiaoxi
>>
>> ?
>>
>> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
