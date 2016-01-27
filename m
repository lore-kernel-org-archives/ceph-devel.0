From: Sahithi R V <sahithi.rv1@gmail.com>
Subject: [PATCH]common/str_map: Removed unnecessary function overloading of get_str_map()
Date: Wed, 27 Jan 2016 11:53:51 +0530
Message-ID: <CAAKF69rJmAA2rNaFjDetkN5-1uQf+UZXhmD9xXx+89-S0goE4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35013 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbcA0GXw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 01:23:52 -0500
Received: by mail-io0-f181.google.com with SMTP id 77so8920680ioc.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 22:23:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This patch removes the function overloading of get_str_map() by using
CONST_DELIMS as default parameters to const char *delims .It also
replaces all the occurences of get_str_map() function with 2
arguments, in src directory.

Signed-off-by: Sahithi R V <sahithi.rv1@gmail.com>
---
 src/common/str_map.cc           | 14 +++-----------
 src/include/str_map.h           | 10 ++++------
 src/kv/RocksDBStore.cc          |  2 +-
 src/test/common/test_str_map.cc |  2 +-
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/src/common/str_map.cc b/src/common/str_map.cc
index bd68612..4605302 100644
--- a/src/common/str_map.cc
+++ b/src/common/str_map.cc
@@ -51,7 +51,7 @@ int get_json_str_map(
   } catch (json_spirit::Error_position &e) {
     if (fallback_to_plain) {
       // fallback to key=value format
-      get_str_map(str, "\t\n ", str_map);
+      get_str_map(str, str_map, "\t\n ");
     } else {
       return -EINVAL;
     }
@@ -75,8 +75,8 @@ string trim(const string& str) {

 int get_str_map(
     const string &str,
-    const char *delims,
-    map<string,string> *str_map)
+    map<string,string> *str_map,
+    const char *delims)
 {
   list<string> pairs;
   get_str_list(str, delims, pairs);
@@ -94,14 +94,6 @@ int get_str_map(
   return 0;
 }

-int get_str_map(
-    const string &str,
-    map<string,string> *str_map)
-{
-  const char *delims = ",;\t\n ";
-  return get_str_map(str, delims, str_map);
-}
-
 string get_str_map_value(
     const map<string,string> &str_map,
     const string &key,
diff --git a/src/include/str_map.h b/src/include/str_map.h
index 0bd9de3..6a0370d 100644
--- a/src/include/str_map.h
+++ b/src/include/str_map.h
@@ -17,6 +17,8 @@
 #ifndef CEPH_STRMAP_H
 #define CEPH_STRMAP_H

+#define CONST_DELIMS ",;\t\n "
+
 #include <map>
 #include <string>
 #include <sstream>
@@ -89,12 +91,8 @@ extern int get_json_str_map(
  */
 extern int get_str_map(
     const std::string &str,
-    const char *delims,
-    std::map<std::string,std::string> *str_map);
-
-extern int get_str_map(
-    const std::string &str,
-    std::map<std::string,std::string> *str_map);
+    std::map<std::string,std::string> *str_map,
+    const char *delims = CONST_DELIMS);

 /**
  * Returns the value of **key** in **str_map** if available.
diff --git a/src/kv/RocksDBStore.cc b/src/kv/RocksDBStore.cc
index 794a254..41caee0 100644
--- a/src/kv/RocksDBStore.cc
+++ b/src/kv/RocksDBStore.cc
@@ -118,7 +118,7 @@ int RocksDBStore::tryInterpret(const string key,
const string val, rocksdb::Opti
 int RocksDBStore::ParseOptionsFromString(const string opt_str,
rocksdb::Options &opt)
 {
   map<string, string> str_map;
-  int r = get_str_map(opt_str, ",\n;", &str_map);
+  int r = get_str_map(opt_str, &str_map, ",\n;");
   if (r < 0)
     return r;
   map<string, string>::iterator it;
diff --git a/src/test/common/test_str_map.cc b/src/test/common/test_str_map.cc
index 5a324ba..e96c792 100644
--- a/src/test/common/test_str_map.cc
+++ b/src/test/common/test_str_map.cc
@@ -58,7 +58,7 @@ TEST(str_map, plaintext) {
   }
   {
     map<string,string> str_map;
-    ASSERT_EQ(0, get_str_map(" key1=val1; key2=\tval2; key3\t = \t
val3; \n ", "\n;", &str_map));
+    ASSERT_EQ(0, get_str_map(" key1=val1; key2=\tval2; key3\t = \t
val3; \n ", &str_map, "\n;"));
     ASSERT_EQ(4u, str_map.size());
     ASSERT_EQ("val1", str_map["key1"]);
     ASSERT_EQ("val2", str_map["key2"]);
-- 
1.9.1
