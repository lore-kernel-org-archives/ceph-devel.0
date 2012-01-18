From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] Convert mount.ceph to use KEY_SPEC_PROCESS_KEYRING
Date: Wed, 18 Jan 2012 12:00:14 -0500
Message-ID: <1326906014-20896-1-git-send-email-nhorman@tuxdriver.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:43316 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214Ab2ARRA2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 12:00:28 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Neil Horman <nhorman@tuxdriver.com>, Josh Durgin <josh.durgin@dreamhost.com>

having mount.ceph use KEY_SPEC_USER_KEYRING to pass keys to the kernel has
several disadvantages:

1) It leaves the key setting in the uid_keyring, which is reachable from the
session keyring via a link (see keyctl list <root session keyring ref>).  This
means its accessible to other processes in the same session that don't need
access to it, even after the kernel is done with it.

2) The user keyring has some very counter-intuitive semantics as far as keyring
permissions goes.  The user keyring is access via a link from the session
keyring, which a process may not have permission to access in some situations.
For instance if mount.ceph is executed via su without having started a new
session, mount.ceph will not have access to the uid keyring unless the calling
proces (in this case su) has granted access permission.  The result is a -EPERM
error when executing mount.ceph to a cephx enabled server.  If the same command
is attempted in a new root session (e.g. su - or su -l), the mount command will
work fine

Switching the mount.ceph command to use the KEY_SPEC_PROCESS_KEYRING solves both
of these problems.  By using this keyring, accessibility is guaranteed because
its added and accessed in the same process context both in user space and the
kernel, assuring aceesability, despite the session specifics.  It also ensures
that the key will get cleaned up after the mount.ceph process exits
automatically, since there is no longer a need for it (the kernel clones the key
during the mount process and releases it on unmount).

I've tested this here on my local ceph cluster, and it works properly under both
su and su -l .

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Josh Durgin <josh.durgin@dreamhost.com>
---
 src/common/secret.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/common/secret.c b/src/common/secret.c
index 70c8794..365782f 100644
--- a/src/common/secret.c
+++ b/src/common/secret.c
@@ -65,7 +65,7 @@ static int set_kernel_secret(const char *secret, const char *key_name)
     return ret;
   }
 
-  serial = add_key("ceph", key_name, payload, sizeof(payload), KEY_SPEC_USER_KEYRING);
+  serial = add_key("ceph", key_name, payload, sizeof(payload), KEY_SPEC_PROCESS_KEYRING);
   if (serial == -1) {
     ret = -errno;
   }
-- 
1.7.7.5

