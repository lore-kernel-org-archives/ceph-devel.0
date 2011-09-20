From: Sage Weil <sage@newdream.net>
Subject: [PATCH 0/5 v2] Improve Ceph Qemu+RBD support
Date: Mon, 19 Sep 2011 21:13:38 -0700
Message-ID: <1316492023-17749-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36840 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab1ITENt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 00:13:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, veillard@redhat.com, Sage Weil <sage@newdream.net>

The current support for qemu and Ceph RBD (rados block device) has two 
main deficiencies: authentication doesn't work, and it relies on 
environment variables (which don't work with latest upstream). This 
patch set addresses both those problems.

The first two patches update the xml schemas and conf to add a Ceph 
secret type and to specify authentication information along with the rbd 
disk.

The next two patches make some libvirt changes.  We pass virConnectPtr 
down into the Domain{Attach,Detach} methods (needed to access secrets 
while building the qemu command), and add a helper that will escape 
arbitrary characters.

The final patch replaces the current RBD qemu code and uses the new conf 
info to do authentication properly.  (We still need to make a change 
there to avoid having the authentication key show up on qemu command 
line; I'll clean that up shortly.)

Comments on this approach?

Thanks!
sage


Changes from v1:
  update docs/schemas/{domain,secret}.rng

Sage Weil (5):
  secret: add Ceph secret type
  storage: add authId, authDomain to virDomainDiskDef
  qemu: pass virConnectPtr into Domain{Attach,Detach}*
  buf: implement generic virBufferEscape
  qemu/rbd: improve rbd device specification

 docs/schemas/domain.rng                            |    6 +
 docs/schemas/secret.rng                            |   17 ++
 include/libvirt/libvirt.h.in                       |    3 +
 src/conf/domain_conf.c                             |   43 +++-
 src/conf/domain_conf.h                             |    2 +
 src/conf/secret_conf.c                             |   45 ++++-
 src/conf/secret_conf.h                             |    1 +
 src/libvirt_private.syms                           |    1 +
 src/qemu/qemu_command.c                            |  273 +++++++++++---------
 src/qemu/qemu_command.h                            |    3 +-
 src/qemu/qemu_driver.c                             |   17 +-
 src/qemu/qemu_hotplug.c                            |   15 +-
 src/qemu/qemu_hotplug.h                            |    9 +-
 src/secret/secret_driver.c                         |    8 +
 src/util/buf.c                                     |   33 ++-
 src/util/buf.h                                     |    1 +
 .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
 .../qemuxml2argv-disk-drive-network-rbd.xml        |    1 +
 18 files changed, 328 insertions(+), 156 deletions(-)

-- 
1.7.4.1

From 498cd06b76bbb4415a2f81f9d169f267ff99329c Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Thu, 15 Sep 2011 13:47:40 -0700
Subject: [PATCH 0/5] Improve Ceph Qemu+RBD support

The current support for qemu and Ceph RBD (rados block device) has two 
main deficiencies: authentication doesn't work, and it relies on 
environment variables (which don't work with latest upstream).

This patch set addresses both those problems, while trying to integrate as
cleanly as possible with the rest of libvirt.

The first few patches make some changes to libvirt itself: adding a CEPH 
secret type (for Ceph/RBD authentication), adding authentication fields 
to the XML schema, passing the virConnectPtr into the 
Domain{Attach,Detach} methods (needed to access secrets while building 
the qemu command), a helper that will escape arbitrary characters, and 
finally a patch that replaces the current RBD qemu code.

Comments on this approach?

Thanks!
sage


Sage Weil (5):
  secret: add Ceph secret type
  storage: add authId, authDomain to virDomainDiskDef
  qemu: pass virConnectPtr into Domain{Attach,Detach}*
  buf: implement generic virBufferEscape
  qemu/rbd: improve rbd device specification

 include/libvirt/libvirt.h.in                       |    3 +
 src/conf/domain_conf.c                             |   43 +++-
 src/conf/domain_conf.h                             |    2 +
 src/conf/secret_conf.c                             |   45 ++++-
 src/conf/secret_conf.h                             |    1 +
 src/libvirt_private.syms                           |    1 +
 src/qemu/qemu_command.c                            |  273 +++++++++++---------
 src/qemu/qemu_command.h                            |    3 +-
 src/qemu/qemu_driver.c                             |   17 +-
 src/qemu/qemu_hotplug.c                            |   15 +-
 src/qemu/qemu_hotplug.h                            |    9 +-
 src/secret/secret_driver.c                         |    8 +
 src/util/buf.c                                     |   33 ++-
 src/util/buf.h                                     |    1 +
 .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
 .../qemuxml2argv-disk-drive-network-rbd.xml        |    1 +
 16 files changed, 305 insertions(+), 156 deletions(-)

-- 
1.7.4.1

