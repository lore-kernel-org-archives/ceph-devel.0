From: Filippos Giannakos <philipgian@grnet.gr>
Subject: [PATCH 2/2] Add RADOS API lock tests
Date: Thu, 30 May 2013 16:02:02 +0300
Message-ID: <1369918922-867-3-git-send-email-philipgian@grnet.gr>
References: <1369918922-867-1-git-send-email-philipgian@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:18848 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755085Ab3E3NS3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 May 2013 09:18:29 -0400
In-Reply-To: <1369918922-867-1-git-send-email-philipgian@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Filippos Giannakos <philipgian@grnet.gr>, synnefo-devel@googlegroups.com

Add tests for the advisory locking API calls.

Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
---
 src/Makefile.am           |    6 ++
 src/test/librados/lock.cc |  236 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 src/test/librados/lock.cc

diff --git a/src/Makefile.am b/src/Makefile.am
index 3b95662..ccabf19 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1015,6 +1015,12 @@ ceph_test_rados_api_misc_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
 ceph_test_rados_api_misc_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
 bin_DEBUGPROGRAMS += ceph_test_rados_api_misc
 
+ceph_test_rados_api_lock_SOURCES = test/librados/lock.cc test/librados/test.cc
+ceph_test_rados_api_lock_LDFLAGS = ${AM_LDFLAGS}
+ceph_test_rados_api_lock_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
+ceph_test_rados_api_lock_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
+bin_DEBUGPROGRAMS += ceph_test_rados_api_lock
+
 ceph_test_libcephfs_SOURCES = test/libcephfs/test.cc test/libcephfs/readdir_r_cb.cc test/libcephfs/caps.cc
 ceph_test_libcephfs_LDFLAGS = $(PTHREAD_CFLAGS) ${AM_LDFLAGS}
 ceph_test_libcephfs_LDADD =  ${UNITTEST_STATIC_LDADD} libcephfs.la
