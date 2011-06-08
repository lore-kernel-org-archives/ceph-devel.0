From: Sam Lang <samlang@gmail.com>
Subject: [PATCH 1/2] Fix segfault caused by invalid argument string.
Date: Wed,  8 Jun 2011 12:59:11 -0500
Message-ID: <1307555952-10340-1-git-send-email-samlang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64792 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1FHR7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 13:59:17 -0400
Received: by qyk7 with SMTP id 7so2064209qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jun 2011 10:59:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sam Lang <samlang@gmail.com>

This patchset includes minor fixes to the crushtool utility.  If an invalid bucket type is speicifed on the command line, the code was iterating through bucket_types for the length of the static array, but the last entry in that array has null (0) values, which was causing a segfault.  This patch just checks that bucket_types[i].name is non-null instead.  Also, if the wrong bucket type or algorithm is specified, prints the usage string on exit.

Signed-off-by: Sam Lang <samlang@gmail.com>
---
 src/crushtool.cc |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/crushtool.cc b/src/crushtool.cc
index 73c303b..64b2b4f 100644
--- a/src/crushtool.cc
+++ b/src/crushtool.cc
@@ -54,6 +54,8 @@ map<string, int> type_id;
 
 map<string, int> rule_id;
 
+void usage();
+
 string string_node(node_t &node)
 {
   string s = string(node.value.begin(), node.value.end());
@@ -141,8 +143,8 @@ void parse_bucket(iter_t const& i, CrushWrapper &crush)
       else if (a == "straw")
 	alg = CRUSH_BUCKET_STRAW;
       else {
-	cerr << "unknown bucket alg '" << a << "'" << std::endl;
-	exit(1);
+	cerr << "unknown bucket alg '" << a << "'" << std::endl << std::endl;
+	usage();
       }
     }
     else if (tag == "hash") {
@@ -936,14 +938,14 @@ int main(int argc, const char **argv)
       crush.set_type_name(type, l.name);
 
       int buckettype = -1;
-      for (int i = 0; i < (int)(sizeof(bucket_types)/sizeof(bucket_types[0])); i++)
-	if (strcmp(l.buckettype, bucket_types[i].name) == 0) {
+      for (int i = 0; bucket_types[i].name; i++)
+	if (l.buckettype && strcmp(l.buckettype, bucket_types[i].name) == 0) {
 	  buckettype = bucket_types[i].type;
 	  break;
 	}
       if (buckettype < 0) {
-	cerr << "unknown bucket type '" << l.buckettype << "'" << std::endl;
-	exit(1);
+	cerr << "unknown bucket type '" << l.buckettype << "'" << std::endl << std::endl;
+	usage();
       }
 
       // build items
-- 
1.7.1

