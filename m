From: Igor Fedotov <ifedotov@mirantis.com>
Subject: mem use doubles due to buffer::create_page_aligned + bluestore obj
 content caching
Date: Mon, 6 Mar 2017 20:35:25 +0300
Message-ID: <6b06369d-6b18-f4f0-b7ae-0c0114288e41@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35399 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753597AbdCFSgT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 13:36:19 -0500
Received: by mail-ua0-f172.google.com with SMTP id q7so141436548uaf.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 10:36:13 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id u139sm4217644vke.29.2017.03.06.09.35.27
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 09:35:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers,

I've just created a ticket related to bluestore object content caching 
in particular and buffer::create_page_aligned in general.

But I'd like to additionally share this information here as well since 
the root cause seems to be pretty global.

Ticker URL:

http://tracker.ceph.com/issues/19198

Description:

When caching object content BlueStore uses twice as much memory than it 
really needs for that data amount.

The root cause seems to be in buffer::create_page_aligned 
implementation. Actually it results in
new raw_posix_aligned()

   calling mempool::buffer_data::alloc_char.allocate_aligned(len, align);

       calling  posix_memalign((void**)(void*)&ptr, align, total);

sequence that in fact does 2 allocations:

1) for raw_posix_aligned struct
2) for data itself (4096 bytes).

It looks like this sequence causes 2 * 4096 bytes allocation instead of 
sizeof(raw_posix_aligned) + alignment + 4096.
The additional trick is that mempool stuff is unable to estimate such an 
overhead and hence BlueStore cache cleanup doesn't work properly.

It's not clear for me why allocator(s) behave that inefficiently for 
such a pattern though.

The issue is reproducible under Ubuntu 16.04.1 LTS for both jemalloc and 
tcmalloc builds.


The ticket contains the patch to reproduce the issue and one can see 
that for 16Gb content system mem usage tend to be ~32Gb.

Patch firstly allocates 4K pages 0x400000 times using:

...

+  size_t alloc_count = 0x400000; // allocate 16 Gb total
+  allocs.resize(alloc_count);
+  for( auto i = 0u; i < alloc_count; ++i) {
+    bufferptr p = buffer::create_page_aligned(bsize);
+    bufferlist* bl = new bufferlist;
+    bl->append(p);
+    *(bl->c_str()) = 0; // touch the page to increment system mem use

...

then do the same reproducing  create_page_aligned() implementation:

+  struct fake_raw_posix_aligned{
+    char stub[8];
+    void* data;
+    fake_raw_posix_aligned() {
+      ::posix_memalign(&data, 0x1000, 0x1000); 
//mempool::buffer_data::alloc_char.allocate_aligned(0x1000, 0x1000);
+      *((char*)data) = 0; // touch the page
+    }
+    ~fake_raw_posix_aligned() {
+      ::free(data);
+    }
+  };
+  vector <fake_raw_posix_aligned*> allocs2;

+  allocs2.resize(alloc_count);
+  for( auto i = 0u; i < alloc_count; ++i) {
+    allocs2[i] = new fake_raw_posix_aligned();
...

Output shows 32Gb usage in both cases.

Mem before: VmRSS: 45232 kB
Mem after: VmRSS: 33599524 kB
Mem actually used: 33554292 kB
Mem pool reports: 16777216 kB
Mem before2: VmRSS: 2161412 kB
Mem after2: VmRSS: 33632268 kB
Mem actually used: 32226156544 bytes


In general there are two issues here:
1) Doubled memory usage
2) mempool is unaware of such an overhead and miscalculates the actual 
mem usage.

There is probably a way to resolve 2) by forcing raw_combined::create() 
use in buffer::create_page_aligned and tuning mempool calculation to 
take page alignment into account. But I'd like to get some 
comments/thoughts first....


Thanks,
Igor


