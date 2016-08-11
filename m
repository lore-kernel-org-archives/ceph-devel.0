From: Igor Fedotov <ifedotov@mirantis.com>
Subject: potential issue with Bluestore collection_list
Date: Thu, 11 Aug 2016 20:07:57 +0300
Message-ID: <8231b124-5e67-aa5a-98c3-e8a5c5ddaac7@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37584 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcHKRIB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 13:08:01 -0400
Received: by mail-wm0-f50.google.com with SMTP id i5so4133110wmg.0
        for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 10:08:00 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id 205sm696478ljj.47.2016.08.11.10.07.57
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 10:07:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Looks like BlueStore::collection_list method makes my day today :)

While playing with new objectstore fio plugin (see 
https://github.com/ceph/ceph/pull/10267) I observed BlueStore fsck 
reports errors on restart. And completion if properly configured.

After significant test case simplification it appeared that 
BlueStore::fsck detects duplicate nid at the storage. More analysis 
showed that in fact it's Bluestore::collection_list who returned 
duplicate entities.

I have some gaps in my collection/object naming scheme understanding 
hence I can't say definitely if fio assigns collection names properly. 
IMHO it's rather an issue in BlueStore::collection_list.

Here is pretty simple (hopefully) log (2 collections and 2 objects 
total) each showing the case.

IMHO the issue somewhere below the following line:

2016-08-11 18:30:44.595101 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck collection 281474976710656.0_head

where both object keys are reported.

Sage, could you please take a look and comment.


2016-08-11 18:30:43.696717 7fbe78f39780  1 bluestore(./fio-bluestore) 
_open_db opened rocksdb path db options 
compression=kNoCompression,max_write_buffer_number=16,min_write_buffer_number_to_merge=3,recycle_log_file_num=16
2016-08-11 18:30:43.696765 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_super_meta old nid_max 0
2016-08-11 18:30:43.696772 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_super_meta freelist_type extent
2016-08-11 18:30:43.696777 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_super_meta bluefs_extents [8192~1074782208]
2016-08-11 18:30:43.696782 7fbe78f39780  1 freelist init
2016-08-11 18:30:43.696800 7fbe78f39780 20 freelist init 
1074790400~9662627840
2016-08-11 18:30:43.696803 7fbe78f39780 10 freelist init loaded 1 extents
2016-08-11 18:30:43.696810 7fbe78f39780 10 stupidalloc init_add_free 
1074790400~9662627840
2016-08-11 18:30:43.696811 7fbe78f39780 30 stupidalloc _choose_bin len 
9662627840 -> 9
2016-08-11 18:30:43.696812 7fbe78f39780 30 stupidalloc _insert_free 
1074790400~9662627840 in bin 9
2016-08-11 18:30:43.696813 7fbe78f39780 30 stupidalloc _choose_bin len 
9662627840 -> 9
2016-08-11 18:30:43.696813 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_alloc loaded 9215 M in 1 extents
2016-08-11 18:30:43.696827 7fbe78f39780 10 bluestore(./fio-bluestore) 
_reconcile_bluefs_freespace
2016-08-11 18:30:43.696831 7fbe78f39780 10 bluestore(./fio-bluestore) 
_reconcile_bluefs_freespace we agree bluefs has [8192~1074782208]
2016-08-11 18:30:43.696924 7fbe78f39780 10 bluestore(./fio-bluestore) 
_wal_replay start
2016-08-11 18:30:43.696936 7fbe78f39780 20 bluestore(./fio-bluestore) 
_wal_replay flushing osr
2016-08-11 18:30:43.696937 7fbe78f39780 10 bluestore(./fio-bluestore) 
_wal_replay completed 0 events
2016-08-11 18:30:43.696942 7fbe78f39780 10 bluestore(./fio-bluestore) 
_set_csum csum_type crc32c
2016-08-11 18:30:43.696945 7fbe78f39780 10 bluestore(./fio-bluestore) 
_set_compression mode none alg (none)
2016-08-11 18:30:43.696948 7fbe457fa700 10 bluestore(./fio-bluestore) 
_kv_sync_thread start
2016-08-11 18:30:43.696952 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread sleep
2016-08-11 18:30:43.696971 7fbe78f39780 10 bluestore(./fio-bluestore) 
queue_transactions new 0x153d130 osr(job init 0x7ffe5d50d610)
2016-08-11 18:30:43.696977 7fbe78f39780 20 bluestore(./fio-bluestore) 
_txc_create osr 0x153d130 = 0x1523ab0 seq 1
2016-08-11 18:30:43.696983 7fbe78f39780 30 bluestore(./fio-bluestore) 
_txc_add_transaction transaction dump:
{
     "ops": [
         {
             "op_num": 0,
             "op_name": "mkcoll",
             "collection": "281474976710656.0_head"
         },
         {
             "op_num": 1,
             "op_name": "mkcoll",
             "collection": "281474976710656.1_head"
         }
     ]
}

2016-08-11 18:30:43.697022 7fbe78f39780 15 bluestore(./fio-bluestore) 
_create_collection 281474976710656.0_head bits 0
2016-08-11 18:30:43.697037 7fbe78f39780 10 bluestore(./fio-bluestore) 
_create_collection 281474976710656.0_head bits 0 = 0
2016-08-11 18:30:43.697038 7fbe78f39780 15 bluestore(./fio-bluestore) 
_create_collection 281474976710656.1_head bits 0
2016-08-11 18:30:43.697042 7fbe78f39780 10 bluestore(./fio-bluestore) 
_create_collection 281474976710656.1_head bits 0 = 0
2016-08-11 18:30:43.697047 7fbe78f39780 20 bluestore(./fio-bluestore) 
_txc_write_nodes txc 0x1523ab0 onodes bnodes
2016-08-11 18:30:43.697052 7fbe78f39780 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x1523ab0 prepare
2016-08-11 18:30:43.697055 7fbe78f39780 20 bluestore(./fio-bluestore) 
_txc_finish_io 0x1523ab0
2016-08-11 18:30:43.697055 7fbe78f39780 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x1523ab0 io_done
2016-08-11 18:30:43.697112 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread wake
2016-08-11 18:30:43.697115 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread committing 1 cleaning 0
2016-08-11 18:30:43.697117 7fbe457fa700 30 bluestore(./fio-bluestore) 
_kv_sync_thread committing txc <0x1523ab0>
2016-08-11 18:30:43.697118 7fbe457fa700 30 bluestore(./fio-bluestore) 
_kv_sync_thread wal_cleaning txc <>
2016-08-11 18:30:43.697119 7fbe457fa700 10 stupidalloc commit_start 
releasing 0 in extents 0
2016-08-11 18:30:43.697122 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finalize_kv txc 0x1523ab0 allocated 0x[] released 0x[]
2016-08-11 18:30:43.697156 7fbe457fa700 10 bluestore(./fio-bluestore) 
_balance_bluefs_freespace bluefs 1024 M free (1) bluestore 9215 M free 
(0.899902), bluefs_ratio 0.100097
2016-08-11 18:30:43.697181 7fbe457fa700 10 stupidalloc reserve need 
1048576 num_free 130019328 num_reserved 0
2016-08-11 18:30:43.697182 7fbe457fa700 10 stupidalloc allocate 
want_size 1048576 alloc_unit 1048576 hint 0
2016-08-11 18:30:43.697183 7fbe457fa700 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:43.697184 7fbe457fa700 30 stupidalloc allocate got 
5242880~1048576 from bin 9
2016-08-11 18:30:43.697186 7fbe457fa700 30 stupidalloc _choose_bin len 
127926272 -> 9
2016-08-11 18:30:43.697839 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread committed 1 cleaned 0 in 0.000722
2016-08-11 18:30:43.697866 7fbe457fa700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x1523ab0 kv_queued
2016-08-11 18:30:43.697871 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish_kv txc 0x1523ab0
2016-08-11 18:30:43.697897 7fbe457fa700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x1523ab0 finishing
2016-08-11 18:30:43.697900 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish 0x1523ab0 onodes
2016-08-11 18:30:43.697903 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done osr 0x153d130
2016-08-11 18:30:43.697904 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done  txc 0x1523ab0 done
2016-08-11 18:30:43.697908 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done osr 0x153d130 q now empty
2016-08-11 18:30:43.697909 7fbe457fa700 10 stupidalloc commit_finish 
released 0 in extents 0
2016-08-11 18:30:43.697911 7fbe457fa700 10 bluestore(./fio-bluestore) 
_reap_collections all reaped
2016-08-11 18:30:43.697912 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread sleep
2016-08-11 18:30:43.798505 7fbe45ffb700 10 bluestore(./fio-bluestore) 
queue_transactions new 0x7fbe400157a0 osr(281474976710656.0 0x14faa90)
2016-08-11 18:30:43.798542 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_txc_create osr 0x7fbe400157a0 = 0x7fbe40015990 seq 1
2016-08-11 18:30:43.798558 7fbe45ffb700 30 bluestore(./fio-bluestore) 
_txc_add_transaction transaction dump:
{
     "ops": [
         {
             "op_num": 0,
             "op_name": "write",
             "collection": "281474976710656.0_head",
             "oid": 
"#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head#",
             "length": 4096,
             "offset": 0,
             "bufferlist length": 4096
         }
     ]
}

2016-08-11 18:30:43.798618 7fbe45ffb700 30 
bluestore.OnodeSpace(0x1524370 in 0x14eca10) lookup
2016-08-11 18:30:43.798623 7fbe45ffb700 30 
bluestore.OnodeSpace(0x1524370 in 0x14eca10) lookup 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# miss
2016-08-11 18:30:43.798636 7fbe45ffb700 20 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_onode 
oid #281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
key 
'--'0x800100000000000000000000'.!=./fio-bluestore/bluestore.0.0!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:43.798691 7fbe45ffb700 20 
bluestore(./fio-bluestore).collection(281474976710656.0_head)  r -2 v.len 0
2016-08-11 18:30:43.798696 7fbe45ffb700 30 
bluestore.OnodeSpace(0x1524370 in 0x14eca10) add 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
0x7fbe400179e0
2016-08-11 18:30:43.798709 7fbe45ffb700 15 bluestore(./fio-bluestore) 
_write 281474976710656.0_head 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 0x0~1000
2016-08-11 18:30:43.798713 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_assign_nid 1
2016-08-11 18:30:43.798719 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_assign_nid nid_max now 1024
2016-08-11 18:30:43.798722 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
0x0~1000 - have 0x0 (0) bytes in 0 lextents
2016-08-11 18:30:43.798726 7fbe45ffb700 30 bluestore(./fio-bluestore) 
_dump_onode 0x7fbe400179e0 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# nid 
1 size 0x0 (0) expected_object_size 0 expected_write_size 0
2016-08-11 18:30:43.798759 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write prefer csum_order 12 comp_blob_size 0x40000
2016-08-11 18:30:43.798763 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_do_write_small 0x0~1000
2016-08-11 18:30:43.798772 7fbe45ffb700 20 
bluestore.BufferSpace(0x7fbe40018498 in 0x14eca10) _discard 0x0~1000
2016-08-11 18:30:43.798781 7fbe45ffb700 30 bluestore(./fio-bluestore) 
_pad_zeros 0x0~1000 chunk_size 0x1000
2016-08-11 18:30:43.798782 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_pad_zeros pad 0x0 + 0x0 on front/back, now 0x0~1000
2016-08-11 18:30:43.798787 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write_small  lex 0x0: 0x0~1000->1
2016-08-11 18:30:43.798790 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write_small  new 1: 1:blob([] clen 0x0 -> 0)
2016-08-11 18:30:43.798799 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_alloc_write txc 0x7fbe40015990 1 blobs
2016-08-11 18:30:43.798802 7fbe45ffb700 10 stupidalloc reserve need 
65536 num_free 9662627840 num_reserved 0
2016-08-11 18:30:43.798804 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_alloc_write forcing csum_order to block_size_order 12
2016-08-11 18:30:43.798806 7fbe45ffb700 10 stupidalloc allocate 
want_size 65536 alloc_unit 65536 hint 0
2016-08-11 18:30:43.798812 7fbe45ffb700 30 stupidalloc _choose_bin len 
65536 -> 5
2016-08-11 18:30:43.798813 7fbe45ffb700 30 stupidalloc allocate got 
1074790400~65536 from bin 9
2016-08-11 18:30:43.798819 7fbe45ffb700 30 stupidalloc _choose_bin len 
9662562304 -> 9
2016-08-11 18:30:43.798824 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_alloc_write blob 1:blob([0x40100000~10000] clen 0x0 -> 0 mutable) 
csum_order 12 csum_length 0x10000
2016-08-11 18:30:43.798897 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_wctx_finish lex_old []
2016-08-11 18:30:43.798901 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write extending size to 0x1000
2016-08-11 18:30:43.798905 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_write 281474976710656.0_head 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
0x0~1000 = 0
2016-08-11 18:30:43.798912 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_txc_write_nodes txc 0x7fbe40015990 onodes 0x7fbe400179e0 bnodes
2016-08-11 18:30:43.798929 7fbe45ffb700 20 bluestore(./fio-bluestore)   
onode 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# is 145
2016-08-11 18:30:43.798943 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe40015990 prepare
2016-08-11 18:30:43.798947 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_txc_aio_submit txc 0x7fbe40015990
2016-08-11 18:30:43.800139 7fbe45ffb700 10 bluestore(./fio-bluestore) 
queue_transactions new 0x7fbe40019eb0 osr(281474976710656.1 0x14fab10)
2016-08-11 18:30:43.800188 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_txc_create osr 0x7fbe40019eb0 = 0x7fbe4001ba80 seq 1
2016-08-11 18:30:43.800193 7fbe45ffb700 30 bluestore(./fio-bluestore) 
_txc_add_transaction transaction dump:
{
     "ops": [
         {
             "op_num": 0,
             "op_name": "write",
             "collection": "281474976710656.1_head",
             "oid": 
"#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head#",
             "length": 4096,
             "offset": 0,
             "bufferlist length": 4096
         }
     ]
}

2016-08-11 18:30:43.800218 7fbe45ffb700 30 
bluestore.OnodeSpace(0x1524ee0 in 0x14eca10) lookup
2016-08-11 18:30:43.800220 7fbe45ffb700 30 
bluestore.OnodeSpace(0x1524ee0 in 0x14eca10) lookup 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# miss
2016-08-11 18:30:43.800226 7fbe45ffb700 20 
bluestore(./fio-bluestore).collection(281474976710656.1_head) get_onode 
oid #281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
key 
'--'0x800100000000000080000000'.!=./fio-bluestore/bluestore.0.1!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:43.800253 7fbe45ffb700 20 
bluestore(./fio-bluestore).collection(281474976710656.1_head)  r -2 v.len 0
2016-08-11 18:30:43.800276 7fbe45ffb700 30 
bluestore.OnodeSpace(0x1524ee0 in 0x14eca10) add 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
0x7fbe40015320
2016-08-11 18:30:43.800283 7fbe45ffb700 15 bluestore(./fio-bluestore) 
_write 281474976710656.1_head 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 0x0~1000
2016-08-11 18:30:43.800286 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_assign_nid 2
2016-08-11 18:30:43.800287 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
0x0~1000 - have 0x0 (0) bytes in 0 lextents
2016-08-11 18:30:43.800289 7fbe45ffb700 30 bluestore(./fio-bluestore) 
_dump_onode 0x7fbe40015320 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# nid 
2 size 0x0 (0) expected_object_size 0 expected_write_size 0
2016-08-11 18:30:43.800292 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write prefer csum_order 12 comp_blob_size 0x40000
2016-08-11 18:30:43.800293 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_do_write_small 0x0~1000
2016-08-11 18:30:43.800132 7fbe5d657700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe40015990 aio_wait
2016-08-11 18:30:43.800296 7fbe45ffb700 20 
bluestore.BufferSpace(0x7fbe4001ca38 in 0x14eca10) _discard 0x0~1000
2016-08-11 18:30:43.800299 7fbe45ffb700 30 bluestore(./fio-bluestore) 
_pad_zeros 0x0~1000 chunk_size 0x1000
2016-08-11 18:30:43.800300 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_pad_zeros pad 0x0 + 0x0 on front/back, now 0x0~1000
2016-08-11 18:30:43.800301 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write_small  lex 0x0: 0x0~1000->1
2016-08-11 18:30:43.800300 7fbe5d657700 20 bluestore(./fio-bluestore) 
_txc_finish_io 0x7fbe40015990
2016-08-11 18:30:43.800303 7fbe5d657700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe40015990 io_done
2016-08-11 18:30:43.800303 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write_small  new 1: 1:blob([] clen 0x0 -> 0)
2016-08-11 18:30:43.800311 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_alloc_write txc 0x7fbe4001ba80 1 blobs
2016-08-11 18:30:43.800313 7fbe45ffb700 10 stupidalloc reserve need 
65536 num_free 9662562304 num_reserved 0
2016-08-11 18:30:43.800314 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_alloc_write forcing csum_order to block_size_order 12
2016-08-11 18:30:43.800312 7fbe5d657700 20 
bluestore.BufferSpace(0x7fbe40018498 in 0x14eca10) finish_write 
buffer(0x7fbe40018510 space 0x7fbe40018498 0x0~1000 writing nocache)
2016-08-11 18:30:43.800315 7fbe45ffb700 10 stupidalloc allocate 
want_size 65536 alloc_unit 65536 hint 0
2016-08-11 18:30:43.800317 7fbe45ffb700 30 stupidalloc _choose_bin len 
65536 -> 5
2016-08-11 18:30:43.800318 7fbe45ffb700 30 stupidalloc allocate got 
1074855936~65536 from bin 9
2016-08-11 18:30:43.800321 7fbe45ffb700 30 stupidalloc _choose_bin len 
9662496768 -> 9
2016-08-11 18:30:43.800323 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_alloc_write blob 1:blob([0x40110000~10000] clen 0x0 -> 0 mutable) 
csum_order 12 csum_length 0x10000
2016-08-11 18:30:43.800330 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread wake
2016-08-11 18:30:43.800331 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread committing 1 cleaning 0
2016-08-11 18:30:43.800333 7fbe457fa700 30 bluestore(./fio-bluestore) 
_kv_sync_thread committing txc <0x7fbe40015990>
2016-08-11 18:30:43.800333 7fbe457fa700 30 bluestore(./fio-bluestore) 
_kv_sync_thread wal_cleaning txc <>
2016-08-11 18:30:43.800334 7fbe457fa700 10 stupidalloc commit_start 
releasing 0 in extents 0
2016-08-11 18:30:43.800339 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_wctx_finish lex_old []
2016-08-11 18:30:43.800341 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_do_write extending size to 0x1000
2016-08-11 18:30:43.800342 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_write 281474976710656.1_head 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
0x0~1000 = 0
2016-08-11 18:30:43.800346 7fbe45ffb700 20 bluestore(./fio-bluestore) 
_txc_write_nodes txc 0x7fbe4001ba80 onodes 0x7fbe40015320 bnodes
2016-08-11 18:30:43.800354 7fbe45ffb700 20 bluestore(./fio-bluestore)   
onode 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# is 145
2016-08-11 18:30:43.800363 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe4001ba80 prepare
2016-08-11 18:30:43.800365 7fbe45ffb700 10 bluestore(./fio-bluestore) 
_txc_aio_submit txc 0x7fbe4001ba80
2016-08-11 18:30:43.801290 7fbe5d657700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe4001ba80 aio_wait
2016-08-11 18:30:43.801319 7fbe5d657700 20 bluestore(./fio-bluestore) 
_txc_finish_io 0x7fbe4001ba80
2016-08-11 18:30:43.801322 7fbe5d657700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe4001ba80 io_done
2016-08-11 18:30:43.801353 7fbe5d657700 20 
bluestore.BufferSpace(0x7fbe4001ca38 in 0x14eca10) finish_write 
buffer(0x7fbe400154e0 space 0x7fbe4001ca38 0x0~1000 writing nocache)
2016-08-11 18:30:43.801367 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finalize_kv txc 0x7fbe40015990 allocated 0x[40100000~10000] 
released 0x[]
2016-08-11 18:30:43.801371 7fbe457fa700 10 freelist allocate 
1074790400~65536
2016-08-11 18:30:43.801376 7fbe457fa700 20 freelist allocate  rm 
1074790400~9662627840
2016-08-11 18:30:43.801381 7fbe457fa700 20 freelist allocate  set 
1074855936~9662562304 (remaining tail)
2016-08-11 18:30:43.801425 7fbe457fa700 10 bluestore(./fio-bluestore) 
_balance_bluefs_freespace bluefs 1024 M free (1) bluestore 9214 M free 
(0.89989), bluefs_ratio 0.100098
2016-08-11 18:30:43.802538 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread committed 1 cleaned 0 in 0.002204
2016-08-11 18:30:43.802567 7fbe457fa700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe40015990 kv_queued
2016-08-11 18:30:43.802570 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish_kv txc 0x7fbe40015990
2016-08-11 18:30:43.802596 7fbe457fa700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe40015990 finishing
2016-08-11 18:30:43.802598 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish 0x7fbe40015990 onodes 0x7fbe400179e0
2016-08-11 18:30:43.802599 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish onode 0x7fbe400179e0 had 0x7fbe40015990
2016-08-11 18:30:43.802608 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done osr 0x7fbe400157a0
2016-08-11 18:30:43.802608 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done  txc 0x7fbe40015990 done
2016-08-11 18:30:43.802613 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done osr 0x7fbe400157a0 q now empty
2016-08-11 18:30:43.802615 7fbe457fa700 20 bluestore.2QCache(0x14eca10) 
trim onodes 2 / 16384 buffers 0 / 536870912
2016-08-11 18:30:43.802616 7fbe457fa700 10 stupidalloc commit_finish 
released 0 in extents 0
2016-08-11 18:30:43.802619 7fbe457fa700 10 bluestore(./fio-bluestore) 
_reap_collections all reaped
2016-08-11 18:30:43.802620 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread committing 1 cleaning 0
2016-08-11 18:30:43.802621 7fbe457fa700 30 bluestore(./fio-bluestore) 
_kv_sync_thread committing txc <0x7fbe4001ba80>
2016-08-11 18:30:43.802621 7fbe457fa700 30 bluestore(./fio-bluestore) 
_kv_sync_thread wal_cleaning txc <>
2016-08-11 18:30:43.802622 7fbe457fa700 10 stupidalloc commit_start 
releasing 0 in extents 0
2016-08-11 18:30:43.802626 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finalize_kv txc 0x7fbe4001ba80 allocated 0x[40110000~10000] 
released 0x[]
2016-08-11 18:30:43.802628 7fbe457fa700 10 freelist allocate 
1074855936~65536
2016-08-11 18:30:43.802632 7fbe457fa700 20 freelist allocate  rm 
1074855936~9662562304
2016-08-11 18:30:43.802634 7fbe457fa700 20 freelist allocate  set 
1074921472~9662496768 (remaining tail)
2016-08-11 18:30:43.802651 7fbe457fa700 10 bluestore(./fio-bluestore) 
_balance_bluefs_freespace bluefs 1024 M free (1) bluestore 9214 M free 
(0.89989), bluefs_ratio 0.100098
2016-08-11 18:30:43.803495 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread committed 1 cleaned 0 in 0.000872
2016-08-11 18:30:43.803527 7fbe457fa700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe4001ba80 kv_queued
2016-08-11 18:30:43.803530 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish_kv txc 0x7fbe4001ba80
2016-08-11 18:30:43.803553 7fbe457fa700 10 bluestore(./fio-bluestore) 
_txc_state_proc txc 0x7fbe4001ba80 finishing
2016-08-11 18:30:43.803555 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish 0x7fbe4001ba80 onodes 0x7fbe40015320
2016-08-11 18:30:43.803556 7fbe457fa700 20 bluestore(./fio-bluestore) 
_txc_finish onode 0x7fbe40015320 had 0x7fbe4001ba80
2016-08-11 18:30:43.803560 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done osr 0x7fbe40019eb0
2016-08-11 18:30:43.803560 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done  txc 0x7fbe4001ba80 done
2016-08-11 18:30:43.803565 7fbe457fa700 20 bluestore(./fio-bluestore) 
_osr_reap_done osr 0x7fbe40019eb0 q now empty
2016-08-11 18:30:43.803566 7fbe457fa700 20 bluestore.2QCache(0x14eca10) 
trim onodes 2 / 16384 buffers 0 / 536870912
2016-08-11 18:30:43.803568 7fbe457fa700 10 stupidalloc commit_finish 
released 0 in extents 0
2016-08-11 18:30:43.803570 7fbe457fa700 10 bluestore(./fio-bluestore) 
_reap_collections all reaped
2016-08-11 18:30:43.803571 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread sleep
2016-08-11 18:30:43.819677 7fbe78f39780  1 bluestore(./fio-bluestore) umount
2016-08-11 18:30:43.819710 7fbe78f39780 10 bluestore(./fio-bluestore) _sync
2016-08-11 18:30:43.819713 7fbe78f39780 10 bluestore(./fio-bluestore) 
_sync done
2016-08-11 18:30:43.819714 7fbe78f39780 10 bluestore(./fio-bluestore) 
_reap_collections all reaped
2016-08-11 18:30:43.819718 7fbe78f39780 10 
bluestore.OnodeSpace(0x1524ee0 in 0x14eca10) clear
2016-08-11 18:30:43.819722 7fbe78f39780 10 
bluestore.BufferSpace(0x7fbe4001ca38 in 0x14eca10) _clear
2016-08-11 18:30:43.819738 7fbe78f39780 10 
bluestore.OnodeSpace(0x1524370 in 0x14eca10) clear
2016-08-11 18:30:43.819739 7fbe78f39780 10 
bluestore.BufferSpace(0x7fbe40018498 in 0x14eca10) _clear
2016-08-11 18:30:43.819742 7fbe78f39780 20 bluestore(./fio-bluestore) 
umount stopping kv thread
2016-08-11 18:30:43.819752 7fbe457fa700 20 bluestore(./fio-bluestore) 
_kv_sync_thread wake
2016-08-11 18:30:43.819754 7fbe457fa700 10 bluestore(./fio-bluestore) 
_kv_sync_thread finish
2016-08-11 18:30:43.819772 7fbe78f39780 20 bluestore(./fio-bluestore) 
umount draining wal_wq
2016-08-11 18:30:43.819776 7fbe78f39780 20 bluestore(./fio-bluestore) 
umount stopping wal_tp
2016-08-11 18:30:43.819785 7fbe78f39780 20 bluestore(./fio-bluestore) 
umount draining finisher
2016-08-11 18:30:43.819787 7fbe78f39780 20 bluestore(./fio-bluestore) 
umount stopping finisher
2016-08-11 18:30:43.819842 7fbe78f39780 20 bluestore(./fio-bluestore) 
umount closing
2016-08-11 18:30:43.819865 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:43.819869 7fbe78f39780 10 bluestore(./fio-bluestore) 
_close_fm
2016-08-11 18:30:43.819870 7fbe78f39780  1 freelist shutdown
2016-08-11 18:30:43.819971 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:43.819995 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:43.819997 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:44.578577 7fbe78f39780  1 bluestore(./fio-bluestore) fsck
2016-08-11 18:30:44.579090 7fbe78f39780 10 
bluestore(./fio-bluestore/block) _read_bdev_label
2016-08-11 18:30:44.579139 7fbe78f39780 10 
bluestore(./fio-bluestore/block) _read_bdev_label got bdev(osd_uuid 
63bb2279-5f98-4363-8420-a2058a3914b7 size 0x280000000 btime 2016-08-11 
18:30:39.898486 desc main)
2016-08-11 18:30:44.579152 7fbe78f39780 10 bluestore(./fio-bluestore) 
_set_alloc_sizes min_alloc_size 0x10000 order 16 max_alloc_size 0x0
2016-08-11 18:30:44.579166 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_db kv_backend = rocksdb
2016-08-11 18:30:44.579173 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_db bluefs = 0
2016-08-11 18:30:44.579174 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_db initializing bluefs
2016-08-11 18:30:44.579541 7fbe78f39780 10 
bluestore(./fio-bluestore/block.db) _read_bdev_label
2016-08-11 18:30:44.579587 7fbe78f39780 10 
bluestore(./fio-bluestore/block.db) _read_bdev_label got bdev(osd_uuid 
63bb2279-5f98-4363-8420-a2058a3914b7 size 0x4000000 btime 2016-08-11 
18:30:39.899538 desc bluefs db)
2016-08-11 18:30:44.580675 7fbe78f39780 10 
bluestore(./fio-bluestore/block.wal) _read_bdev_label
2016-08-11 18:30:44.580913 7fbe78f39780 10 
bluestore(./fio-bluestore/block.wal) _read_bdev_label got bdev(osd_uuid 
63bb2279-5f98-4363-8420-a2058a3914b7 size 0x8000000 btime 2016-08-11 
18:30:39.901095 desc bluefs wal)
2016-08-11 18:30:44.582179 7fbe78f39780 10 stupidalloc init_add_free 
4096~134213632
2016-08-11 18:30:44.582214 7fbe78f39780 30 stupidalloc _choose_bin len 
134213632 -> 9
2016-08-11 18:30:44.582217 7fbe78f39780 30 stupidalloc _insert_free 
4096~134213632 in bin 9
2016-08-11 18:30:44.582220 7fbe78f39780 30 stupidalloc _choose_bin len 
134213632 -> 9
2016-08-11 18:30:44.582221 7fbe78f39780 10 stupidalloc init_add_free 
8192~67100672
2016-08-11 18:30:44.582222 7fbe78f39780 30 stupidalloc _choose_bin len 
67100672 -> 9
2016-08-11 18:30:44.582223 7fbe78f39780 30 stupidalloc _insert_free 
8192~67100672 in bin 9
2016-08-11 18:30:44.582223 7fbe78f39780 30 stupidalloc _choose_bin len 
67100672 -> 9
2016-08-11 18:30:44.582224 7fbe78f39780 10 stupidalloc init_add_free 
8192~1074782208
2016-08-11 18:30:44.582225 7fbe78f39780 30 stupidalloc _choose_bin len 
1074782208 -> 9
2016-08-11 18:30:44.582225 7fbe78f39780 30 stupidalloc _insert_free 
8192~1074782208 in bin 9
2016-08-11 18:30:44.582226 7fbe78f39780 30 stupidalloc _choose_bin len 
1074782208 -> 9
2016-08-11 18:30:44.582360 7fbe78f39780 10 stupidalloc init_rm_free 
6291456~1048576
2016-08-11 18:30:44.582384 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [6291456~1048576]
2016-08-11 18:30:44.582389 7fbe78f39780 10 stupidalloc init_rm_free 
5242880~1048576
2016-08-11 18:30:44.582390 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [5242880~1048576]
2016-08-11 18:30:44.582391 7fbe78f39780 10 stupidalloc init_rm_free 
2097152~1048576
2016-08-11 18:30:44.582392 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [2097152~1048576]
2016-08-11 18:30:44.582394 7fbe78f39780 10 stupidalloc init_rm_free 
1048576~4194304
2016-08-11 18:30:44.582394 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [1048576~4194304]
2016-08-11 18:30:44.582395 7fbe78f39780 10 stupidalloc init_rm_free 
8388608~1048576
2016-08-11 18:30:44.582396 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [8388608~1048576]
2016-08-11 18:30:44.582396 7fbe78f39780 10 stupidalloc init_rm_free 
1048576~1048576
2016-08-11 18:30:44.582397 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [1048576~1048576]
2016-08-11 18:30:44.582398 7fbe78f39780 10 stupidalloc init_rm_free 
3145728~1048576
2016-08-11 18:30:44.582398 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [3145728~1048576]
2016-08-11 18:30:44.582399 7fbe78f39780 10 stupidalloc init_rm_free 
5242880~1048576
2016-08-11 18:30:44.582399 7fbe78f39780 20 stupidalloc init_rm_free bin 
9 rm [5242880~1048576]
2016-08-11 18:30:44.582426 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_db set rocksdb_db_paths to db,63753420 db.slow,10200547328
2016-08-11 18:30:44.582432 7fbe78f39780 -1 WARNING: experimental feature 
'rocksdb' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2016-08-11 18:30:44.582472 7fbe78f39780  0  set rocksdb option 
compression = kNoCompression
2016-08-11 18:30:44.582507 7fbe78f39780  0  set rocksdb option 
max_write_buffer_number = 16
2016-08-11 18:30:44.582511 7fbe78f39780  0  set rocksdb option 
min_write_buffer_number_to_merge = 3
2016-08-11 18:30:44.582515 7fbe78f39780  0  set rocksdb option 
recycle_log_file_num = 16
2016-08-11 18:30:44.582536 7fbe78f39780  0  set rocksdb option 
compression = kNoCompression
2016-08-11 18:30:44.582562 7fbe78f39780  0  set rocksdb option 
max_write_buffer_number = 16
2016-08-11 18:30:44.582566 7fbe78f39780  0  set rocksdb option 
min_write_buffer_number_to_merge = 3
2016-08-11 18:30:44.582568 7fbe78f39780  0  set rocksdb option 
recycle_log_file_num = 16
2016-08-11 18:30:44.586297 7fbe78f39780 10 stupidalloc reserve need 
1048576 num_free 60809216 num_reserved 0
2016-08-11 18:30:44.586354 7fbe78f39780 10 stupidalloc allocate 
want_size 1048576 alloc_unit 1048576 hint 0
2016-08-11 18:30:44.586358 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.586360 7fbe78f39780 30 stupidalloc allocate got 
4194304~1048576 from bin 9
2016-08-11 18:30:44.588512 7fbe78f39780 10 stupidalloc reserve need 
1048576 num_free 59760640 num_reserved 0
2016-08-11 18:30:44.588540 7fbe78f39780 10 stupidalloc allocate 
want_size 1048576 alloc_unit 1048576 hint 0
2016-08-11 18:30:44.588542 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.588544 7fbe78f39780 30 stupidalloc allocate got 
7340032~1048576 from bin 9
2016-08-11 18:30:44.589563 7fbe78f39780 10 stupidalloc reserve need 
1048576 num_free 58712064 num_reserved 0
2016-08-11 18:30:44.589589 7fbe78f39780 10 stupidalloc allocate 
want_size 1048576 alloc_unit 1048576 hint 0
2016-08-11 18:30:44.589591 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.589593 7fbe78f39780 30 stupidalloc allocate got 
9437184~1048576 from bin 9
2016-08-11 18:30:44.589595 7fbe78f39780 30 stupidalloc _choose_bin len 
56623104 -> 9
2016-08-11 18:30:44.591260 7fbe78f39780 10 stupidalloc release 
2097152~1048576
2016-08-11 18:30:44.591357 7fbe78f39780 10 stupidalloc release 
5242880~1048576
2016-08-11 18:30:44.591391 7fbe78f39780 10 stupidalloc release 
1048576~1048576
2016-08-11 18:30:44.591398 7fbe78f39780 10 stupidalloc commit_start 
releasing 1048576 in extents 1
2016-08-11 18:30:44.591400 7fbe78f39780 10 stupidalloc commit_start 
releasing 2097152 in extents 1
2016-08-11 18:30:44.591400 7fbe78f39780 10 stupidalloc commit_start 
releasing 0 in extents 0
2016-08-11 18:30:44.592024 7fbe78f39780 10 stupidalloc commit_finish 
released 1048576 in extents 1
2016-08-11 18:30:44.592049 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.592051 7fbe78f39780 30 stupidalloc _insert_free 
5242880~1048576 in bin 9
2016-08-11 18:30:44.592053 7fbe78f39780 30 stupidalloc _choose_bin len 
128974848 -> 9
2016-08-11 18:30:44.592054 7fbe78f39780 10 stupidalloc commit_finish 
released 2097152 in extents 1
2016-08-11 18:30:44.592054 7fbe78f39780 30 stupidalloc _choose_bin len 
2097152 -> 9
2016-08-11 18:30:44.592055 7fbe78f39780 30 stupidalloc _insert_free 
1048576~2097152 in bin 9
2016-08-11 18:30:44.592055 7fbe78f39780 30 stupidalloc _choose_bin len 
3137536 -> 9
2016-08-11 18:30:44.592056 7fbe78f39780 10 stupidalloc commit_finish 
released 0 in extents 0
2016-08-11 18:30:44.592138 7fbe78f39780 10 stupidalloc reserve need 
1048576 num_free 59760640 num_reserved 0
2016-08-11 18:30:44.592163 7fbe78f39780 10 stupidalloc allocate 
want_size 1048576 alloc_unit 1048576 hint 0
2016-08-11 18:30:44.592165 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.592166 7fbe78f39780 30 stupidalloc allocate got 
10485760~1048576 from bin 9
2016-08-11 18:30:44.592167 7fbe78f39780 30 stupidalloc _choose_bin len 
55574528 -> 9
2016-08-11 18:30:44.594443 7fbe78f39780 10 stupidalloc release 
8388608~1048576
2016-08-11 18:30:44.594498 7fbe78f39780  1 bluestore(./fio-bluestore) 
_open_db opened rocksdb path db options 
compression=kNoCompression,max_write_buffer_number=16,min_write_buffer_number_to_merge=3,recycle_log_file_num=16
2016-08-11 18:30:44.594539 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_super_meta old nid_max 1024
2016-08-11 18:30:44.594585 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_super_meta freelist_type extent
2016-08-11 18:30:44.594594 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_super_meta bluefs_extents [8192~1074782208]
2016-08-11 18:30:44.594627 7fbe78f39780  1 freelist init
2016-08-11 18:30:44.594663 7fbe78f39780 20 freelist init 
1074921472~9662496768
2016-08-11 18:30:44.594690 7fbe78f39780 10 freelist init loaded 1 extents
2016-08-11 18:30:44.594702 7fbe78f39780 10 stupidalloc init_add_free 
1074921472~9662496768
2016-08-11 18:30:44.594703 7fbe78f39780 30 stupidalloc _choose_bin len 
9662496768 -> 9
2016-08-11 18:30:44.594705 7fbe78f39780 30 stupidalloc _insert_free 
1074921472~9662496768 in bin 9
2016-08-11 18:30:44.594706 7fbe78f39780 30 stupidalloc _choose_bin len 
9662496768 -> 9
2016-08-11 18:30:44.594706 7fbe78f39780 10 bluestore(./fio-bluestore) 
_open_alloc loaded 9214 M in 1 extents
2016-08-11 18:30:44.594739 7fbe78f39780 20 bluestore(./fio-bluestore) 
_open_collections opened 281474976710656.0_head
2016-08-11 18:30:44.594774 7fbe78f39780 20 bluestore(./fio-bluestore) 
_open_collections opened 281474976710656.1_head
2016-08-11 18:30:44.594929 7fbe78f39780 20 bluestore(./fio-bluestore) 
statfs store_statfs(0x1ffde2000/0x280000000, stored 0x2000/0x20000, 
compress 0x0/0x0/0x0)
2016-08-11 18:30:44.594955 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck collection 281474976710656.1_head
2016-08-11 18:30:44.594963 7fbe78f39780 15 bluestore(./fio-bluestore) 
collection_list 281474976710656.1_head start GHMIN end GHMAX max 100
2016-08-11 18:30:44.594971 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list range '--'0x7ffefffffffffffe80000000'.' to 
'--'0x7ffefffffffffffeffffffff':' and '--'0x800100000000000080000000'.' 
to '--'0x8001000000000000ffffffff':' start GHMIN
2016-08-11 18:30:44.594986 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list pend '--'0x7ffefffffffffffeffffffff':'
2016-08-11 18:30:44.594989 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list key 
'--'0x800100000000000000000000'.!=./fio-bluestore/bluestore.0.0!'0xfffffffffffffffeffffffffffffffff 
 > GHMAX
2016-08-11 18:30:44.594992 7fbe78f39780 30 bluestore(./fio-bluestore) 
collection_list switch to non-temp namespace
2016-08-11 18:30:44.594994 7fbe78f39780 30 bluestore(./fio-bluestore) 
collection_list pend '--'0x8001000000000000ffffffff':'
2016-08-11 18:30:44.594996 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list key 
'--'0x800100000000000080000000'.!=./fio-bluestore/bluestore.0.1!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:44.595002 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list iterator not valid (end of db?)
2016-08-11 18:30:44.595004 7fbe78f39780 20 bluestore.2QCache(0x14eca10) 
trim onodes 0 / 16384 buffers 0 / 536870912
2016-08-11 18:30:44.595006 7fbe78f39780 10 bluestore(./fio-bluestore) 
collection_list 281474976710656.1_head start GHMIN end GHMAX max 100 = 
0, ls.size() = 1, next = GHMAX
2016-08-11 18:30:44.595010 7fbe78f39780 30 
bluestore.OnodeSpace(0x1501e80 in 0x14eca10) lookup
2016-08-11 18:30:44.595012 7fbe78f39780 30 
bluestore.OnodeSpace(0x1501e80 in 0x14eca10) lookup 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# miss
2016-08-11 18:30:44.595018 7fbe78f39780 20 
bluestore(./fio-bluestore).collection(281474976710656.1_head) get_onode 
oid #281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
key 
'--'0x800100000000000080000000'.!=./fio-bluestore/bluestore.0.1!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:44.595026 7fbe78f39780 20 
bluestore(./fio-bluestore).collection(281474976710656.1_head)  r 0 v.len 145
2016-08-11 18:30:44.595042 7fbe78f39780 30 
bluestore.OnodeSpace(0x1501e80 in 0x14eca10) add 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
0x1502540
2016-08-11 18:30:44.595049 7fbe78f39780 10 
bluestore(./fio-bluestore).collection(281474976710656.1_head) get_bnode 
hash 1 created 0x15239d0
2016-08-11 18:30:44.595055 7fbe78f39780 10 
bluestore(./fio-bluestore).collection(281474976710656.1_head) get_bnode 
hash 1 missed, new blob_map
2016-08-11 18:30:44.595057 7fbe78f39780 10 bluestore(./fio-bluestore) 
fsck #281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head#
2016-08-11 18:30:44.595059 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_onode 0x1502540 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# nid 
2 size 0x1000 (4096) expected_object_size 0 expected_write_size 0
2016-08-11 18:30:44.595062 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_onode  lextent 0x0: 0x0~1000->1
2016-08-11 18:30:44.595063 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_blob_map 1:blob([0x40110000~10000] clen 0x0 -> 0 
mutable+csum+has_unused crc32c/0x1000 unused=0xfffe)
2016-08-11 18:30:44.595076 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_blob_map       csum: [2d2a1cba,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
2016-08-11 18:30:44.595091 7fbe78f39780 20 bluestore(./fio-bluestore) 
_fsck_verify_blob_map object 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
{1=ref_map(0x0~1000=1)}
2016-08-11 18:30:44.595097 7fbe78f39780 15 bluestore(./fio-bluestore) 
collection_list 281474976710656.1_head start GHMAX end GHMAX max 100
2016-08-11 18:30:44.595099 7fbe78f39780 20 bluestore.2QCache(0x14eca10) 
trim onodes 1 / 16384 buffers 0 / 536870912
2016-08-11 18:30:44.595100 7fbe78f39780 10 bluestore(./fio-bluestore) 
collection_list 281474976710656.1_head start GHMAX end GHMAX max 100 = 
0, ls.size() = 0, next = GHMAX
2016-08-11 18:30:44.595101 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck collection 281474976710656.0_head
2016-08-11 18:30:44.595102 7fbe78f39780 15 bluestore(./fio-bluestore) 
collection_list 281474976710656.0_head start GHMIN end GHMAX max 100
2016-08-11 18:30:44.595104 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list range '--'0x7ffefffffffffffe00000000'.' to 
'--'0x7ffefffffffffffeffffffff':' and '--'0x800100000000000000000000'.' 
to '--'0x8001000000000000ffffffff':' start GHMIN
2016-08-11 18:30:44.595115 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list pend '--'0x7ffefffffffffffeffffffff':'
2016-08-11 18:30:44.595117 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list key 
'--'0x800100000000000000000000'.!=./fio-bluestore/bluestore.0.0!'0xfffffffffffffffeffffffffffffffff 
 > GHMAX
2016-08-11 18:30:44.595119 7fbe78f39780 30 bluestore(./fio-bluestore) 
collection_list switch to non-temp namespace
2016-08-11 18:30:44.595122 7fbe78f39780 30 bluestore(./fio-bluestore) 
collection_list pend '--'0x8001000000000000ffffffff':'
2016-08-11 18:30:44.595123 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list key 
'--'0x800100000000000000000000'.!=./fio-bluestore/bluestore.0.0!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:44.595127 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list key 
'--'0x800100000000000080000000'.!=./fio-bluestore/bluestore.0.1!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:44.595131 7fbe78f39780 20 bluestore(./fio-bluestore) 
collection_list iterator not valid (end of db?)
2016-08-11 18:30:44.595132 7fbe78f39780 20 bluestore.2QCache(0x14eca10) 
trim onodes 1 / 16384 buffers 0 / 536870912
2016-08-11 18:30:44.595132 7fbe78f39780 10 bluestore(./fio-bluestore) 
collection_list 281474976710656.0_head start GHMIN end GHMAX max 100 = 
0, ls.size() = 2, next = GHMAX
2016-08-11 18:30:44.595136 7fbe78f39780 30 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) lookup
2016-08-11 18:30:44.595137 7fbe78f39780 30 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) lookup 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# miss
2016-08-11 18:30:44.595140 7fbe78f39780 20 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_onode 
oid #281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
key 
'--'0x800100000000000000000000'.!=./fio-bluestore/bluestore.0.0!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:44.595147 7fbe78f39780 20 
bluestore(./fio-bluestore).collection(281474976710656.0_head)  r 0 v.len 145
2016-08-11 18:30:44.595151 7fbe78f39780 30 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) add 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
0x151f6c0
2016-08-11 18:30:44.595156 7fbe78f39780 20 bluestore(./fio-bluestore) 
_fsck_verify_blob_map hash 1 {}
2016-08-11 18:30:44.595158 7fbe78f39780 10 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_bnode 
hash 0 created 0x14fe7d0
2016-08-11 18:30:44.595162 7fbe78f39780 10 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_bnode 
hash 0 missed, new blob_map
2016-08-11 18:30:44.595164 7fbe78f39780 20 bluestore.bnode(0x15239d0) 
put removing self from set 0x1501dd0
2016-08-11 18:30:44.595165 7fbe78f39780 10 bluestore(./fio-bluestore) 
fsck #281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head#
2016-08-11 18:30:44.595167 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_onode 0x151f6c0 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# nid 
1 size 0x1000 (4096) expected_object_size 0 expected_write_size 0
2016-08-11 18:30:44.595169 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_onode  lextent 0x0: 0x0~1000->1
2016-08-11 18:30:44.595170 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_blob_map 1:blob([0x40100000~10000] clen 0x0 -> 0 
mutable+csum+has_unused crc32c/0x1000 unused=0xfffe)
2016-08-11 18:30:44.595172 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_blob_map       csum: [b084ab76,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
2016-08-11 18:30:44.595176 7fbe78f39780 20 bluestore(./fio-bluestore) 
_fsck_verify_blob_map object 
#281474976710656:00000000:::.%2ffio-bluestore%2fbluestore.0.0:head# 
{1=ref_map(0x0~1000=1)}
2016-08-11 18:30:44.595178 7fbe78f39780 30 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) lookup
2016-08-11 18:30:44.595179 7fbe78f39780 30 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) lookup 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# miss
2016-08-11 18:30:44.595182 7fbe78f39780 20 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_onode 
oid #281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
key 
'--'0x800100000000000080000000'.!=./fio-bluestore/bluestore.0.1!'0xfffffffffffffffeffffffffffffffff
2016-08-11 18:30:44.595189 7fbe78f39780 20 
bluestore(./fio-bluestore).collection(281474976710656.0_head)  r 0 v.len 145
2016-08-11 18:30:44.595191 7fbe78f39780 30 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) add 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# 
0x1528170
2016-08-11 18:30:44.595194 7fbe78f39780 20 bluestore(./fio-bluestore) 
_fsck_verify_blob_map hash 0 {}
2016-08-11 18:30:44.595196 7fbe78f39780 10 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_bnode 
hash 1 created 0x15239d0
2016-08-11 18:30:44.595199 7fbe78f39780 10 
bluestore(./fio-bluestore).collection(281474976710656.0_head) get_bnode 
hash 1 missed, new blob_map
2016-08-11 18:30:44.595200 7fbe78f39780 20 bluestore.bnode(0x14fe7d0) 
put removing self from set 0x14f6830
2016-08-11 18:30:44.595201 7fbe78f39780 10 bluestore(./fio-bluestore) 
fsck #281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head#
2016-08-11 18:30:44.595203 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_onode 0x1528170 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# nid 
2 size 0x1000 (4096) expected_object_size 0 expected_write_size 0
2016-08-11 18:30:44.595205 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_onode  lextent 0x0: 0x0~1000->1
2016-08-11 18:30:44.595206 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_blob_map 1:blob([0x40110000~10000] clen 0x0 -> 0 
mutable+csum+has_unused crc32c/0x1000 unused=0xfffe)
2016-08-11 18:30:44.595207 7fbe78f39780 30 bluestore(./fio-bluestore) 
_dump_blob_map       csum: [2d2a1cba,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
2016-08-11 18:30:44.595209 7fbe78f39780 -1 bluestore(./fio-bluestore) 
#281474976710656:80000000:::.%2ffio-bluestore%2fbluestore.0.1:head# nid 
2 already in use
2016-08-11 18:30:44.595212 7fbe78f39780 15 bluestore(./fio-bluestore) 
collection_list 281474976710656.0_head start GHMAX end GHMAX max 100
2016-08-11 18:30:44.595213 7fbe78f39780 20 bluestore.2QCache(0x14eca10) 
trim onodes 3 / 16384 buffers 0 / 536870912
2016-08-11 18:30:44.595214 7fbe78f39780 10 bluestore(./fio-bluestore) 
collection_list 281474976710656.0_head start GHMAX end GHMAX max 100 = 
0, ls.size() = 0, next = GHMAX
2016-08-11 18:30:44.595219 7fbe78f39780 20 bluestore(./fio-bluestore) 
_fsck_verify_blob_map hash 1 {}
2016-08-11 18:30:44.595220 7fbe78f39780 20 bluestore.bnode(0x15239d0) 
put removing self from set 0x14f6830
2016-08-11 18:30:44.595221 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck checking for stray bnodes and onodes
2016-08-11 18:30:44.595232 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck checking for stray omap data
2016-08-11 18:30:44.595238 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck checking wal events
2016-08-11 18:30:44.595243 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck checking freelist vs allocated
2016-08-11 18:30:44.596746 7fbe78f39780 10 
bluestore.OnodeSpace(0x1501e80 in 0x14eca10) clear
2016-08-11 18:30:44.596778 7fbe78f39780 10 
bluestore.BufferSpace(0x1502798 in 0x14eca10) _clear
2016-08-11 18:30:44.596788 7fbe78f39780 10 
bluestore.OnodeSpace(0x14f68e0 in 0x14eca10) clear
2016-08-11 18:30:44.596789 7fbe78f39780 10 
bluestore.BufferSpace(0x15283c8 in 0x14eca10) _clear
2016-08-11 18:30:44.596790 7fbe78f39780 10 
bluestore.BufferSpace(0x151f918 in 0x14eca10) _clear
2016-08-11 18:30:44.596795 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:44.596798 7fbe78f39780 10 bluestore(./fio-bluestore) 
_close_fm
2016-08-11 18:30:44.596800 7fbe78f39780  1 freelist shutdown
2016-08-11 18:30:44.596966 7fbe78f39780 10 stupidalloc commit_start 
releasing 0 in extents 0
2016-08-11 18:30:44.596970 7fbe78f39780 10 stupidalloc commit_start 
releasing 1048576 in extents 1
2016-08-11 18:30:44.596970 7fbe78f39780 10 stupidalloc commit_start 
releasing 0 in extents 0
2016-08-11 18:30:44.597856 7fbe78f39780 10 stupidalloc commit_finish 
released 0 in extents 0
2016-08-11 18:30:44.597883 7fbe78f39780 10 stupidalloc commit_finish 
released 1048576 in extents 1
2016-08-11 18:30:44.597886 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.597887 7fbe78f39780 30 stupidalloc _insert_free 
8388608~1048576 in bin 9
2016-08-11 18:30:44.597889 7fbe78f39780 30 stupidalloc _choose_bin len 
1048576 -> 9
2016-08-11 18:30:44.597890 7fbe78f39780 10 stupidalloc commit_finish 
released 0 in extents 0
2016-08-11 18:30:44.597893 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:44.597894 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:44.597894 7fbe78f39780  1 stupidalloc shutdown
2016-08-11 18:30:45.594058 7fbe78f39780  1 bluestore(./fio-bluestore) 
fsck finish with 1 errors
2016-08-11 18:30:45.594073 7fbe78f39780 -1 bluestore(./fio-bluestore) 
umount fsck found 1 errors

