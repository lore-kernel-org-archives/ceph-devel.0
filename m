From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: rocksdb report bluestore corruption
Date: Sun, 6 Aug 2017 23:08:34 +0800
Message-ID: <CAEYCsVJ=0Ls_=Rjh5LWfkd-6t1HkEsC5bLJc9LbfPs18jhQh5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33992 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHFPIf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Aug 2017 11:08:35 -0400
Received: by mail-oi0-f52.google.com with SMTP id x3so48355422oia.1
        for <ceph-devel@vger.kernel.org>; Sun, 06 Aug 2017 08:08:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

Hi,

    Just got this assert from one of our cluster, the drive is an SSD
and looks fine through smart.   Ceph cluster is running 11.2.0 with
bluestore with some tunings:

bluestore_min_alloc_size_ssd =3D 65536
bluestore_cache_size =3D 3221225472
bluestore_rocksdb_options =3D
compression=3DkNoCompression,max_write_buffer_number=3D32,min_write_buffer_=
number_to_merge=3D2,recycle_log_file_num=3D32,compaction_style=3DkCompactio=
nStyleLevel,write_buffer_size=3D536870912,target_file_size_base=3D67108864,=
max_background_compactions=3D31,level0_file_num_compaction_trigger=3D8,leve=
l0_slowdown_writes_trigger=3D32,level0_stop_writes_trigger=3D64,num_levels=
=3D7,max_bytes_for_level_base=3D536870912,max_bytes_for_level_multiplier=3D=
8,compaction_threads=3D32,flusher_threads=3D8,compaction_readahead_size=3D2=
097152


    The OSD and the data are still keeping for further debugging, more
than happy to provide more details.

   -14> 2017-08-06 04:03:38.356707 7f349df00700  4 rocksdb: (Original
Log Time 2017/08/06-04:03:38.356624) EVENT_LOG_v1 {"time_micros":
1502017418356373, "job": 3, "event": "compaction_finished",
"compaction_time_micros": 3608342, "output_level": 1,
"num_output_files": 3, "total_output_size": 204943307,
"num_input_records": 1888691, "num_output_records": 784200,
"num_subcompactions": 1, "num_single_delete_mismatches": 0,
"num_single_delete_fallthrough": 0, "lsm_state": [8, 8, 1, 0, 0, 0,
0]}
   -13> 2017-08-06 04:03:38.356711 7f349df00700  2 rocksdb: Waiting
after background compaction error: Corruption: block checksum
mismatch, Accumulated background error counts: 1
   -12> 2017-08-06 04:03:39.357038 7f349df00700  5 rocksdb: [JOB 3]
Delete db/000474.sst type=3D2 #474 -- OK

   -11> 2017-08-06 04:03:39.357068 7f349df00700  4 rocksdb:
EVENT_LOG_v1 {"time_micros": 1502017419357061, "job": 3, "event":
"table_file_deletion", "file_number": 474}
   -10> 2017-08-06 04:03:39.357085 7f349df00700  5 rocksdb: [JOB 3]
Delete db/000473.sst type=3D2 #473 -- OK

    -9> 2017-08-06 04:03:39.357091 7f349df00700  4 rocksdb:
EVENT_LOG_v1 {"time_micros": 1502017419357089, "job": 3, "event":
"table_file_deletion", "file_number": 473}
    -8> 2017-08-06 04:03:39.357129 7f349df00700  5 rocksdb: [JOB 3]
Delete db/000472.sst type=3D2 #472 -- OK

    -7> 2017-08-06 04:03:39.357138 7f349df00700  4 rocksdb:
EVENT_LOG_v1 {"time_micros": 1502017419357136, "job": 3, "event":
"table_file_deletion", "file_number": 472}
    -6> 2017-08-06 04:03:42.188494 7f34c0d86a40  0 osd.31 2168 load_pgs
    -5> 2017-08-06 04:03:42.191759 7f34c0d86a40  5 osd.31 pg_epoch:
2168 pg[2.fb3(unlocked)] enter Initial
    -4> 2017-08-06 04:03:42.395360 7f34c0d86a40  5 osd.31 pg_epoch:
2168 pg[2.fb3( v 1813'28879 (615'24904,1813'28879] local-les=3D2168
n=3D522 ec=3D156 les/c/f 2168/2168/0 2166/2167/156) [92,82,31] r=3D2 lpr=3D=
0
pi=3D156-2166/3 crt=3D1813'28879 lcod 0'0 inactive NOTIFY NIBBLEWISE] exit
Initial 0.203606 0 0.000000
    -3> 2017-08-06 04:03:42.395432 7f34c0d86a40  5 osd.31 pg_epoch:
2168 pg[2.fb3( v 1813'28879 (615'24904,1813'28879] local-les=3D2168
n=3D522 ec=3D156 les/c/f 2168/2168/0 2166/2167/156) [92,82,31] r=3D2 lpr=3D=
0
pi=3D156-2166/3 crt=3D1813'28879 lcod 0'0 inactive NOTIFY NIBBLEWISE]
enter Reset
    -2> 2017-08-06 04:03:42.395457 7f34c0d86a40  5
write_log_and_missing with: dirty_to: 0'0, dirty_from:
4294967295'18446744073709551615, writeout_from:
4294967295'18446744073709551615, trimmed: , clear_divergent_priors: 0
    -1> 2017-08-06 04:03:42.395816 7f34926e9700 -1 rocksdb:
submit_transaction error: Corruption: block checksum mismatch code =3D 2
Rocksdb transaction:
Put( Prefix =3D O key =3D
0x7f8000000000000002cdf0000021213dfffffffffffffffeffffffffffffffff'o'
Value size =3D 29)
Put( Prefix =3D S key =3D 'nid_max' Value size =3D 8)
Put( Prefix =3D S key =3D 'blobid_max' Value size =3D 8)
     0> 2017-08-06 04:03:42.399704 7f34926e9700 -1
/tmp/buildd/ceph-11.2.0/src/os/bluestore/BlueStore.cc: In function
'void BlueStore::_kv_sync_thread()' thread 7f34926e9700 time
2017-08-06 04:03:42.395856
/tmp/buildd/ceph-11.2.0/src/os/bluestore/BlueStore.cc: 6708: FAILED
assert(r =3D=3D 0)

 ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x80) [0x55b6dd7b9380]
 2: (BlueStore::_kv_sync_thread()+0x1563) [0x55b6dd4d4e03]
 3: (BlueStore::KVSyncThread::entry()+0xd) [0x55b6dd50e9dd]
 4: (()+0x76ba) [0x7f34bfe1a6ba]
 5: (clone()+0x6d) [0x7f34be4e83dd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
