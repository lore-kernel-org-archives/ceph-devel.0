From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Wed, 23 Aug 2017 21:33:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708232131360.20435@piezo.novalocal>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com> <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com> <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com> <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
 <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM> <a6a7dd77-8b36-b2fb-183a-ecce43f3b8d7@redhat.com> <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM> <238bc116-e706-031e-ab11-06e2383a9a04@redhat.com> <469DEC9D-7E3D-49C5-8AE6-71877039B3AC@TERADATA.COM>
 <CAKPXa=ZPeMST83ekgUkYbO5yz-ic3q_guY__0=tY7PSwmk-4YA@mail.gmail.com> <1B0B99FE-C6D5-455E-B8B7-1972D9B8FD2F@TERADATA.COM> <00EA3786-0D39-446A-8E48-0E03D505AC51@TERADATA.COM> <66B27C76-0184-452F-9BC8-A91E6D6C9B60@TERADATA.COM> <dcbb44f0-c1e9-2acf-133c-fe7dbfcdcd51@redhat.com>
 <C4D152F9-47F1-4883-A4BC-B9FF8F963A0D@TERADATA.COM> <alpine.DEB.2.11.1708231854570.20435@piezo.novalocal> <13128840-6AA3-4B16-BC18-FC8B9DD8690C@TERADATA.COM>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-402453392-1503524012=:20435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdHWVdc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Aug 2017 17:33:32 -0400
In-Reply-To: <13128840-6AA3-4B16-BC18-FC8B9DD8690C@TERADATA.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: David Zafman <dzafman@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-402453392-1503524012=:20435
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 23 Aug 2017, Kamble, Nitin A wrote:
> Hi Sage,
> My comments inline below.
> 
> On 8/23/17, 12:15 PM, "Sage Weil" <sweil@redhat.com> wrote:
> 
>     Hi Nitin,
>     
>     As David mentioned, it's a non-fatal error, so disabling fsck on mount is 
>     a fine workaround.  (Out of curiousity, how did fsck get enabled in the 
>     first place?  It should be off by default.)
>     
> I find it is enabled by default.

Which version are you running?  Master branch has

    Option("bluestore_fsck_on_mount", Option::TYPE_BOOL, Option::LEVEL_DEV)
    .set_default(false)

>     If you don't mind, I have a branch that will additionally spit out exactly 
>     which extent(s) were leaked:
>     
>     	https://github.com/liewegas/ceph/commit/wip-bluestore-fsck-leaks-luminous
>     
>     Would you mind running fsck with that branch and send me the log?
>     
> Sure, I can try it out. Looks like I will only need 
> ceph-objectstore-tool replaced in my ceph setup, correct?

Right.  Thanks!

>      CEPH_ARGS="--log-file c" ceph-objectstore-tool --op fsck --data-path ...
>     
>     One with --debug-bluestore 20 in the CEPH_ARGS would be ideal if it's not 
>     too big.  You can ceph-post-file the log.
> 
> What is ceph-post-file thingy? I have not used it before.

It will upload a file or files to a server the developers have access to 
(any developers with access to the sepia lab) and spit out a uuid they can 
use to identify which upload is yours.

sage


