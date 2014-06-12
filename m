From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] rbd.cc: Check io-size avoid floating point exception.
Date: Thu, 12 Jun 2014 08:15:17 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C87E2AA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11803 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbaFLIPV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jun 2014 04:15:21 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In func do_bench_write if io_size is zero,it can cause floating point execption.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 src/rbd.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/rbd.cc b/src/rbd.cc
index d6658e3..c068ed6 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -2038,6 +2038,14 @@ int main(int argc, const char **argv)
 	return EXIT_FAILURE;
       }
     } else if (ceph_argparse_withlonglong(args, i, &bench_io_size, &err, "--io-size", (char*)NULL)) {
+      if (!err.str().empty()) {
+	cerr << "rbd: " << err.str() << std::endl;
+	return EXIT_FAILURE;
+      }
+      if (bench_io_size == 0) {
+	cerr << "rbd: io-size must be > 0" << std::endl;
+	return EXIT_FAILURE;
+      }
     } else if (ceph_argparse_withlonglong(args, i, &bench_io_threads, &err, "--io-threads", (char*)NULL)) {
     } else if (ceph_argparse_withlonglong(args, i, &bench_bytes, &err, "--io-total", (char*)NULL)) {
     } else if (ceph_argparse_witharg(args, i, &bench_pattern, &err, "--io-pattern", (char*)NULL)) {
-- 
1.9.1
