From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 11:12:36 -0700
Message-ID: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:59288 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761Ab2DKSMg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 14:12:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>

Hi all,

A simple program like this:

int main(int argc, char **argv)
{
        int ret;
        struct ceph_mount_info *cmount;

        ceph_create(&cmount, NULL);
        //ceph_mount(cmount, NULL);
        ceph_chdir(cmount, "/");
}

will segfault because in the below snippet, cmount->get_client() returns NULL when ceph_mount(..) has not been been called with success.

extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char *s)                                                                             
{                                                                                                                                                     
        return cmount->get_client()->chdir(s);                                                                                                             
}

It would be very useful to get a uniform error return value rather than the fault. Something like this came to mind:

diff --git a/src/libcephfs.cc b/src/libcephfs.cc
index b1481e6..4751e8f 100644
--- a/src/libcephfs.cc
+++ b/src/libcephfs.cc
@@ -180,6 +180,10 @@ public:
     return cct;
   }
 
+  bool is_mounted(void) {
+    return mounted;
+  }
+
 private:
   uint64_t msgr_nonce;
   bool mounted;
@@ -282,6 +286,8 @@ extern "C" const char* ceph_getcwd(struct ceph_mount_info *cmount)
 
 extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char *s)
 {
+  if (!cmount->is_mounted())
+    return -1004;
   return cmount->get_client()->chdir(s);
 }

Any thoughts on a good way to handle this?

-Noah