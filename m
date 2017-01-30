From: Igor Fedotov <ifedotov@mirantis.com>
Subject: clone_range in BlueStore
Date: Mon, 30 Jan 2017 16:49:23 +0300
Message-ID: <ca59db38-bb73-991a-7a5b-1c8bd7b26789@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33416 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbdA3N46 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2017 08:56:58 -0500
Received: by mail-qt0-f179.google.com with SMTP id v23so203659145qtb.0
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2017 05:56:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

It looks like there is some bug somewhere in 
BlueStore/store_test/clone_range.

I'm occasionally hitting an assert on mismatched data in read result 
while performing SyntheticMatrixCsumVsCompression/2 test case.

--- buffer mismatch between offset 0x7400 and 0xa200, total 0x19e00
--- expected:
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*

00006c00  39 35 31 37 32 37 31 34  34 31 38 39 31 33 37 39 
|9517271441891379|

<skipped>

00007400  30 31 33 32 34 39 35 35  30 38 32 37 39 32 37 31 
|0132495508279271|

00007410  37 37 37 31 31 38 31 37  33 36 32 36 33 33 31 34 
|7771181736263314|

--- actual:
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*
00006c00  39 35 31 37 32 37 31 34  34 31 38 39 31 33 37 39 
|9517271441891379|

<skipped>

00007400  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*
0000a200  32 35 32 32 38 33 31 34  35 38 37 36 34 35 36 33 
|2522831458764563|

Multiple runs are required to hit that though...

I did some analysis and it seems that there are some issues with 
clone_range2 stuff.

First of all - do we have any limits prerequisites on src/dst offsets in 
this request? E.g. should they be aligned similarly within alloc unit 
boundaries? I recall some discussions on that

a while ago.

