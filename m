From: Amon Ott <ao@m-privacy.de>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Tue, 06 Nov 2012 08:54:09 +0100
Message-ID: <5098C221.4050809@m-privacy.de>
References: <201205290944.33983.a.ott@m-privacy.de> <Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net> <201205300908.56991.a.ott@m-privacy.de> <201206011135.38119.a.ott@m-privacy.de> <20121105201730.723eb457.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040505000103050502010105"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:45290 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633Ab2KFIAm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Nov 2012 03:00:42 -0500
In-Reply-To: <20121105201730.723eb457.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8gTWFydGlucw==?= <ctpm@ist.utl.pt>
Cc: Amon Ott <a.ott@m-privacy.de>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505000103050502010105
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 05.11.2012 21:17, schrieb Cláudio Martins:
> 
> On Fri, 1 Jun 2012 11:35:37 +0200 Amon Ott <a.ott@m-privacy.de> wrote:
>>
>> After backporting syncfs() support into Debian stable libc6 2.11 and 
>> recompiling Ceph with it, our test cluster is now running with syncfs().
>>
> 
>  Hi,
> 
>  We're running OSDs on top of Debian wheezy, which unfortunately has
> libc6 2.13. By chance, do you still have that patch to backport syncfs()?

Here is the patch we use for Debian Squeeze, it should be easy to port
to Wheezy. The original patch header is still there, but we made small
changes for the other libc version. If you need help, please tell me.

Amon Ott
-- 
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am Köllnischen Park 1    Fax: +49 30 99296856
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Geschäftsführer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649


--------------040505000103050502010105
Content-Type: text/x-patch;
 name="syncfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="syncfs.diff"

From libc-hacker-return-9689-listarch-libc-hacker=sources dot redhat dot com at sourceware dot org Wed Mar 30 11:44:46 2011
Return-Path: <libc-hacker-return-9689-listarch-libc-hacker=sources dot redhat dot com at sourceware dot org>
Delivered-To: listarch-libc-hacker at sources dot redhat dot com
Received: (qmail 9777 invoked by alias); 30 Mar 2011 11:44:46 -0000
Received: (qmail 9761 invoked by uid 22791); 30 Mar 2011 11:44:45 -0000
X-SWARE-Spam-Status: No, hits=-6.1 required=5.0
	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,TW_FX,TW_MK,TW_TD,TW_XM,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)
    by sourceware dot org (qpsmtpd/0 dot 43rc1) with ESMTP; Wed, 30 Mar 2011 11:44:35 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1 dot redhat dot com (8 dot 14 dot 4/8 dot 14 dot 4) with ESMTP id p2UBiZJp016689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <libc-hacker at sourceware dot org>; Wed, 30 Mar 2011 07:44:35 -0400
