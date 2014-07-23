From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] os/FileJournal: Update the journal header when closing
 journal
Date: Wed, 23 Jul 2014 07:43:09 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C895E17@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62684 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbaGWHnP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jul 2014 03:43:15 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@redhat.com" <sage@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When closing journal, it should check must_write_header and update
journal header if must_write_header alreay set.
It can reduce the nosense journal-replay after restarting osd.

Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
---
 src/os/FileJournal.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index 7eb7927..5649e6d 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -544,6 +544,7 @@ void FileJournal::close()

   // close
   assert(writeq_empty());
+  assert(!must_write_header);
   assert(fd >= 0);
   VOID_TEMP_FAILURE_RETRY(::close(fd));
   fd = -1;
@@ -1102,7 +1103,7 @@ void FileJournal::write_thread_entry()
   while (1) {
     {
       Mutex::Locker locker(writeq_lock);
-      if (writeq.empty()) {
+      if (writeq.empty() && !must_write_header) {
        if (write_stop)
          break;
        dout(20) << "write_thread_entry going to sleep" << dendl;
--
1.9.1

