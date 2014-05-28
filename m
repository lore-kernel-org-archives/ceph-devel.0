From: mark.doffman@codethink.co.uk
Subject: [PATCH v3 0/2] Add ceph root filesystem
Date: Wed, 28 May 2014 14:53:36 -0500
Message-ID: <cover.1401306206.git.mark.doffman@codethink.co.uk>
References: <cover.1389806186.git.mark.doffman@codethink.co.uk>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:33365 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752789AbaE1TyA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 May 2014 15:54:00 -0400
In-Reply-To: <cover.1389806186.git.mark.doffman@codethink.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: Mark Doffman <mark.doffman@codethink.co.uk>

From: Mark Doffman <mark.doffman@codethink.co.uk>

Hi All,

The following is a third version of a patch series that adds the ability to use
a ceph distributed file system as the root device.

Changes from v2

* Typos and punctiation errors in documentation corrected.

Applies to v3.15-rc7-60-g2a0823f.

As mentioned since v2 the patch now accepts on the command line ipv6 addresses
and multiple monitor addresses.

Is this something Ceph guys are interested in?

Thanks

Mark

Mark Doffman (1):
  init: Add a new root device option, the Ceph file system

Rob Taylor (1):
  Documentation: Document the cephroot functionality

 Documentation/filesystems/{ => ceph}/ceph.txt |   0
 Documentation/filesystems/ceph/cephroot.txt   |  86 +++++++++++++
 fs/ceph/Kconfig                               |  10 ++
 fs/ceph/Makefile                              |   1 +
 fs/ceph/root.c                                | 176 ++++++++++++++++++++++++++
 include/linux/ceph/ceph_root.h                |  10 ++
 include/linux/root_dev.h                      |   1 +
 init/do_mounts.c                              |  32 ++++-
 net/ipv4/ipconfig.c                           |  10 +-
 9 files changed, 323 insertions(+), 3 deletions(-)
 rename Documentation/filesystems/{ => ceph}/ceph.txt (100%)
 create mode 100644 Documentation/filesystems/ceph/cephroot.txt
 create mode 100644 fs/ceph/root.c
 create mode 100644 include/linux/ceph/ceph_root.h

-- 
1.8.4