Received: from hase (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx10 dot intmail dot prod dot int dot phx2 dot redhat dot com (8 dot 14 dot 4/8 dot 14 dot 4) with ESMTP id p2UBiYG9015254
	for <libc-hacker at sourceware dot org>; Wed, 30 Mar 2011 07:44:34 -0400
From: Andreas Schwab <schwab at redhat dot com>
To: libc-hacker at sourceware dot org
Subject: [PATCH] Add syncfs syscall
X-Yow: Hey, LOOK!!  A pair of SIZE 9 CAPRI PANTS!!  They probably belong to
 SAMMY DAVIS, JR dot !!
Date: Wed, 30 Mar 2011 13:44:34 +0200
Message-ID: <m3ei5osuhp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Mailing-List: contact libc-hacker-help at sourceware dot org; run by ezmlm
Precedence: bulk
List-Id: <libc-hacker.sourceware.org>
List-Subscribe: <mailto:libc-hacker-subscribe at sourceware dot org>
List-Archive: <http://sourceware.org/ml/libc-hacker/>
List-Post: <mailto:libc-hacker at sourceware dot org>
List-Help: <mailto:libc-hacker-help at sourceware dot org>, <http://sourceware dot org/ml/#faqs>
Sender: libc-hacker-owner at sourceware dot org
Delivered-To: mailing list libc-hacker at sourceware dot org

2011-03-30  Andreas Schwab  <schwab@redhat.com>

	* Versions.def (libc): Add GLIBC_2.14.
	* misc/syncfs.c: New file.
	* misc/Makefile (routines): Add syncfs.
	* posix/unistd.h: Declare syncfs.
	* sysdeps/unix/syscalls.list: Add syncfs.
---
 Versions.def               |    1 +
 misc/Makefile              |    4 ++--
 misc/Versions              |    3 +++
 misc/syncfs.c              |   33 +++++++++++++++++++++++++++++++++
 posix/unistd.h             |    9 ++++++++-
 sysdeps/unix/syscalls.list |    1 +
 6 files changed, 48 insertions(+), 3 deletions(-)
 create mode 100644 misc/syncfs.c

diff --git a/Versions.def b/Versions.def
index 0ccda50..e478fdd 100644
--- a/Versions.def
+++ b/Versions.def
@@ -30,5 +30,6 @@ libc {
   GLIBC_2.11
   GLIBC_2.12
+  GLIBC_2.14
 %ifdef USE_IN_LIBIO
   HURD_CTHREADS_0.3
 %endif
diff --git a/misc/Makefile b/misc/Makefile
index ee69361..52b13da 100644
--- a/misc/Makefile
+++ b/misc/Makefile
@@ -1,4 +1,4 @@
-# Copyright (C) 1991-2006, 2007, 2009 Free Software Foundation, Inc.
+# Copyright (C) 1991-2006, 2007, 2009, 2011 Free Software Foundation, Inc.
 # This file is part of the GNU C Library.
 
 # The GNU C Library is free software; you can redistribute it and/or
@@ -45,7 +45,7 @@ routines := brk sbrk sstk ioctl \
 	    getdtsz \
 	    gethostname sethostname getdomain setdomain \
 	    select pselect \
-	    acct chroot fsync sync fdatasync reboot \
+	    acct chroot fsync sync fdatasync syncfs reboot \
 	    gethostid sethostid \
 	    vhangup \
 	    swapon swapoff mktemp mkstemp mkstemp64 mkdtemp \
diff --git a/misc/Versions b/misc/Versions
index 3ffe3d1..3a31c7f 100644
--- a/misc/Versions
+++ b/misc/Versions
@@ -143,4 +143,7 @@ libc {
   GLIBC_2.11 {
     mkstemps; mkstemps64; mkostemps; mkostemps64;
   }
+  GLIBC_2.14 {
+    syncfs;
+  }
 }
diff --git a/misc/syncfs.c b/misc/syncfs.c
new file mode 100644
index 0000000..bd7328c
--- /dev/null
+++ b/misc/syncfs.c
@@ -0,0 +1,33 @@
+/* Copyright (C) 2011 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <unistd.h>
+
+/* Make all changes done to all files on the file system associated
+   with FD actually appear on disk.  */
+int
+syncfs (int fd)
+{
+  __set_errno (ENOSYS);
+  return -1;
+}
+
+
+stub_warning (syncfs)
+#include <stub-tag.h>
diff --git a/posix/unistd.h b/posix/unistd.h
index 5ebcaf1..aa11860 100644
--- a/posix/unistd.h
+++ b/posix/unistd.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 1991-2006, 2007, 2008, 2009 Free Software Foundation, Inc.
+/* Copyright (C) 1991-2009, 2010, 2011 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -974,6 +974,13 @@ extern int fsync (int __fd);
 #endif /* Use BSD || X/Open || Unix98.  */
 
 
+#ifdef __USE_GNU
+/* Make all changes done to all files on the file system associated
+   with FD actually appear on disk.  */
+extern int syncfs (int __fd) __THROW;
+#endif
+
+
 #if defined __USE_BSD || defined __USE_XOPEN_EXTENDED
 
 /* Return identifier for the current host.  */
diff --git a/sysdeps/unix/syscalls.list b/sysdeps/unix/syscalls.list
index 04ed63c..ad49170 100644
--- a/sysdeps/unix/syscalls.list
+++ b/sysdeps/unix/syscalls.list
@@ -55,6 +55,7 @@ swapoff		-	swapoff		i:s	swapoff
 swapon		-	swapon		i:s	swapon
 symlink		-	symlink		i:ss	__symlink	symlink
 sync		-	sync		i:	sync
+syncfs		-	syncfs		i:i	syncfs
 sys_fstat	fxstat	fstat		i:ip	__syscall_fstat
 sys_mknod	xmknod	mknod		i:sii	__syscall_mknod
 sys_stat	xstat	stat		i:sp	__syscall_stat
-- 
1.7.4


-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."


--------------040505000103050502010105--
