From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: librados2 and librbd1 dependency on libvirt-bin
Date: Wed, 25 Feb 2015 23:08:30 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0091.outbound.protection.outlook.com ([207.46.100.91]:44106
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753038AbbBYXIe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 18:08:34 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,
We are facing problem that ceph-deploy purge is uninstalling latest Mellanox ofed driver packages.
Digging down more we found libvirt-bin is dependent on librados2/librbd1.
So, here is what happening.

1. Mellanox ofed driver has a dependency on the libvirt-bin*

2. purging librados2/librbd1 is removing libvirt-bin and resulting the removal of the Mellanox driver package as well.

Here is what I found.

http://packages.ubuntu.com/trusty/devel/libvirt-bin

ubuntu@ip-10-15-16-211:~$ apt-cache rdepends librados2
librados2
Reverse Depends:
  librbd1
  ceph-common
  radosgw
  ceph
  python-ceph
  qemu-utils
  qemu-system-x86
  qemu-system-sparc
  qemu-system-ppc
  qemu-system-misc
  qemu-system-mips
  qemu-system-arm
  libvirt-bin
  ceph-test
  rbd-fuse
  radosgw
  qemu-utils
  qemu-system-x86
  qemu-system-sparc
  qemu-system-ppc
  qemu-system-misc
  qemu-system-mips
  qemu-system-arm
  python-ceph
  libvirt-bin
  librbd1
  librados2-dbg
  librados-dev
  ceph-common
  ceph
  ceph-test
  tgt
  rbd-fuse
  radosgw
  qemu-utils
  qemu-system-x86
  qemu-system-sparc
  qemu-system-ppc
  qemu-system-misc
  qemu-system-mips
  qemu-system-arm
  python-ceph
  libvirt-bin
  librbd1
  librados2-dbg
  librados-dev
  ceph-common
  ceph

So, I am curious why libvirt-bin has a depencey on librados2/librbd1 ?

Also, how come we get rid of this issue ?
Ceph-deploy should not remove any package other than ceph's.

Thanks & Regards
Somnath


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

