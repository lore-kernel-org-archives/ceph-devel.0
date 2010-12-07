From: Josh Durgin <joshd@hq.newdream.net>
Subject: [PATCH 0/2] rbd network disk support
Date: Tue, 07 Dec 2010 11:54:46 -0800
Message-ID: <4CFE9106.8050105@hq.newdream.net>
References: <20101202131928.GV2502@redhat.com> <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59477 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0LGTyt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 14:54:49 -0500
In-Reply-To: <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, sheepdog@lists.wpkg.org

Here are patches on top of Kazutaka's v2 to add RBD support and fix
some general network disk problems. There's also a test for each type
of network disk.

Josh Durgin (2):
  qemu: Add RBD support and some network disk fixes
  tests: Add tests for network disks

 docs/schemas/domain.rng                            |   11 ++-
 src/conf/domain_conf.c                             |   25 +++-
 src/conf/domain_conf.h                             |    1 +
 src/qemu/qemu_conf.c                               |  143 ++++++++++++++++++--
 tests/qemuargv2xmltest.c                           |    3 +
 .../qemuxml2argv-disk-drive-network-nbd.args       |    1 +
 .../qemuxml2argv-disk-drive-network-nbd.xml        |   32 +++++
 .../qemuxml2argv-disk-drive-network-rbd.args       |    1 +
 .../qemuxml2argv-disk-drive-network-rbd.xml        |   34 +++++
 .../qemuxml2argv-disk-drive-network-sheepdog.args  |    1 +
 .../qemuxml2argv-disk-drive-network-sheepdog.xml   |   32 +++++
 tests/qemuxml2argvtest.c                           |    6 +
 12 files changed, 275 insertions(+), 15 deletions(-)
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.xml
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.xml


