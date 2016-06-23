From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: issue in ceph_test_objectstore
Date: Thu, 23 Jun 2016 19:01:32 +0000
Message-ID: <BL2PR02MB21155B8F8467E1FD5DFB31B8F42D0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CY1PR0201MB182017D403FA8C2F71C723F9852D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606231631150.3223@piezo.us.to>
 <CY1PR0201MB1820348C5DC4511698935E86852D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606231635580.3223@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0068.outbound.protection.outlook.com ([157.56.110.68]:41187
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751244AbcFWTBg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2016 15:01:36 -0400
In-Reply-To: <alpine.DEB.2.11.1606231635580.3223@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I tried to configure BlueStore without BlueFS and configuring rocksdb on top of bootstrap partition. It came up well. See this..

root@emsnode10:/var/lib/ceph/osd/ceph-0# ll
total 44
drwxr-xr-x  3 root root  174 Jun 23 14:40 ./
drwxr-xr-x 22 root root 4096 Sep 28  2015 ../
lrwxrwxrwx  1 root root    9 Jun 23 14:38 block -> /dev/sdb3
-rw-r--r--  1 root root    2 Jun 23 14:38 bluefs
-rw-r--r--  1 root root   37 Jun 23 14:38 ceph_fsid
drwxr-xr-x  2 root root  152 Jun 23 14:55 db/
-rw-r--r--  1 root root   37 Jun 23 14:38 fsid
-rw-------  1 root root   56 Jun 23 14:38 keyring
-rw-r--r--  1 root root    8 Jun 23 14:38 kv_backend
-rw-r--r--  1 root root   21 Jun 23 14:38 magic
-rw-r--r--  1 root root    4 Jun 23 14:38 mkfs_done
-rw-r--r--  1 root root    6 Jun 23 14:38 ready
-rw-r--r--  1 root root   10 Jun 23 14:38 type
-rw-r--r--  1 root root    2 Jun 23 14:38 whoami

db folder is created properly and cluster became clean with 16 OSDs. But, creating rbd image failed and also on subsequent restart osds are crashing on get_map()

ceph version 10.2.0-2713-g7057173 (705717354752c63bdb485a3566a6243c843534f1)
 1: (()+0x9d1d3e) [0x56124ec7ed3e]
 2: (()+0x113d0) [0x7f3c1026f3d0]
 3: (gsignal()+0x38) [0x7f3c0dff4418]
 4: (abort()+0x16a) [0x7f3c0dff601a]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x26b) [0x56124ed96d7b]
 6: (OSDService::get_map(unsigned int)+0x5d) [0x56124e6b9ffd]
 7: (OSD::init()+0x1f5f) [0x56124e662d1f]
 8: (main()+0x2fd8) [0x56124e5c4098]
 9: (__libc_start_main()+0xf0) [0x7f3c0dfdf830]
 10: (_start()+0x29) [0x56124e6114b9]
2016-06-23 11:59:29.454772 7f3c117958c0 -1 *** Caught signal (Aborted) **

I used the following config option :

        bluestore_block_db_size = 536870912000
        bluestore_block_db_create = true
        bluestore_bluefs = false

Am I missing anything ? 
I was trying to do that to identify Bluefs overhead.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, June 23, 2016 9:36 AM
To: Ramesh Chander
Cc: ceph-devel
Subject: RE: issue in ceph_test_objectstore

What commit are you on, and what arguments are you passing to ceph_test_objectstore?  I can't seem to hit it

On Thu, 23 Jun 2016, Ramesh Chander wrote:

