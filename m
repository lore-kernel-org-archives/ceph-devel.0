From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Bug in mempool::map?
Date: Tue, 20 Dec 2016 18:04:00 +0300
Message-ID: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36811 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbcLTPEL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 10:04:11 -0500
Received: by mail-yw0-f172.google.com with SMTP id a10so83201104ywa.3
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 07:04:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Allen,

It looks like mempools don't measure maps allocations properly.

I extended unittest_mempool in the following way but corresponding 
output is always 0 for both 'before' and 'after' values:


diff --git a/src/test/test_mempool.cc b/src/test/test_mempool.cc
index 4113c53..b38a356 100644
--- a/src/test/test_mempool.cc
+++ b/src/test/test_mempool.cc
@@ -232,9 +232,19 @@ TEST(mempool, set)
  TEST(mempool, map)
  {
    {
-    mempool::unittest_1::map<int,int> v;
-    v[1] = 2;
-    v[3] = 4;
+    size_t before = mempool::buffer_data::allocated_bytes();
+    mempool::unittest_1::map<int,int>* v = new 
mempool::unittest_1::map<int,int>;
+    (*v)[1] = 2;
+    (*v)[3] = 4;
+    size_t after = mempool::buffer_data::allocated_bytes();
+    cout << "before " << before << " after " << after << std::endl;
+    delete v;
+    before = after;
+    mempool::unittest_1::map<int64_t,int64_t> v2;
+    v2[1] = 2;
+    v2[3] = 4;
+    after = mempool::buffer_data::allocated_bytes();
+    cout << " before " << before << " after " << after << std::endl;
    }
    {
      mempool::unittest_2::map<int,obj> v;


Output:

[ RUN      ] mempool.map
before 0 after 0
  before 0 after 0
[       OK ] mempool.map (0 ms)

It looks like we do not measure ref_map for BlueStore Blob and 
SharedBlob classes too.

Any ideas?

Thanks,

Igor

