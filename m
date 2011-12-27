From: Florian Haas <florian@hastexo.com>
Subject: [PATCH] init script: be LSB compliant for exit code on status
Date: Tue, 27 Dec 2011 11:43:47 +0100
Message-ID: <1324982627-9520-2-git-send-email-florian@hastexo.com>
References: <1324982627-9520-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50476 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab1L0KoG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Dec 2011 05:44:06 -0500
Received: by eekc4 with SMTP id c4so11561064eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Dec 2011 02:44:05 -0800 (PST)
In-Reply-To: <1324982627-9520-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

An exit code of 1 on status is defined in LSB as
"program is dead, but pid file exists". Check for existence
of this pid file, and only set the exit status 1 if it's still there.
Set it to 3 ("program is not running") otherwise.

Reference: http://refspecs.linuxbase.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html

Signed-off-by: Florian Haas <florian@hastexo.com>
---
 src/init-ceph.in |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 0a70cd7..701701f 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -297,9 +297,14 @@ for name in $what; do
 	status)
 	    if daemon_is_running $name ceph-$type $id $pid_file; then
                 echo "$name: running..."
-            else
+            elif [ -e "$pid_file" ]; then
+                # daemon is dead, but pid file still exists
                 echo "$name: dead."
                 EXIT_STATUS=1
+            else
+                # daemon is dead, and pid file is gone
+                echo "$name: not running."
+                EXIT_STATUS=3
             fi
 	    ;;
 
-- 
1.7.5.4