> Thanks Sage,
> 
> Yes snappy error no more there with workaround.
> 
> But issue still hit.
> 
> -Ramesh
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Thursday, June 23, 2016 10:02 PM
> > To: Ramesh Chander
> > Cc: ceph-devel
> > Subject: Re: issue in ceph_test_objectstore
> >
> > On Thu, 23 Jun 2016, Ramesh Chander wrote:
> > > I am hitting this issue when running ceph_test_objectstore with 
> > > bluestore
> > without bluefs.
> > >
> > > Known issue or something wrong in configuration?
> >
> > I haven't seen it.  trying to reproduce now.
> >
> > > One suspicion is error of not able to find libsnappy.
> >
> > run ./vstart.sh -d -n -x -l
> >
> > and control-c out of it, or ./stop.sh when it's done.  the plugin 
> > error should go away.
> >
> >
> > >
> > > ----------------------------------
> > >
> > >
> > > 2016-06-23 21:20:01.340312 7ffff7fdd680  1 
> > > bluestore(store_test_temp_dir)
> > _open_db opened rocksdb path store_test_temp_dir/db options 
> > compression=kNoCompression,max_write_buffer_number=16,min_write_b
> > uffer_number_to_merge=3,recycle_log_file_num=16
> > > 2016-06-23 21:20:01.340367 7ffff7fdd680  1 freelist init [New 
> > > Thread 0x7fffe2ffd700 (LWP 30859)]
> > > 2016-06-23 21:20:01.341445 7ffff35ac700 -1
> > bdev(store_test_temp_dir/block) _aio_thread got (4) Interrupted 
> > system call
> > > [New Thread 0x7fffe37fe700 (LWP 30860)]
> > > 2016-06-23 21:20:01.342552 7ffff35ac700 -1
> > bdev(store_test_temp_dir/block) _aio_thread got (4) Interrupted 
> > system call
> > > 2016-06-23 21:20:01.342624 7ffff7fdd680 -1 load failed
> > dlopen(/usr/local/lib/ceph/compressor/libceph_snappy.so):
> > /usr/local/lib/ceph/compressor/libceph_snappy.so: cannot open shared 
> > object file: No such file or directory
> > > Creating collection meta
> > > 2016-06-23 21:20:01.342633 7ffff7fdd680 -1 create cannot load 
> > > compressor
> > of type snappy
> > > 2016-06-23 21:20:01.342634 7ffff7fdd680 -1
> > bluestore(store_test_temp_dir) _set_compression unable to initialize 
> > snappy compressor
> > > Creating object #-1:68309cac:::Object 1:head# Remove then create 
> > > Remove then create Append Full overwrite Partial overwrite
> > > 00000000  61 62 63 61 62 63 64 65  64 65                    |abcabcdede|
> > > 0000000a
> > > Truncate + hole
> > > Reverse fill-in
> > > 00000000  61 62 63 64 65 66 67 68  69 6a                    |abcdefghij|
> > > 0000000a
> > > larger overwrite
> > > 00000000  61 62 63 64 65 30 31 32  33 34 30 31 32 33 34 30
> > |abcde01234012340|
> > > 00000010  31 32 33 34 30 31 32 33  34 61 62 63 64 65 30 31
> > |123401234abcde01|
> > > 00000020  32 33 34 30 31 32 33 34  30 31 32 33 34 30 31 32
> > |2340123401234012|
> > > 00000030  33 34 61 62 63 64 65 30  31 32 33 34 30 31 32 33
> > |34abcde012340123|
> > > 00000040  34 30 31 32 33 34 30 31  32 33 34 61 62 63 64 65
> > |40123401234abcde|
> > > 00000050  30 31 32 33 34 30 31 32  33 34 30 31 32 33 34 30
> > |0123401234012340|
> > > 00000060  31 32 33 34                                       |1234|
> > > 00000064
> > > 00000000  61 62 63 64 65 30 31 32  33 34 30 31 32 33 34 30
> > |abcde01234012340|
> > > 00000010  31 32 33 34 30 31 32 33  34 61 62 63 64 65 30 31
> > |123401234abcde01|
> > > 00000020  32 33 34 30 31 32 33 34  30 31 32 33 34 30 31 32
> > |2340123401234012|
> > > 00000030  33 34 61 62 63 64 65 30  31 32 33 34 30 31 32 33
> > |34abcde012340123|
> > > 00000040  34 30 31 32 33 34 30 31  32 33 34 61 62 63 64 65
> > |40123401234abcde|
> > > 00000050  30 31 32 33 34 30 31 32  33 34 30 31 32 33 34 30
> > |0123401234012340|
> > > 00000060  31 32 33 34                                       |1234|
> > > 00000064
> > >
> > > Write unaligned csum, stage 2
> > > Cleaning
> > > 2016-06-23 21:20:01.351634 7ffff7fdd680  1 
> > > bluestore(store_test_temp_dir)
> > umount
> > >
> > > Program received signal SIGFPE, Arithmetic exception.
> > > [Switching to Thread 0x7fffe37fe700 (LWP 30860)]
> > > 0x0000555555879b00 in BlueStore::TwoQCache::trim
> > (this=0x55555e428ab0, onode_max=500, buffer_max=2000000) at
> > os/bluestore/BlueStore.cc:674
> > > 674         uint64_t kin = buffer_max / avg_buffer_size / 2;
> > > (gdb) bt
> > > #0  0x0000555555879b00 in BlueStore::TwoQCache::trim
> > (this=0x55555e428ab0, onode_max=500, buffer_max=2000000) at
> > os/bluestore/BlueStore.cc:674
> > > #1  0x000055555585b4fd in BlueStore::_osr_reap_done
> > (this=this@entry=0x55555e428f40, osr=osr@entry=0x55555e327d30) at
> > os/bluestore/BlueStore.cc:4672
> > > #2  0x0000555555861c44 in BlueStore::_txc_finish
> > (this=this@entry=0x55555e428f40, txc=txc@entry=0x55555e44c8b0) at
> > os/bluestore/BlueStore.cc:4642
> > > #3  0x0000555555871d1a in BlueStore::_txc_state_proc
> > (this=this@entry=0x55555e428f40, txc=0x55555e44c8b0) at
> > os/bluestore/BlueStore.cc:4499
> > > #4  0x000055555587de4f in BlueStore::_kv_sync_thread
> > (this=0x55555e428f40) at os/bluestore/BlueStore.cc:4816
> > > #5  0x00005555558abcbd in BlueStore::KVSyncThread::entry
> > (this=<optimized out>) at os/bluestore/BlueStore.h:1120
> > > #6  0x00007ffff64b2182 in start_thread (arg=0x7fffe37fe700) at
> > pthread_create.c:312
> > > #7  0x00007ffff4ccf47d in clone () at
> > ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
> > >
> > >
> > >
> > > -Regards,
> > >  Ramesh Chander
> > >
> > > PLEASE NOTE: The information contained in this electronic mail 
> > > message is
> > intended only for the use of the designated recipient(s) named 
> > above. If the reader of this message is not the intended recipient, 
> > you are hereby notified that you have received this message in error 
> > and that any review, dissemination, distribution, or copying of this 
> > message is strictly prohibited. If you have received this 
> > communication in error, please notify the sender by telephone or 
> > e-mail (as shown above) immediately and destroy any and all copies 
> > of this message in your possession (whether hard copies or electronically stored copies).
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
