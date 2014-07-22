From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] os/FileJournal: When dump journal, using correctly last-seq
 avoid  misjudging joural corrupt.
Date: Tue, 22 Jul 2014 00:29:20 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8953EE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17703 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbaGVA32 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jul 2014 20:29:28 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@inktank.com" <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In func FileJournal::dump, it always use seq=0 as last-seq and misjudge the journal corrupt.

Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
---
 src/os/FileJournal.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index 7eb7927..3307655 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -564,9 +564,9 @@ int FileJournal::dump(ostream& out)
   JSONFormatter f(true);

   f.open_array_section("journal");
+  uint64_t seq = 0;
   while (1) {
     bufferlist bl;
-    uint64_t seq = 0;
     uint64_t pos = read_pos;
     if (!read_entry(bl, seq)) {
       dout(3) << "journal_replay: end of journal, done." << dendl;
--
1.9.1

