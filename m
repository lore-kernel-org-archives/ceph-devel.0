From: Nathan Cutler <ncutler@suse.cz>
Subject: [PATCH] ceph-disk: s/prefered/preferred/
Date: Fri, 1 Apr 2016 08:56:17 +0200
Message-ID: <56FE1B91.2080108@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33527 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbcDAG4T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Apr 2016 02:56:19 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2B745AAF1
	for <ceph-devel@vger.kernel.org>; Fri,  1 Apr 2016 06:56:17 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Please pull the following Ceph updates from this mail.

There is not much here, just some overdue proofreading.

This patch is based on a recent merge of the jewel tree to avoid 
conflicts with a recent refactor.

Sincerely

Signed-off-by: Nathan Cutler <ncutler@suse.cz>
---
  src/ceph-disk/ceph_disk/main.py | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ceph-disk/ceph_disk/main.py 
b/src/ceph-disk/ceph_disk/main.py
index d0ec596..a137967 100755
--- a/src/ceph-disk/ceph_disk/main.py
+++ b/src/ceph-disk/ceph_disk/main.py
@@ -406,7 +406,7 @@ def command(arguments, **kwargs):
      executable exists and raising a helpful error message
      if it does not.

-    .. note:: This should be the prefered way of calling 
``subprocess.Popen``
+    .. note:: This should be the preferred way of calling 
``subprocess.Popen``
      since it provides the caller with the safety net of making sure that
      executables *will* be found and will error nicely otherwise.

@@ -429,7 +429,7 @@ def command_check_call(arguments):
      Safely execute a ``subprocess.check_call`` call making sure that the
      executable exists and raising a helpful error message if it does not.

-    .. note:: This should be the prefered way of calling
+    .. note:: This should be the preferred way of calling
      ``subprocess.check_call`` since it provides the caller with the 
safety net
      of making sure that executables *will* be found and will error nicely
      otherwise.