store_test doesn't have any as far as I can see, e.g. (min_alloc_size = 
0x10000)

  "ops": [
         {
             "op_num": 0,
             "op_name": "clonerange2",
             "collection": "555.0_head",
             "src_oid": 
"#555:3b000000:::OBJ_731aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa:head#",
             "dst_oid": "#555:c7000000:::OBJ_738:7cfc81ab#",
             "src_offset": 107520,
`            "len": 78336,
             "dst_offset": 27648
         }
     ]

This results in potentially invalid blobs for the destination objects, 
see extent starting at 0x7400 below - it has blob offset = 0 and hence 
blob isn't aligned with min_alloc_size:

2017-01-30 03:57:17.802440 7f0036a20700 15 
bluestore(bluestore.test_temp_dir) read 555.0_head 
#555:c7000000:::OBJ_738:7cfc81ab# 0x0~19e0
0
2017-01-30 03:57:17.802448 7f0036a20700 30 
bluestore.OnodeSpace(0x55eb49789b78 in 0x55eb45dd0620) lookup
2017-01-30 03:57:17.802450 7f0036a20700 30 
bluestore.OnodeSpace(0x55eb49789b78 in 0x55eb45dd0620) lookup 
#555:c7000000:::OBJ_738:7cfc81a
b# hit 0x55eb49874700
2017-01-30 03:57:17.802453 7f0036a20700 20 
bluestore(bluestore.test_temp_dir) _do_read 0x0~19e00 size 0x19e00 (105984)
2017-01-30 03:57:17.802455 7f0036a20700 20 
bluestore.onode(0x55eb49874700) flush done
2017-01-30 03:57:17.802456 7f0036a20700 30 
bluestore.extentmap(0x55eb49874850) fault_range 0x0~19e00
2017-01-30 03:57:17.802457 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _dump_onode 0x55eb49874700 
#555:c7000000:::OBJ_738:7cfc81a
b# nid 17377 size 0x19e00 (105984) expected_object_size 2097152 
expected_write_size 4096 in 0 shards
2017-01-30 03:57:17.802461 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _dump_extent_map  0x6c00~800: 
0x3800~800 Blob(0x55eb5047a4
60 blob([0x40190000~4000] csum+has_unused+shared crc32c/0x1000 
unused=0xff) ref_map(0x3800~800=1) SharedBlob(0x55eb4c2f49f0 sbid 0x3adf
loaded shared_blob(ref_map(0x40190000~4000=2))))
2017-01-30 03:57:17.802469 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _dump_extent_map      csum: 
[0,0,f1e4ed4a,417bbe91]
2017-01-30 03:57:17.802472 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _dump_extent_map  0x7400~12a00: 
0x0~12a00 Blob(0x55eb4dc87
b80 blob([0x40194000~18000] csum+shared crc32c/0x1000) 
ref_map(0x0~12a00=1) SharedBlob(0x55eb4c2f5180 sbid 0x3ae0 loaded 
shared_blob(ref
_map(0x40194000~18000=3))))
2017-01-30 03:57:17.802479 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _dump_extent_map      csum: 
[d1f849c5,fbe516b8,518379f8,b8
b944c8,18b7be23,2b6562d5,51de5770,40988db7,bf7fd7f3,14744e41,eddcb459,639b3350,d038700c,80ffc21e,d7f4edb3,a7ae1a9,f123b379,dfb76444,8ac0
3032,c1cbff33,629e4868,12d9f0ea,5d50ca8c,b7ce671d]
2017-01-30 03:57:17.802484 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _dump_extent_map 0x0~18000 
buffer(0x55eb45deb020 spa
ce 0x55eb4c2f51d8 0x0~18000 clean)
2017-01-30 03:57:17.802487 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _do_read  hole 0x0~6c00
2017-01-30 03:57:17.802490 7f0036a20700 20 
bluestore(bluestore.test_temp_dir) _do_read  blob Blob(0x55eb5047a460 
blob([0x40190000~4000]
csum+has_unused+shared crc32c/0x1000 unused=0xff) ref_map(0x3800~800=1) 
SharedBlob(0x55eb4c2f49f0 sbid 0x3adf loaded shared_blob(ref_map
(0x40190000~4000=2)))) need 0x3800~800 cache has 0x[]
2017-01-30 03:57:17.802495 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _do_read    will read 0x6c00: 0x3800~800
2017-01-30 03:57:17.802509 7f0036a20700 20 
bluestore(bluestore.test_temp_dir) _do_read  blob Blob(0x55eb4dc87b80 
blob([0x40194000~18000]
  csum+shared crc32c/0x1000) ref_map(0x0~12a00=1) 
SharedBlob(0x55eb4c2f5180 sbid 0x3ae0 loaded 
shared_blob(ref_map(0x40194000~18000=3))))
  need 0x0~12a00 cache has 0x[0~12a00]
2017-01-30 03:57:17.802515 7f0036a20700 30 
bluestore(bluestore.test_temp_dir) _do_read    use cache 0x7400: 0x0~12a00
2017-01-30 03:57:17.802519 7f0036a20700 20 
bluestore(bluestore.test_temp_dir) _do_read  blob Blob(0x55eb5047a460 
blob([0x40190000~4000] csum+has_unused+shared crc32c/0x1000 unused=0xff) 
ref_map(0x3800~800=1) SharedBlob(0x55eb4c2f49f0 sbid 0x3adf loaded 
shared_blob(ref_map(0x40190000~4000=2)))) need 0x0x6c00:3800~800
2017-01-30 03:57:17.802529 7f0036a20700 20 
bluestore(bluestore.test_temp_dir) _do_read    region 0x6c00: 0x3800~800 
reading 0x3000~1000

I haven't unwind all the clone_range transformations that lead to this 
state yet. In the example above source object already has the same 
unaligned extents issue.

But anyway it appears that clone_range neither care nor assert on 
unaligned input offsets...

I can share a couple of logs if needed..

Any comments?

Thanks,

Igor


