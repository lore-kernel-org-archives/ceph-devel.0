From: Takuya ASADA <syuu@dokukino.com>
Subject: librados.hpp fix
Date: Tue, 3 Aug 2010 21:21:10 +0900
Message-ID: <AANLkTi=wtavHtw04KwZRfK2LrWahS6TdmN2nh_phcRJn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33223 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab0HCMVb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Aug 2010 08:21:31 -0400
Received: by wyb39 with SMTP id 39so4308942wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Aug 2010 05:21:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I just realized librados.hpp could compile only if "using namespace
std;" is declared before "#include <rados/librados.hpp>", because
"vector" used without std namespace, and I think it's wrong.
It can fix following patch.

syuu

diff --git a/src/include/librados.hpp b/src/include/librados.hpp
index b0d3622..06fa3b2 100644
--- a/src/include/librados.hpp
+++ b/src/include/librados.hpp
@@ -38,7 +38,7 @@ namespace librados {

   struct SnapContext {
     snap_t seq;
-    vector<snap_t> snaps;
+    std::vector<snap_t> snaps;
   };


@@ -57,7 +57,7 @@ public:
   int lookup_pool(const char *name);

   void set_snap(pool_t pool, snap_t seq);
-  int set_snap_context(pool_t pool, snap_t seq, vector<snap_t>& snaps);
+  int set_snap_context(pool_t pool, snap_t seq, std::vector<snap_t>& snaps);


   int create(pool_t pool, const std::string& oid, bool exclusive);
