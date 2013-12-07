From: Mikhail Campos Guadamuz <plageat90@gmail.com>
Subject: [PATCH 2/2] No mds mount error print
Date: Sat,  7 Dec 2013 14:00:34 -0500
Message-ID: <1386442834-4372-1-git-send-email-plageat90@gmail.com>
References: <1b8c4b9c49deb956e9d065b0677bfeaf17c968d2.1386442053.git.plageat90@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:37331 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab3LGLBs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Dec 2013 06:01:48 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so710486eek.8
        for <ceph-devel@vger.kernel.org>; Sat, 07 Dec 2013 03:01:47 -0800 (PST)
In-Reply-To: <1b8c4b9c49deb956e9d065b0677bfeaf17c968d2.1386442053.git.plageat90@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mikhail Campos Guadamuz <plageat90@gmail.com>

For http://tracker.ceph.com/issues/4386

We can handle ECOMM error returning by ceph kernel client
for printing understandable message about missing
active MDS state

Signed-off-by: Mikhail Campos Guadamuz <plageat90@gmail.com>
---
 src/mount/mount.ceph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/mount/mount.ceph.c b/src/mount/mount.ceph.c
index 5bbedd0..3ade629 100755
--- a/src/mount/mount.ceph.c
+++ b/src/mount/mount.ceph.c
@@ -358,6 +358,9 @@ int main(int argc, char *argv[])
 		case ENODEV:
 			printf("mount error: ceph filesystem not supported by the system\n");
 			break;
+		case ECOMM:
+			printf("mount error: can't find active mds\n");
+			break;
 		default:
 			printf("mount error %d = %s\n",errno,strerror(errno));
 		}
-- 
1.8.3.1

