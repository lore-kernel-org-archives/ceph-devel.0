From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Infiniband 40GB
Date: Mon, 4 Jun 2012 11:47:22 +0200
Message-ID: <201206041147.22993.a.ott@m-privacy.de>
References: <4FCB1C0A.4050504@profihost.ag> <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com> <4FCC7E34.7040005@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qQIzPAJdx72rU0f"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:54620 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756706Ab2FDJrg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jun 2012 05:47:36 -0400
In-Reply-To: <4FCC7E34.7040005@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel@vger.kernel.org

--Boundary-00=_qQIzPAJdx72rU0f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 June 2012 you wrote:
> Le 04/06/2012 10:23, Stefan Majer a =E9crit :
> > Hi Hannes,
> >
> > our production environment is running on 10GB infrastructure. We had a
> > lot of troubles till we got to where we are today.
> > We use Intel X520 D2 cards on our OSD=B4s and nexus switch
> > infrastructure. All other cards we where testing failed horrible.
>
> we have Intel Corporation 82599EB 10 Gigabit Dual Port Backplane
> Connection (rev 01)... Don't know the 'commercial name'. ixgbe driver.
>
> > Some of the problems we encountered have been:
> > - page allocation failures in the ixgbe driver --> fixed in upstream
> > - problems with jumbo frames, we had to disable tso, gro, lro -- >
> > this is the most obscure thing
> > - various tuning via sysctl in the net.tcp and net.ipv4 area --> this
> > was also the outcome of stefan=B4s benchmarking odysee.
>
> some tuning we made :
>
> -> Turning off Virtualisation extension in BIOS. Don't know why, but it
> gaves us crappy performance. We usually put it on, because we use KVM a
> lot. In our case, OSD are in bare metal and disabling virtualisation
> extension gives us a very big boost.
> It may be a BIOS bug in our machines (DELL M610).
>
> -> One of my colleague played with receive flow steeting ; the intel
> card supports multi queue, so it seems we can gain a little with it :
>
> !/bin/sh
>
> for x in $(seq 0 23); do echo FFFFFFFF >
> /sys/class/net/eth2/queues/rx-${x}/rps_cpus; done
> echo 16384 > /proc/sys/net/core/rps_sock_flow_entries
> for x in $(seq 0 23); do echo 16384 >
> /sys/class/net/eth2/queues/rx-${x}/rps_flow_cnt; done
>
> > But after all this we a quite happy actully and are only limited by
> > the speed of the drives (2TB SATA).
> > The fsync is a fdatasync in fact which is available in newer glibc. If
> > you dont use btrfs (we use xfs) you need to use a recent glibc with
> > fdatasync support.
>
> Does it may explain why we see loosy performance with xfs right now ?
> That the main reason we're stuck with btrfs for the moment.
>
> we're using debian 'stable' : libc is
> libc6                                   2.11.3-3
> probably too old ?

One reason for performance problems with that libc6 version is missing=20
syncfs() support. I backported a patch for 2.13, originally by Andreas=20
Schwab, schwab@redhat.com, to Debian stable code. Patch is attached.

Copy the patch to eglibc's debian/patches/, add to debian/patches/series,=20
rebuild eglibc packages (including libc6) with dpkg-buildpackage, install n=
ew=20
libc6-dev, rebuild ceph packages against it, install and retry. AFAIK, not=
=20
even libc6 in Debian experimental has syncfs() support.

Also see thread "OSD deadlock with cephfs client and OSD on same machine"

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_qQIzPAJdx72rU0f
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="syncfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syncfs.diff"

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



--Boundary-00=_qQIzPAJdx72rU0f--
