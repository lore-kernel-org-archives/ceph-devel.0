From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [RFC PATCH v3 0/4] Improve Ceph Qemu+RBD support
Date: Thu, 20 Oct 2011 11:01:23 -0700
Message-ID: <cover.1319072460.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38041 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab1JTSBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 14:01:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, berrange@redhat.com

The current support for qemu and Ceph RBD (rados block device) has two
main deficiencies: authentication doesn't work, and it relies on
environment variables (which don't work with latest upstream). This
patch set addresses both those problems.

The first two patches update the xml schemas and conf to add a Ceph
secret type and to specify authentication information along with the
rbd disk.

The next patch passes virConnectPtr into the Domain{Attach,Detach}
methods (needed to access secrets while building the qemu command).

The final patch replaces the current RBD qemu code and uses the new
conf info to do authentication properly. We still need to make a
change there to avoid having the authentication key show up on qemu
command line (there are a few ways to do this, which will be discussed
in a separate email).

Changes from v2:
  make <auth> a direct child of <disk> instead of <source>
  allow secret lookup by UUID or usage
  test with fake secret driver
  other fixes from Daniel's review

Changes from v1:
  update docs/schemas/{domain,secret}.rng

Josh Durgin (1):
  storage: add auth to virDomainDiskDef

Sage Weil (3):
  secret: add Ceph secret type
  qemu: pass virConnectPtr into Domain{Attach,Detach}*
  qemu/rbd: improve rbd device specification

 docs/schemas/domaincommon.rng                      |   29 ++
 docs/schemas/secret.rng                            |   10 +
 include/libvirt/libvirt.h.in                       |    3 +
 src/Makefile.am                                    |    3 +-
 src/conf/domain_conf.c                             |  105 +++++++-
 src/conf/domain_conf.h                             |   17 ++
 src/conf/secret_conf.c                             |   23 ++-
 src/conf/secret_conf.h                             |    1 +
 src/qemu/qemu_command.c                            |  289 ++++++++++++--------
 src/qemu/qemu_command.h                            |    3 +-
 src/qemu/qemu_driver.c                             |   17 +-
 src/qemu/qemu_hotplug.c                            |   15 +-
 src/qemu/qemu_hotplug.h                            |    9 +-
 src/secret/secret_driver.c                         |    8 +
 .../qemuxml2argv-disk-drive-network-rbd-auth.args  |    6 +
 .../qemuxml2argv-disk-drive-network-rbd-auth.xml   |   37 +++
 .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
 tests/qemuxml2argvtest.c                           |   52 ++++
 18 files changed, 485 insertions(+), 148 deletions(-)
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.xml

