From: =?UTF-8?B?6ams5bu65pyL?= <majianpeng@gmail.com>
Subject: Rocksdb bug
Date: Sat, 3 Dec 2016 20:37:59 +0800
Message-ID: <CALurOm2bof_AcgXFZx0a2v36=pFZD4B8YCGi9DgZNm3NMJC1Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36717 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbcLCMiA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Dec 2016 07:38:00 -0500
Received: by mail-vk0-f46.google.com with SMTP id p9so159095956vkd.3
        for <ceph-devel@vger.kernel.org>; Sat, 03 Dec 2016 04:38:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: jianpeng.ma@intel.com

Hi All
     Based v11.0.2 i did write-test and always met this bug as followings:
    -1> 2016-12-03 11:47:34.897412 7fa4207fd700 -1 rocksdb:
submit_transaction error: NotFound:  code = 1 Rocksdb transaction:
Put( Prefix = M key =
0x000000000000079c'.0000000272.00000000000000075338' Value size = 182)
Put( Prefix = M key = 0x000000000000079c'._epoch' Value size = 4)
Put( Prefix = M key = 0x000000000000079c'._info' Value size = 855)
Put( Prefix = O key =
0x7f8000000000000001600ab4'%!rbd_data.5f126b8b4567.000000000000233e!='0xfffffffffffffffeffffffffffffffff
Value size = 526)
Put( Prefix = L key = 0x0000000004be661a Value size = 4138)
     0> 2016-12-03 11:47:34.899063 7fa4207fd700 -1
/root/ceph/src/os/bluestore/BlueStore.cc: In function 'void
BlueStore::_kv_sync_thread()' thread 7fa4207fd700 time 2016-12-03
11:47:34.897441
/root/ceph/src/os/bluestore/BlueStore.cc: 6484: FAILED assert(r == 0)

 ceph version v11.0.2 (697fe64f9f106252c49a2c4fe4d79aea29363be7)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0x5651411b675b]
 2: (BlueStore::_kv_sync_thread()+0x1be4) [0x565140f5e404]
 3: (BlueStore::KVSyncThread::entry()+0xd) [0x565140f6bc5d]
 4: (()+0x8182) [0x7fa45c1e8182]
 5: (clone()+0x6d) [0x7fa45ab5547d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

But test the same case on master code, i don't see this bug.
I need help. Thanks very much

Jianpeng.
