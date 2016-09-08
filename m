From: Igor Fedotov <ifedotov@mirantis.com>
Subject: assert at BitMapAllocator
Date: Thu, 8 Sep 2016 17:26:44 +0300
Message-ID: <36559f57-15a3-f6d8-b27c-1efe5b1cb041@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33010 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758552AbcIHO0t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 10:26:49 -0400
Received: by mail-qk0-f171.google.com with SMTP id w204so45856218qka.0
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 07:26:48 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id z32sm24239858qtz.0.2016.09.08.07.26.46
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 07:26:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

I'm observing an assert at BitMapAllocator with recent master.

Here is the call stack

   -2> 2016-09-08 14:03:06.012847 7fe64ffff700  0 
bluestore(./fio-bluestore) _balance_bluefs_freespace reclaiming 
1908342784 (1819 M)
     -1> 2016-09-08 14:03:06.012915 7fe64ffff700  0 bitmapalloc:reserve 
1908342784 1048576
      0> 2016-09-08 14:03:06.026425 7fe64ffff700 -1 
/root/ceph/ceph/src/os/bluestore/BitMapAllocator.cc: In function 
'virtual int BitMapAllocator::reserve(uint64_t)' thread 7fe64ffff700 
time 2016-09-08 14:03:06.012930
/root/ceph/ceph/src/os/bluestore/BitMapAllocator.cc: 88: FAILED 
assert(!(need % m_block_size))

  ceph version v11.0.0-2160-g1556190 
(15561908510a3838e87f1938e5afc65570fecdc4)
  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x95) [0x7fe72f132d7e]
  2: (BitMapAllocator::reserve(unsigned long)+0x204) [0x7fe72efb8482]
  3: (BlueFS::reclaim_blocks(unsigned int, unsigned long, unsigned 
long*, unsigned int*)+0x286) [0x7fe72ef6bc3a]
  4: 
(BlueStore::_balance_bluefs_freespace(std::vector<bluestore_pextent_t, 
std::allocator<bluestore_pextent_t> >*)+0x1417) [0x7fe72ee62227]
  5: (BlueStore::_kv_sync_thread()+0x1234) [0x7fe72ee849d2]
  6: (BlueStore::KVSyncThread::entry()+0x1c) [0x7fe72eea81c8]
  7: (Thread::entry_wrapper()+0xc1) [0x7fe72f1ea9dd]
  8: (Thread::_entry_func(void*)+0x18) [0x7fe72f1ea912]
  9: (()+0x76fa) [0x7fe7421dc6fa]
  10: (clone()+0x6d) [0x7fe741d0eb5d]

The line below presents 'reclaim' var value when calling 
bluefs->reclaim_blocks from BlueStore.cc

   -2> 2016-09-08 14:03:06.012847 7fe64ffff700  0 
bluestore(./fio-bluestore) _balance_bluefs_freespace reclaiming 
1908342784 (1819 M)

and following one provides need & m_block_size vars at BitMapAlloc::reserve

     -1> 2016-09-08 14:03:06.012915 7fe64ffff700  0 bitmapalloc:reserve 
1908342784 1048576

One can see that BlueStore provides a value not aligned with 
BitMapAllocator's m_block_size.
Indeed there is
     reclaim = P2ROUNDUP(reclaim, min_alloc_size);
where min_alloc_size = 64K in my case, not 1M as BitMapAllocator expects.

Any comments/suggestions?

Thanks,
Igor