>     
> Thanks,
> Nitin
> 
>     Thanks!
>     sage
>     
>     On Thu, 17 Aug 2017, Kamble, Nitin A wrote:
>     
>     > 
>     > 
>     > On 8/17/17, 1:50 PM, "David Zafman" <dzafman@redhat.com> wrote:
>     > 
>     >     
>     >     I wouldn't run the OSDs without identifying what is going on.  I suggest 
>     >     you stop the OSD and run fsck using ceph-objectstore-tool:
>     >     
>     >     
>     >     ceph-objectstore-tool --data-path .... --op fsck
>     >     
>     >     If you don't get any informative messages add --debug to get detail logging.
>     >     
>     >     
>     >     David
>     >     
>     >  
>     > Thanks, David for your input. It is interesting that all the 50 osds had the same fsck issue immediately after the upgrade.
>     > 
>     > Below is the log of manual fsck.
>     > 
>     > This is the error line in it:
>     > fsck error: leaked some space;65536 bytes leaked
>     > 
>     > 
>     > # ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-2 --op fsck --debug
>     > warning: line 36: 'bluestore_fsck_on_mount' in section 'global' redefined 
>     > 2017-08-17 14:03:43.895377 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck (shallow) start
>     > 2017-08-17 14:03:43.895410 7fcb138f8280  1 bdev create path /var/lib/ceph/osd/ceph-2/block type kernel
>     > 2017-08-17 14:03:43.895416 7fcb138f8280  1 bdev(0x5601f87b3200 /var/lib/ceph/osd/ceph-2/block) open path /var/lib/ceph/osd/ceph-2/block
>     > 2017-08-17 14:03:43.895684 7fcb138f8280  1 bdev(0x5601f87b3200 /var/lib/ceph/osd/ceph-2/block) open size 4000681103360 (0x3a37b2d1000, 3725 GB) block_size 4096 (4096 B) rotational
>     > 2017-08-17 14:03:43.895942 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) _set_cache_sizes max 0.5 < ratio 0.99
>     > 2017-08-17 14:03:43.895957 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) _set_cache_sizes cache_size 1073741824 meta 0.5 kv 0.5 data 0
>     > 2017-08-17 14:03:43.895990 7fcb138f8280  1 bdev create path /var/lib/ceph/osd/ceph-2/block.db type kernel
>     > 2017-08-17 14:03:43.895994 7fcb138f8280  1 bdev(0x5601f87b3400 /var/lib/ceph/osd/ceph-2/block.db) open path /var/lib/ceph/osd/ceph-2/block.db
>     > 2017-08-17 14:03:43.896162 7fcb138f8280  1 bdev(0x5601f87b3400 /var/lib/ceph/osd/ceph-2/block.db) open size 1073741824 (0x40000000, 1024 MB) block_size 4096 (4096 B) non-rotational
>     > 2017-08-17 14:03:43.896168 7fcb138f8280  1 bluefs add_block_device bdev 1 path /var/lib/ceph/osd/ceph-2/block.db size 1024 MB
>     > 2017-08-17 14:03:43.896364 7fcb138f8280  1 bdev create path /var/lib/ceph/osd/ceph-2/block type kernel
>     > 2017-08-17 14:03:43.896372 7fcb138f8280  1 bdev(0x5601f87b3600 /var/lib/ceph/osd/ceph-2/block) open path /var/lib/ceph/osd/ceph-2/block
>     > 2017-08-17 14:03:43.896529 7fcb138f8280  1 bdev(0x5601f87b3600 /var/lib/ceph/osd/ceph-2/block) open size 4000681103360 (0x3a37b2d1000, 3725 GB) block_size 4096 (4096 B) rotational
>     > 2017-08-17 14:03:43.896535 7fcb138f8280  1 bluefs add_block_device bdev 2 path /var/lib/ceph/osd/ceph-2/block size 3725 GB
>     > 2017-08-17 14:03:43.896546 7fcb138f8280  1 bdev create path /var/lib/ceph/osd/ceph-2/block.wal type kernel
>     > 2017-08-17 14:03:43.896549 7fcb138f8280  1 bdev(0x5601f87b3800 /var/lib/ceph/osd/ceph-2/block.wal) open path /var/lib/ceph/osd/ceph-2/block.wal
>     > 2017-08-17 14:03:43.896733 7fcb138f8280  1 bdev(0x5601f87b3800 /var/lib/ceph/osd/ceph-2/block.wal) open size 10737418240 (0x280000000, 10240 MB) block_size 4096 (4096 B) non-rotational
>     > 2017-08-17 14:03:43.896739 7fcb138f8280  1 bluefs add_block_device bdev 0 path /var/lib/ceph/osd/ceph-2/block.wal size 10240 MB
>     > 2017-08-17 14:03:43.896912 7fcb138f8280  1 bluefs mount
>     > 2017-08-17 14:03:43.902514 7fcb138f8280  0  set rocksdb option compaction_readahead_size = 2097152
>     > 2017-08-17 14:03:43.902525 7fcb138f8280  0  set rocksdb option compression = kNoCompression
>     > 2017-08-17 14:03:43.902533 7fcb138f8280  0  set rocksdb option max_write_buffer_number = 4
>     > 2017-08-17 14:03:43.902538 7fcb138f8280  0  set rocksdb option min_write_buffer_number_to_merge = 1
>     > 2017-08-17 14:03:43.902541 7fcb138f8280  0  set rocksdb option recycle_log_file_num = 4
>     > 2017-08-17 14:03:43.902544 7fcb138f8280  0  set rocksdb option writable_file_max_buffer_size = 0
>     > 2017-08-17 14:03:43.902548 7fcb138f8280  0  set rocksdb option write_buffer_size = 268435456
>     > 2017-08-17 14:03:43.902572 7fcb138f8280  0  set rocksdb option compaction_readahead_size = 2097152
>     > 2017-08-17 14:03:43.902577 7fcb138f8280  0  set rocksdb option compression = kNoCompression
>     > 2017-08-17 14:03:43.902580 7fcb138f8280  0  set rocksdb option max_write_buffer_number = 4
>     > 2017-08-17 14:03:43.902584 7fcb138f8280  0  set rocksdb option min_write_buffer_number_to_merge = 1
>     > 2017-08-17 14:03:43.902587 7fcb138f8280  0  set rocksdb option recycle_log_file_num = 4
>     > 2017-08-17 14:03:43.902590 7fcb138f8280  0  set rocksdb option writable_file_max_buffer_size = 0
>     > 2017-08-17 14:03:43.902593 7fcb138f8280  0  set rocksdb option write_buffer_size = 268435456
>     > 2017-08-17 14:03:43.902706 7fcb138f8280  4 rocksdb: RocksDB version: 5.4.0
>     > 
>     > 2017-08-17 14:03:43.902713 7fcb138f8280  4 rocksdb: Git sha rocksdb_build_git_sha:@0@
>     > 2017-08-17 14:03:43.902715 7fcb138f8280  4 rocksdb: Compile date Aug 15 2017
>     > 2017-08-17 14:03:43.902719 7fcb138f8280  4 rocksdb: DB SUMMARY
>     > 
>     > 2017-08-17 14:03:43.902727 7fcb138f8280  4 rocksdb: CURRENT file:  CURRENT
>     > 
>     > 2017-08-17 14:03:43.902729 7fcb138f8280  4 rocksdb: IDENTITY file:  IDENTITY
>     > 
>     > 2017-08-17 14:03:43.902735 7fcb138f8280  4 rocksdb: MANIFEST file:  MANIFEST-000937 size: 1083 Bytes
>     > 
>     > 2017-08-17 14:03:43.902739 7fcb138f8280  4 rocksdb: SST files in db dir, Total Num: 0, files: 
>     > 
>     > 2017-08-17 14:03:43.902745 7fcb138f8280  4 rocksdb: SST files in db.slow dir, Total Num: 6, files: 000187.sst 000199.sst 000219.sst 000220.sst 000934.sst 000935.sst 
>     > 
>     > 2017-08-17 14:03:43.902753 7fcb138f8280  4 rocksdb: Write Ahead Log file in db.wal: 000938.log size: 0 ; 
>     > 
>     > 2017-08-17 14:03:43.902755 7fcb138f8280  4 rocksdb:                         Options.error_if_exists: 0
>     > 2017-08-17 14:03:43.902756 7fcb138f8280  4 rocksdb:                       Options.create_if_missing: 0
>     > 2017-08-17 14:03:43.902757 7fcb138f8280  4 rocksdb:                         Options.paranoid_checks: 1
>     > 2017-08-17 14:03:43.902758 7fcb138f8280  4 rocksdb:                                     Options.env: 0x5601f8a43e80
>     > 2017-08-17 14:03:43.902759 7fcb138f8280  4 rocksdb:                                Options.info_log: 0x5601f8a443e0
>     > 2017-08-17 14:03:43.902760 7fcb138f8280  4 rocksdb:                          Options.max_open_files: -1
>     > 2017-08-17 14:03:43.902762 7fcb138f8280  4 rocksdb:                Options.max_file_opening_threads: 16
>     > 2017-08-17 14:03:43.902763 7fcb138f8280  4 rocksdb:                               Options.use_fsync: 0
>     > 2017-08-17 14:03:43.902764 7fcb138f8280  4 rocksdb:                       Options.max_log_file_size: 0
>     > 2017-08-17 14:03:43.902765 7fcb138f8280  4 rocksdb:                  Options.max_manifest_file_size: 18446744073709551615
>     > 2017-08-17 14:03:43.902766 7fcb138f8280  4 rocksdb:                   Options.log_file_time_to_roll: 0
>     > 2017-08-17 14:03:43.902767 7fcb138f8280  4 rocksdb:                       Options.keep_log_file_num: 1000
>     > 2017-08-17 14:03:43.902768 7fcb138f8280  4 rocksdb:                    Options.recycle_log_file_num: 4
>     > 2017-08-17 14:03:43.902769 7fcb138f8280  4 rocksdb:                         Options.allow_fallocate: 1
>     > 2017-08-17 14:03:43.902770 7fcb138f8280  4 rocksdb:                        Options.allow_mmap_reads: 0
>     > 2017-08-17 14:03:43.902771 7fcb138f8280  4 rocksdb:                       Options.allow_mmap_writes: 0
>     > 2017-08-17 14:03:43.902771 7fcb138f8280  4 rocksdb:                        Options.use_direct_reads: 0
>     > 2017-08-17 14:03:43.902772 7fcb138f8280  4 rocksdb:                        Options.use_direct_io_for_flush_and_compaction: 0
>     > 2017-08-17 14:03:43.902774 7fcb138f8280  4 rocksdb:          Options.create_missing_column_families: 0
>     > 2017-08-17 14:03:43.902781 7fcb138f8280  4 rocksdb:                              Options.db_log_dir: 
>     > 2017-08-17 14:03:43.902783 7fcb138f8280  4 rocksdb:                                 Options.wal_dir: db.wal
>     > 2017-08-17 14:03:43.902784 7fcb138f8280  4 rocksdb:                Options.table_cache_numshardbits: 6
>     > 2017-08-17 14:03:43.902784 7fcb138f8280  4 rocksdb:                      Options.max_subcompactions: 1
>     > 2017-08-17 14:03:43.902785 7fcb138f8280  4 rocksdb:                  Options.max_background_flushes: 1
>     > 2017-08-17 14:03:43.902786 7fcb138f8280  4 rocksdb:                         Options.WAL_ttl_seconds: 0
>     > 2017-08-17 14:03:43.902787 7fcb138f8280  4 rocksdb:                       Options.WAL_size_limit_MB: 0
>     > 2017-08-17 14:03:43.902788 7fcb138f8280  4 rocksdb:             Options.manifest_preallocation_size: 4194304
>     > 2017-08-17 14:03:43.902789 7fcb138f8280  4 rocksdb:                     Options.is_fd_close_on_exec: 1
>     > 2017-08-17 14:03:43.902790 7fcb138f8280  4 rocksdb:                   Options.advise_random_on_open: 1
>     > 2017-08-17 14:03:43.902790 7fcb138f8280  4 rocksdb:                    Options.db_write_buffer_size: 0
>     > 2017-08-17 14:03:43.902791 7fcb138f8280  4 rocksdb:         Options.access_hint_on_compaction_start: 1
>     > 2017-08-17 14:03:43.902792 7fcb138f8280  4 rocksdb:  Options.new_table_reader_for_compaction_inputs: 1
>     > 2017-08-17 14:03:43.902793 7fcb138f8280  4 rocksdb:               Options.compaction_readahead_size: 2097152
>     > 2017-08-17 14:03:43.902794 7fcb138f8280  4 rocksdb:           Options.random_access_max_buffer_size: 1048576
>     > 2017-08-17 14:03:43.902795 7fcb138f8280  4 rocksdb:           Options.writable_file_max_buffer_size: 0
>     > 2017-08-17 14:03:43.902795 7fcb138f8280  4 rocksdb:                      Options.use_adaptive_mutex: 0
>     > 2017-08-17 14:03:43.902796 7fcb138f8280  4 rocksdb:                            Options.rate_limiter: (nil)
>     > 2017-08-17 14:03:43.902798 7fcb138f8280  4 rocksdb:     Options.sst_file_manager.rate_bytes_per_sec: 0
>     > 2017-08-17 14:03:43.902799 7fcb138f8280  4 rocksdb:                          Options.bytes_per_sync: 0
>     > 2017-08-17 14:03:43.902801 7fcb138f8280  4 rocksdb:                      Options.wal_bytes_per_sync: 0
>     > 2017-08-17 14:03:43.902802 7fcb138f8280  4 rocksdb:                       Options.wal_recovery_mode: 0
>     > 2017-08-17 14:03:43.902803 7fcb138f8280  4 rocksdb:                  Options.enable_thread_tracking: 0
>     > 2017-08-17 14:03:43.902804 7fcb138f8280  4 rocksdb:         Options.allow_concurrent_memtable_write: 1
>     > 2017-08-17 14:03:43.902805 7fcb138f8280  4 rocksdb:      Options.enable_write_thread_adaptive_yield: 1
>     > 2017-08-17 14:03:43.902806 7fcb138f8280  4 rocksdb:             Options.write_thread_max_yield_usec: 100
>     > 2017-08-17 14:03:43.902807 7fcb138f8280  4 rocksdb:            Options.write_thread_slow_yield_usec: 3
>     > 2017-08-17 14:03:43.902808 7fcb138f8280  4 rocksdb:                               Options.row_cache: None
>     > 2017-08-17 14:03:43.902808 7fcb138f8280  4 rocksdb:                              Options.wal_filter: None
>     > 2017-08-17 14:03:43.902809 7fcb138f8280  4 rocksdb:             Options.avoid_flush_during_recovery: 0
>     > 2017-08-17 14:03:43.902810 7fcb138f8280  4 rocksdb:             Options.base_background_compactions: 1
>     > 2017-08-17 14:03:43.902811 7fcb138f8280  4 rocksdb:             Options.max_background_compactions: 1
>     > 2017-08-17 14:03:43.902812 7fcb138f8280  4 rocksdb:             Options.avoid_flush_during_shutdown: 0
>     > 2017-08-17 14:03:43.902813 7fcb138f8280  4 rocksdb:             Options.delayed_write_rate : 16777216
>     > 2017-08-17 14:03:43.902814 7fcb138f8280  4 rocksdb:             Options.max_total_wal_size: 0
>     > 2017-08-17 14:03:43.902816 7fcb138f8280  4 rocksdb:             Options.delete_obsolete_files_period_micros: 21600000000
>     > 2017-08-17 14:03:43.902817 7fcb138f8280  4 rocksdb:                   Options.stats_dump_period_sec: 600
>     > 2017-08-17 14:03:43.902818 7fcb138f8280  4 rocksdb: Compression algorithms supported:
>     > 2017-08-17 14:03:43.902819 7fcb138f8280  4 rocksdb:     Snappy supported: 0
>     > 2017-08-17 14:03:43.902820 7fcb138f8280  4 rocksdb:     Zlib supported: 0
>     > 2017-08-17 14:03:43.902821 7fcb138f8280  4 rocksdb:     Bzip supported: 0
>     > 2017-08-17 14:03:43.902822 7fcb138f8280  4 rocksdb:     LZ4 supported: 0
>     > 2017-08-17 14:03:43.902823 7fcb138f8280  4 rocksdb:     ZSTD supported: 0
>     > 2017-08-17 14:03:43.902824 7fcb138f8280  4 rocksdb: Fast CRC32 supported: 1
>     > 2017-08-17 14:03:43.902920 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/version_set.cc:2609] Recovering from manifest file: MANIFEST-000937
>     > 
>     > 2017-08-17 14:03:43.902958 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/column_family.cc:407] --------------- Options for column family [default]:
>     > 
>     > 2017-08-17 14:03:43.902960 7fcb138f8280  4 rocksdb:               Options.comparator: leveldb.BytewiseComparator
>     > 2017-08-17 14:03:43.902965 7fcb138f8280  4 rocksdb:           Options.merge_operator: .T:int64_array.b:bitwise_xor
>     > 2017-08-17 14:03:43.902966 7fcb138f8280  4 rocksdb:        Options.compaction_filter: None
>     > 2017-08-17 14:03:43.902967 7fcb138f8280  4 rocksdb:        Options.compaction_filter_factory: None
>     > 2017-08-17 14:03:43.902969 7fcb138f8280  4 rocksdb:         Options.memtable_factory: SkipListFactory
>     > 2017-08-17 14:03:43.902970 7fcb138f8280  4 rocksdb:            Options.table_factory: BlockBasedTable
>     > 2017-08-17 14:03:43.902985 7fcb138f8280  4 rocksdb:            table_factory options:   flush_block_policy_factory: FlushBlockBySizePolicyFactory (0x5601f8782208)
>     >   cache_index_and_filter_blocks: 1
>     >   cache_index_and_filter_blocks_with_high_priority: 1
>     >   pin_l0_filter_and_index_blocks_in_cache: 1
>     >   index_type: 0
>     >   hash_index_allow_collision: 1
>     >   checksum: 1
>     >   no_block_cache: 0
>     >   block_cache: 0x5601f87cddd8
>     >   block_cache_name: LRUCache
>     >   block_cache_options:
>     >     capacity : 536870912
>     >     num_shard_bits : 4
>     >     strict_capacity_limit : 0
>     >     high_pri_pool_ratio: 0.000
>     >   block_cache_compressed: (nil)
>     >   persistent_cache: (nil)
>     >   block_size: 4096
>     >   block_size_deviation: 10
>     >   block_restart_interval: 16
>     >   index_block_restart_interval: 1
>     >   filter_policy: rocksdb.BuiltinBloomFilter
>     >   whole_key_filtering: 1
>     >   format_version: 2
>     > 
>     > 2017-08-17 14:03:43.902995 7fcb138f8280  4 rocksdb:        Options.write_buffer_size: 268435456
>     > 2017-08-17 14:03:43.902996 7fcb138f8280  4 rocksdb:  Options.max_write_buffer_number: 4
>     > 2017-08-17 14:03:43.902997 7fcb138f8280  4 rocksdb:          Options.compression: NoCompression
>     > 2017-08-17 14:03:43.902999 7fcb138f8280  4 rocksdb:                  Options.bottommost_compression: Disabled
>     > 2017-08-17 14:03:43.903000 7fcb138f8280  4 rocksdb:       Options.prefix_extractor: nullptr
>     > 2017-08-17 14:03:43.903000 7fcb138f8280  4 rocksdb:   Options.memtable_insert_with_hint_prefix_extractor: nullptr
>     > 2017-08-17 14:03:43.903001 7fcb138f8280  4 rocksdb:             Options.num_levels: 7
>     > 2017-08-17 14:03:43.903002 7fcb138f8280  4 rocksdb:        Options.min_write_buffer_number_to_merge: 1
>     > 2017-08-17 14:03:43.903008 7fcb138f8280  4 rocksdb:     Options.max_write_buffer_number_to_maintain: 0
>     > 2017-08-17 14:03:43.903009 7fcb138f8280  4 rocksdb:            Options.compression_opts.window_bits: -14
>     > 2017-08-17 14:03:43.903010 7fcb138f8280  4 rocksdb:                  Options.compression_opts.level: -1
>     > 2017-08-17 14:03:43.903010 7fcb138f8280  4 rocksdb:               Options.compression_opts.strategy: 0
>     > 2017-08-17 14:03:43.903011 7fcb138f8280  4 rocksdb:         Options.compression_opts.max_dict_bytes: 0
>     > 2017-08-17 14:03:43.903012 7fcb138f8280  4 rocksdb:      Options.level0_file_num_compaction_trigger: 4
>     > 2017-08-17 14:03:43.903013 7fcb138f8280  4 rocksdb:          Options.level0_slowdown_writes_trigger: 20
>     > 2017-08-17 14:03:43.903014 7fcb138f8280  4 rocksdb:              Options.level0_stop_writes_trigger: 36
>     > 2017-08-17 14:03:43.903015 7fcb138f8280  4 rocksdb:                   Options.target_file_size_base: 67108864
>     > 2017-08-17 14:03:43.903015 7fcb138f8280  4 rocksdb:             Options.target_file_size_multiplier: 1
>     > 2017-08-17 14:03:43.903016 7fcb138f8280  4 rocksdb:                Options.max_bytes_for_level_base: 268435456
>     > 2017-08-17 14:03:43.903017 7fcb138f8280  4 rocksdb: Options.level_compaction_dynamic_level_bytes: 0
>     > 2017-08-17 14:03:43.903018 7fcb138f8280  4 rocksdb:          Options.max_bytes_for_level_multiplier: 10.000000
>     > 2017-08-17 14:03:43.903021 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[0]: 1
>     > 2017-08-17 14:03:43.903022 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[1]: 1
>     > 2017-08-17 14:03:43.903023 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[2]: 1
>     > 2017-08-17 14:03:43.903024 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[3]: 1
>     > 2017-08-17 14:03:43.903025 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[4]: 1
>     > 2017-08-17 14:03:43.903026 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[5]: 1
>     > 2017-08-17 14:03:43.903026 7fcb138f8280  4 rocksdb: Options.max_bytes_for_level_multiplier_addtl[6]: 1
>     > 2017-08-17 14:03:43.903027 7fcb138f8280  4 rocksdb:       Options.max_sequential_skip_in_iterations: 8
>     > 2017-08-17 14:03:43.903028 7fcb138f8280  4 rocksdb:                    Options.max_compaction_bytes: 1677721600
>     > 2017-08-17 14:03:43.903029 7fcb138f8280  4 rocksdb:                        Options.arena_block_size: 33554432
>     > 2017-08-17 14:03:43.903030 7fcb138f8280  4 rocksdb:   Options.soft_pending_compaction_bytes_limit: 68719476736
>     > 2017-08-17 14:03:43.903031 7fcb138f8280  4 rocksdb:   Options.hard_pending_compaction_bytes_limit: 274877906944
>     > 2017-08-17 14:03:43.903032 7fcb138f8280  4 rocksdb:       Options.rate_limit_delay_max_milliseconds: 100
>     > 2017-08-17 14:03:43.903033 7fcb138f8280  4 rocksdb:                Options.disable_auto_compactions: 0
>     > 2017-08-17 14:03:43.903034 7fcb138f8280  4 rocksdb:                         Options.compaction_style: kCompactionStyleLevel
>     > 2017-08-17 14:03:43.903035 7fcb138f8280  4 rocksdb:                           Options.compaction_pri: kByCompensatedSize
>     > 2017-08-17 14:03:43.903036 7fcb138f8280  4 rocksdb:  Options.compaction_options_universal.size_ratio: 1
>     > 2017-08-17 14:03:43.903037 7fcb138f8280  4 rocksdb: Options.compaction_options_universal.min_merge_width: 2
>     > 2017-08-17 14:03:43.903038 7fcb138f8280  4 rocksdb: Options.compaction_options_universal.max_merge_width: 4294967295
>     > 2017-08-17 14:03:43.903039 7fcb138f8280  4 rocksdb: Options.compaction_options_universal.max_size_amplification_percent: 200
>     > 2017-08-17 14:03:43.903040 7fcb138f8280  4 rocksdb: Options.compaction_options_universal.compression_size_percent: -1
>     > 2017-08-17 14:03:43.903041 7fcb138f8280  4 rocksdb: Options.compaction_options_fifo.max_table_files_size: 1073741824
>     > 2017-08-17 14:03:43.903042 7fcb138f8280  4 rocksdb:                   Options.table_properties_collectors:
>     > 2017-08-17 14:03:43.903043 7fcb138f8280  4 rocksdb:                   Options.inplace_update_support: 0
>     > 2017-08-17 14:03:43.903044 7fcb138f8280  4 rocksdb:                 Options.inplace_update_num_locks: 10000
>     > 2017-08-17 14:03:43.903045 7fcb138f8280  4 rocksdb:               Options.memtable_prefix_bloom_size_ratio: 0.000000
>     > 2017-08-17 14:03:43.903046 7fcb138f8280  4 rocksdb:   Options.memtable_huge_page_size: 0
>     > 2017-08-17 14:03:43.903047 7fcb138f8280  4 rocksdb:                           Options.bloom_locality: 0
>     > 2017-08-17 14:03:43.903048 7fcb138f8280  4 rocksdb:                    Options.max_successive_merges: 0
>     > 2017-08-17 14:03:43.903049 7fcb138f8280  4 rocksdb:                Options.optimize_filters_for_hits: 0
>     > 2017-08-17 14:03:43.903050 7fcb138f8280  4 rocksdb:                Options.paranoid_file_checks: 0
>     > 2017-08-17 14:03:43.903051 7fcb138f8280  4 rocksdb:                Options.force_consistency_checks: 0
>     > 2017-08-17 14:03:43.903053 7fcb138f8280  4 rocksdb:                Options.report_bg_io_stats: 0
>     > 2017-08-17 14:03:43.946483 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/version_set.cc:2859] Recovered from manifest file:db/MANIFEST-000937 succeeded,manifest_file_number is 937, next_file_number is 939, last_sequence is 64576158, log_number is 0,prev_log_number is 0,max_column_family is 0
>     > 
>     > 2017-08-17 14:03:43.946492 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/version_set.cc:2867] Column family [default] (ID 0), log number is 932
>     > 
>     > 2017-08-17 14:03:43.946530 7fcb138f8280  4 rocksdb: EVENT_LOG_v1 {"time_micros": 1503003823946523, "job": 1, "event": "recovery_started", "log_files": [938]}
>     > 2017-08-17 14:03:43.946533 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/db_impl_open.cc:482] Recovering log #938 mode 0
>     > 2017-08-17 14:03:43.946541 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/version_set.cc:2395] Creating manifest 940
>     > 
>     > 2017-08-17 14:03:43.947010 7fcb138f8280  4 rocksdb: EVENT_LOG_v1 {"time_micros": 1503003823947008, "job": 1, "event": "recovery_finished"}
>     > 2017-08-17 14:03:43.947694 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/db_impl_open.cc:1063] DB pointer 0x5601f8a8ab00
>     > 2017-08-17 14:03:43.947722 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) _open_db opened rocksdb path db options compression=kNoCompression,max_write_buffer_number=4,min_write_buffer_number_to_merge=1,recycle_log_file_num=4,write_buffer_size=268435456,writable_file_max_buffer_size=0,compaction_readahead_size=2097152
>     > 2017-08-17 14:03:43.995973 7fcb138f8280  1 freelist init
>     > 2017-08-17 14:03:44.027637 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) _open_alloc opening allocation metadata
>     > 2017-08-17 14:03:45.927394 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) _open_alloc loaded 3701 G in 3919 extents
>     > 2017-08-17 14:03:46.426774 7fcb138f8280  1 bluefs fsck
>     > 2017-08-17 14:03:46.426792 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck walking object keyspace
>     > 2017-08-17 14:03:50.856077 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck checking shared_blobs
>     > 2017-08-17 14:03:50.856119 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck checking for stray omap data
>     > 2017-08-17 14:03:52.405816 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck checking deferred events
>     > 2017-08-17 14:03:52.405862 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck checking freelist vs allocated
>     > 2017-08-17 14:04:06.311748 7fcb138f8280 -1 bluestore(/var/lib/ceph/osd/ceph-2) fsck error: leaked some space;65536 bytes leaked
>     > 2017-08-17 14:04:06.410019 7fcb138f8280  1 freelist shutdown
>     > 2017-08-17 14:04:06.410080 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/db_impl.cc:217] Shutdown: canceling all background work
>     > 2017-08-17 14:04:06.410464 7fcb138f8280  4 rocksdb: [/build/nitin/nightly_builds/20170815_141538-luminous/ceph.git/rpmbuild/BUILD/ceph-12.1.4-12.1.4/src/rocksdb/db/db_impl.cc:343] Shutdown complete
>     > 2017-08-17 14:04:06.451387 7fcb138f8280  1 bluefs umount
>     > 2017-08-17 14:04:06.452720 7fcb138f8280  1 bdev(0x5601f87b3800 /var/lib/ceph/osd/ceph-2/block.wal) close
>     > 2017-08-17 14:04:06.744745 7fcb138f8280  1 bdev(0x5601f87b3400 /var/lib/ceph/osd/ceph-2/block.db) close
>     > 2017-08-17 14:04:06.988729 7fcb138f8280  1 bdev(0x5601f87b3600 /var/lib/ceph/osd/ceph-2/block) close
>     > 2017-08-17 14:04:07.200717 7fcb138f8280  1 bdev(0x5601f87b3200 /var/lib/ceph/osd/ceph-2/block) close
>     > 2017-08-17 14:04:07.448859 7fcb138f8280  1 bluestore(/var/lib/ceph/osd/ceph-2) fsck finish with 1 errors in 23.553470 seconds
>     > fsck found 1 errors
>     > 
>     >     
>     > 
>     > N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay??ʇڙ??j???f???h???????w???????j:+v???w?????????????zZ+???????j"????i
> 
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-402453392-1503524012=:20435--
