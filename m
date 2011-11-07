From: Stratos Psomadakis <psomas@grnet.gr>
Subject: [PATCH] rbd: Document the rbd showmapped cmd
Date: Mon,  7 Nov 2011 11:24:35 +0200
Message-ID: <1320657875-23476-1-git-send-email-psomas@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:22540 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727Ab1KGJjz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 04:39:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Document the rbd showmapped cmd in rbd.usage(), and rbd's man page,
and add it to the bash completion script.

Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
---
 man/rbd.8               |    3 +++
 src/bash_completion/rbd |    2 +-
 src/rbd.cc              |    2 ++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/man/rbd.8 b/man/rbd.8
index f2eea70..63f00ef 100644
--- a/man/rbd.8
+++ b/man/rbd.8
@@ -135,6 +135,9 @@ Maps the specified image to a block device via the rbd kernel module.
 .TP
 .B \fBunmap\fP [\fIdevice\-path\fP]
 Unmaps the block device that was mapped via the rbd kernel module.
+.TP
+.B \fBshowmapped\fP 
+Show the rbd images that are mapped via the rbd kernel module.
 .UNINDENT
 .SH IMAGE NAME
 .sp
diff --git a/src/bash_completion/rbd b/src/bash_completion/rbd
index 5b6ec0e..549dc11 100644
--- a/src/bash_completion/rbd
+++ b/src/bash_completion/rbd
@@ -36,7 +36,7 @@ _rbd()
                 return 0
                 ;;
             *)
-                COMPREPLY=( $(compgen -W "ls list info create resize rm export import cp copy mv rename snap watch map unmap" -- ${cur}) )
+                COMPREPLY=( $(compgen -W "ls list info create resize rm export import cp copy mv rename snap watch map unmap showmapped" -- ${cur}) )
                 return 0
             ;;
         esac
diff --git a/src/rbd.cc b/src/rbd.cc
index 9757389..3945af6 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -83,6 +83,8 @@ void usage()
        << "                                            using the kernel\n"
        << "  unmap [device]                            unmap a rbd device that was\n"
        << "                                            mapped by the kernel\n"
+       << "  showmapped                                show the rbd images mapped\n"
+       << "                                            by the kernel\n"
        << "\n"
        << "Other input options:\n"
        << "  -p, --pool <pool>            source pool name\n"
-- 
1.7.2.5

