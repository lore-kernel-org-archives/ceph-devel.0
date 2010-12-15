From: Tracey Dent <tdent48227@gmail.com>
Subject: [PATCH][GIT PULL] Ceph: Makefile: Remove unnessary code
Date: Tue, 14 Dec 2010 19:32:37 -0500
Message-ID: <1292373157-2861-1-git-send-email-tdent48227@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45179 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0LOAc5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Dec 2010 19:32:57 -0500
Received: by iwn9 with SMTP id 9so1383989iwn.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Dec 2010 16:32:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org, Tracey Dent <tdent48227@gmail.com>

Hi Sage Weil,

You can either just take this patch out directly, or pull it from my
repo(or cherry-pick).

The following patch is in:

 git://github.com/Tdent48227/linux-2.6.git

   branch: next


 Tracey Dent (1):
     Ceph: Makefile: Remove unnessary code

----
 fs/ceph/Makefile |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)
---------------------------
commit  6fd6cfc9c920652d799c174aa4b2890e15aa232e
Author: Tracey Dent <tdent48227@gmail.com>
Date:   Tue 14 Dec 2010 18:41:06 -0500

    Ceph: Makefile: Remove unnessary code
    
    Remove the if and else conditional because the code is in mainline and there
    is no need in it being there.
    
    Also, Changed Makefile to use <modules>-y instead of <modules>-objs
    because -objs is deprecated and not mentioned in
    Documentation/kbuild/makefiles.txt.
    
    Signed-off-by: Tracey Dent <tdent48227@gmail.com>

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 9e6c4f2..bd35212 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -2,31 +2,10 @@
 # Makefile for CEPH filesystem.
 #
 
-ifneq ($(KERNELRELEASE),)
-
 obj-$(CONFIG_CEPH_FS) += ceph.o
 
-ceph-objs := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
+ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 	export.o caps.o snap.o xattr.o \
 	mds_client.o mdsmap.o strings.o ceph_frag.o \
 	debugfs.o
 
-else
-#Otherwise we were called directly from the command
-# line; invoke the kernel build system.
-
-KERNELDIR ?= /lib/modules/$(shell uname -r)/build
-PWD := $(shell pwd)
-
-default: all
-
-all:
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_CEPH_FS=m modules
-
-modules_install:
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_CEPH_FS=m modules_install
-
-clean:
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
-
-endif
-- 
1.7.3.3.489.g44430