diff --git a/src/test/librados/lock.cc b/src/test/librados/lock.cc
new file mode 100644
index 0000000..bee726d
--- /dev/null
+++ b/src/test/librados/lock.cc
@@ -0,0 +1,236 @@
+#include "include/rados/librados.h"
+#include "include/rados/librados.hpp"
+#include "test/librados/test.h"
+#include "cls/lock/cls_lock_client.h"
+
+#include <algorithm>
+#include <errno.h>
+#include "gtest/gtest.h"
+
+using namespace librados;
+
+TEST(LibRadosLock, LockExclusive) {
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-EEXIST, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRadosLock, LockExclusivePP) {
+  Rados cluster;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
+  IoCtx ioctx;
+  cluster.ioctx_create(pool_name.c_str(), ioctx);
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-EEXIST, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
+}
+
+TEST(LibRadosLock, LockShared) {
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+  ASSERT_EQ(0, rados_lock_shared(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-EEXIST, rados_lock_shared(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRadosLock, LockSharedPP) {
+  Rados cluster;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
+  IoCtx ioctx;
+  cluster.ioctx_create(pool_name.c_str(), ioctx);
+  ASSERT_EQ(0, ioctx.lock_shared("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-EEXIST, ioctx.lock_shared("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
+}
+
+TEST(LibRadosLock, LockRenew) {
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-EEXIST, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", LOCK_FLAG_RENEW));
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRadosLock, LockRenewPP) {
+  Rados cluster;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
+  IoCtx ioctx;
+  cluster.ioctx_create(pool_name.c_str(), ioctx);
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-EEXIST, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", LOCK_FLAG_RENEW));
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
+}
+
+TEST(LibRadosLock, Unlock) {
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(0, rados_unlock(ioctx, "foo", "TestLock", "Cookie"));
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRadosLock, UnlockPP) {
+  Rados cluster;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
+  IoCtx ioctx;
+  cluster.ioctx_create(pool_name.c_str(), ioctx);
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(0, ioctx.unlock("foo", "TestLock", "Cookie"));
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
+}
+
+TEST(LibRadosLock, ListLockers) {
+  int exclusive;
+  char tag[1024];
+  char clients[1024];
+  char cookies[1024];
+  char addresses[1024];
+  size_t tag_len = 1024;
+  size_t clients_len = 1024;
+  size_t cookies_len = 1024;
+  size_t addresses_len = 1024;
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  std::stringstream sstm;
+  sstm << "client." << rados_get_instance_id(cluster);
+  std::string me = sstm.str();
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(0, rados_unlock(ioctx, "foo", "TestLock", "Cookie"));
+  ASSERT_EQ(0, rados_list_lockers(ioctx, "foo", "TestLock", &exclusive, tag, &tag_len, clients, &clients_len, cookies, &cookies_len, addresses, &addresses_len ));
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(-34, rados_list_lockers(ioctx, "foo", "TestLock", &exclusive, tag, &tag_len, clients, &clients_len, cookies, &cookies_len, addresses, &addresses_len ));
+  tag_len = 1024;
+  clients_len = 1024;
+  cookies_len = 1024;
+  addresses_len = 1024;
+  ASSERT_EQ(1, rados_list_lockers(ioctx, "foo", "TestLock", &exclusive, tag, &tag_len, clients, &clients_len, cookies, &cookies_len, addresses, &addresses_len ));
+  ASSERT_EQ(1, exclusive);
+  ASSERT_EQ(0, strcmp(tag, "Tag"));
+  ASSERT_EQ(strlen("Tag") + 1, tag_len);
+  ASSERT_EQ(0, strcmp(me.c_str(), clients));
+  ASSERT_EQ(me.size() + 1, clients_len);
+  ASSERT_EQ(0, strcmp(cookies, "Cookie"));
+  ASSERT_EQ(strlen("Cookie") + 1, cookies_len);
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRadosLock, ListLockersPP) {
+  Rados cluster;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
+  IoCtx ioctx;
+  cluster.ioctx_create(pool_name.c_str(), ioctx);
+  std::stringstream sstm;
+  sstm << "client." << cluster.get_instance_id();
+  std::string me = sstm.str();
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(0, ioctx.unlock("foo", "TestLock", "Cookie"));
+  {
+    int exclusive;
+    std::string tag;
+    std::list<librados::locker_t> lockers;
+    ASSERT_EQ(0, ioctx.list_lockers("foo", "TestLock", &exclusive, &tag, &lockers));
+  }
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  {
+    int exclusive;
+    std::string tag;
+    std::list<librados::locker_t> lockers;
+    ASSERT_EQ(1, ioctx.list_lockers("foo", "TestLock", &exclusive, &tag, &lockers));
+    std::list<librados::locker_t>::iterator it = lockers.begin();
+    ASSERT_FALSE(lockers.end() == it);
+    ASSERT_EQ(me, it->client);
+    ASSERT_EQ("Cookie", it->cookie);
+  }
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
+}
+
+TEST(LibRadosLock, BreakLock) {
+  int exclusive;
+  char tag[1024];
+  char clients[1024];
+  char cookies[1024];
+  char addresses[1024];
+  size_t tag_len = 1024;
+  size_t clients_len = 1024;
+  size_t cookies_len = 1024;
+  size_t addresses_len = 1024;
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  std::stringstream sstm;
+  sstm << "client." << rados_get_instance_id(cluster);
+  std::string me = sstm.str();
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+  ASSERT_EQ(0, rados_lock_exclusive(ioctx, "foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(1, rados_list_lockers(ioctx, "foo", "TestLock", &exclusive, tag, &tag_len, clients, &clients_len, cookies, &cookies_len, addresses, &addresses_len ));
+  ASSERT_EQ(1, exclusive);
+  ASSERT_EQ(0, strcmp(tag, "Tag"));
+  ASSERT_EQ(strlen("Tag") + 1, tag_len);
+  ASSERT_EQ(0, strcmp(me.c_str(), clients));
+  ASSERT_EQ(me.size() + 1, clients_len);
+  ASSERT_EQ(0, strcmp(cookies, "Cookie"));
+  ASSERT_EQ(strlen("Cookie") + 1, cookies_len);
+  ASSERT_EQ(0, rados_break_lock(ioctx, "foo", "TestLock", clients, "Cookie"));
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRadosLock, BreakLockPP) {
+  int exclusive;
+  std::string tag;
+  std::list<librados::locker_t> lockers;
+  Rados cluster;
+  std::string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
+  IoCtx ioctx;
+  cluster.ioctx_create(pool_name.c_str(), ioctx);
+  std::stringstream sstm;
+  sstm << "client." << cluster.get_instance_id();
+  std::string me = sstm.str();
+  ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie", "Tag", "", 0));
+  ASSERT_EQ(1, ioctx.list_lockers("foo", "TestLock", &exclusive, &tag, &lockers));
+  std::list<librados::locker_t>::iterator it = lockers.begin();
+  ASSERT_FALSE(lockers.end() == it);
+  ASSERT_EQ(me, it->client);
+  ASSERT_EQ("Cookie", it->cookie);
+  ASSERT_EQ(0, ioctx.break_lock("foo", "TestLock", it->client, "Cookie"));
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
+}
-- 
1.7.10.4

