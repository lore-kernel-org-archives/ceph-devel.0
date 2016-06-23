From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: issue in ceph_test_objectstore
Date: Thu, 23 Jun 2016 19:13:23 +0300
Message-ID: <2c155e21-3c96-45fe-a132-249f0e974aee@mirantis.com>
References: <CY1PR0201MB182017D403FA8C2F71C723F9852D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35419 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcFWQNZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2016 12:13:25 -0400
Received: by mail-lf0-f47.google.com with SMTP id l188so98112976lfe.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 09:13:24 -0700 (PDT)
In-Reply-To: <CY1PR0201MB182017D403FA8C2F71C723F9852D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Ramesh,

correcting myself...

the workaround I mentioned is for snappy lookup issue fix.

But it looks like your failure is at unrelated area: see 
BlueStore::TwoQCache

This is a new code Sage merged recently. Most probably there is some 
issue there. Will try to run the test cases against updated code base soon.


Thanks,
Igor

On 23.06.2016 18:53, Ramesh Chander wrote:
> I am hitting this issue when running ceph_test_objectstore with bluestore without bluefs.
>
> Known issue or something wrong in configuration?
>
> One suspicion is error of not able to find libsnappy.
>
> ----------------------------------
>
>
> 2016-06-23 21:20:01.340312 7ffff7fdd680  1 bluestore(store_test_temp_dir) _open_db opened rocksdb path store_test_temp_dir/db options compression=kNoCompression,max_write_buffer_number=16,min_write_buffer_number_to_merge=3,recycle_log_file_num=16
> 2016-06-23 21:20:01.340367 7ffff7fdd680  1 freelist init
> [New Thread 0x7fffe2ffd700 (LWP 30859)]
> 2016-06-23 21:20:01.341445 7ffff35ac700 -1 bdev(store_test_temp_dir/block) _aio_thread got (4) Interrupted system call
> [New Thread 0x7fffe37fe700 (LWP 30860)]
> 2016-06-23 21:20:01.342552 7ffff35ac700 -1 bdev(store_test_temp_dir/block) _aio_thread got (4) Interrupted system call
> 2016-06-23 21:20:01.342624 7ffff7fdd680 -1 load failed dlopen(/usr/local/lib/ceph/compressor/libceph_snappy.so): /usr/local/lib/ceph/compressor/libceph_snappy.so: cannot open shared object file: No such file or directory
> Creating collection meta
> 2016-06-23 21:20:01.342633 7ffff7fdd680 -1 create cannot load compressor of type snappy
> 2016-06-23 21:20:01.342634 7ffff7fdd680 -1 bluestore(store_test_temp_dir) _set_compression unable to initialize snappy compressor
> Creating object #-1:68309cac:::Object 1:head#
> Remove then create
> Remove then create
> Append Full overwrite
> Partial overwrite
> 00000000  61 62 63 61 62 63 64 65  64 65                    |abcabcdede|
> 0000000a
> Truncate + hole
> Reverse fill-in
> 00000000  61 62 63 64 65 66 67 68  69 6a                    |abcdefghij|
> 0000000a
> larger overwrite
> 00000000  61 62 63 64 65 30 31 32  33 34 30 31 32 33 34 30  |abcde01234012340|
> 00000010  31 32 33 34 30 31 32 33  34 61 62 63 64 65 30 31  |123401234abcde01|
> 00000020  32 33 34 30 31 32 33 34  30 31 32 33 34 30 31 32  |2340123401234012|
> 00000030  33 34 61 62 63 64 65 30  31 32 33 34 30 31 32 33  |34abcde012340123|
> 00000040  34 30 31 32 33 34 30 31  32 33 34 61 62 63 64 65  |40123401234abcde|
> 00000050  30 31 32 33 34 30 31 32  33 34 30 31 32 33 34 30  |0123401234012340|
> 00000060  31 32 33 34                                       |1234|
> 00000064
> 00000000  61 62 63 64 65 30 31 32  33 34 30 31 32 33 34 30  |abcde01234012340|
> 00000010  31 32 33 34 30 31 32 33  34 61 62 63 64 65 30 31  |123401234abcde01|
> 00000020  32 33 34 30 31 32 33 34  30 31 32 33 34 30 31 32  |2340123401234012|
> 00000030  33 34 61 62 63 64 65 30  31 32 33 34 30 31 32 33  |34abcde012340123|
> 00000040  34 30 31 32 33 34 30 31  32 33 34 61 62 63 64 65  |40123401234abcde|
> 00000050  30 31 32 33 34 30 31 32  33 34 30 31 32 33 34 30  |0123401234012340|
> 00000060  31 32 33 34                                       |1234|
> 00000064
>
> Write unaligned csum, stage 2
> Cleaning
> 2016-06-23 21:20:01.351634 7ffff7fdd680  1 bluestore(store_test_temp_dir) umount
>
> Program received signal SIGFPE, Arithmetic exception.
> [Switching to Thread 0x7fffe37fe700 (LWP 30860)]
> 0x0000555555879b00 in BlueStore::TwoQCache::trim (this=0x55555e428ab0, onode_max=500, buffer_max=2000000) at os/bluestore/BlueStore.cc:674
> 674         uint64_t kin = buffer_max / avg_buffer_size / 2;
> (gdb) bt
> #0  0x0000555555879b00 in BlueStore::TwoQCache::trim (this=0x55555e428ab0, onode_max=500, buffer_max=2000000) at os/bluestore/BlueStore.cc:674
> #1  0x000055555585b4fd in BlueStore::_osr_reap_done (this=this@entry=0x55555e428f40, osr=osr@entry=0x55555e327d30) at os/bluestore/BlueStore.cc:4672
> #2  0x0000555555861c44 in BlueStore::_txc_finish (this=this@entry=0x55555e428f40, txc=txc@entry=0x55555e44c8b0) at os/bluestore/BlueStore.cc:4642
> #3  0x0000555555871d1a in BlueStore::_txc_state_proc (this=this@entry=0x55555e428f40, txc=0x55555e44c8b0) at os/bluestore/BlueStore.cc:4499
> #4  0x000055555587de4f in BlueStore::_kv_sync_thread (this=0x55555e428f40) at os/bluestore/BlueStore.cc:4816
> #5  0x00005555558abcbd in BlueStore::KVSyncThread::entry (this=<optimized out>) at os/bluestore/BlueStore.h:1120
> #6  0x00007ffff64b2182 in start_thread (arg=0x7fffe37fe700) at pthread_create.c:312
> #7  0x00007ffff4ccf47d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
>
>
> -Regards,
>   Ramesh Chander
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

