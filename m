From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] qa/workunits/erasure-code/bench.sh: Using correcting
 parameter name when call ceph_erasure_code_benchmark.
Date: Tue, 15 Jul 2014 09:31:28 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8880CC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57902 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530AbaGOJbn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jul 2014 05:31:43 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "loic@dachary.org" <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In commit bcc74879a, loic modifed the parameter name. But he forgot to
modify the name in qa/workunits/erasure-code/bench.sh. Now modify and make
bench.sh work.

Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
---
 qa/workunits/erasure-code/bench.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qa/workunits/erasure-code/bench.sh b/qa/workunits/erasure-code/bench.sh
index db7c490..483450b 100755
--- a/qa/workunits/erasure-code/bench.sh
+++ b/qa/workunits/erasure-code/bench.sh
@@ -50,9 +50,9 @@ function bench() {
         --iterations $iterations \
         --size $size \
         --erasures $erasures \
-        --parameter erasure-code-k=$k \
-        --parameter erasure-code-m=$m \
-        --parameter erasure-code-directory=$PLUGIN_DIRECTORY)
+        --parameter k=$k \
+        --parameter m=$m \
+        --parameter directory=$PLUGIN_DIRECTORY)
     result=$($command "$@")
     echo -e "$result\t$plugin\t$k\t$m\t$workload\t$iterations\t$size\t$erasures\t$command ""$@"
 }
--
1.9.1

