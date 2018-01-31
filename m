From: jlayton@poochiereds.net
Subject: [nfs-ganesha RFC PATCH 0/6] experimental rados_cluster recovery backend
Date: Wed, 31 Jan 2018 09:12:13 -0500
Message-ID: <20180131141219.16929-1-jlayton@poochiereds.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753184AbeAaOMY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:12:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nfs-ganesha-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

This is a very rough and early draft of a clustered recovery backend
built on top of a shared RADOS object. To be clear, this is not at all
ready for merge, but should serve as a basis for further development.
The intended use case here is allowing loosely-aggregated, parallel
ganesha servers to run on top of cephfs.

One of the cases we have to handle is recovery from a catastrophic
outage that takes out all the clustered ganeshas + the ceph MDSs, but
leaves some subset of clients running. Once we bring the cluster back
up, and start the NFS servers, the clients will attempt to reconnect and
reestablish their state to the individual servers. During this period,
no server in the cluster can allow the establishment of new state. All
servers must continue to enforce the grace period until no server in the
cluster is still allowing recovery.

This patchset extends the recovery_backend interface to hook in the
grace period management as well. This allows us to do more involved
things when starting the local grace period (like joining an existing
cluster-wide grace period), and to gate the lifting of the local grace
period on whether any other node in the cluster still requires it.

For now, if any node in the cluster crashes, this implementation
requires that you manually declare a new grace period (using an included
command-line tool), and restart the whole set of servers when bringing
it back up.

We have some (handwavy) plans to improve that by allowing a ganesha
server to reclaim ceph state it held earlier.  That's just vaporware at
this point, but the code is designed in such a way that we should be
able to plug that in later.

Comments and suggestions welcome.

Jeff Layton (6):
  SAL: make some rados_kv symbols public
  SAL: add new try_lift_grace recovery operation
  SAL: add nodeid config value to RADOS_KV section
  support: add a rados_grace support library
  tools: add new rados_grace manipulation tool
  SAL: add new clustered RADOS recovery backend

 src/SAL/CMakeLists.txt                    |   3 +-
 src/SAL/nfs4_recovery.c                   |  29 +-
 src/SAL/recovery/recovery_fs.c            |   1 +
 src/SAL/recovery/recovery_fs_ng.c         |   1 +
 src/SAL/recovery/recovery_rados.h         |  11 +
 src/SAL/recovery/recovery_rados_cluster.c | 203 ++++++++++++++
 src/SAL/recovery/recovery_rados_kv.c      |  13 +-
 src/SAL/recovery/recovery_rados_ng.c      |   5 +-
 src/config_samples/config.txt             |   2 +
 src/doc/man/ganesha-core-config.rst       |   4 +
 src/include/rados_grace.h                 |  33 +++
 src/include/sal_functions.h               |   3 +
 src/support/CMakeLists.txt                |   4 +
 src/support/rados_grace.c                 | 441 ++++++++++++++++++++++++++++++
 src/tools/CMakeLists.txt                  |   4 +
 src/tools/rados_grace_tool.c              | 211 ++++++++++++++
 16 files changed, 957 insertions(+), 11 deletions(-)
 create mode 100644 src/SAL/recovery/recovery_rados_cluster.c
 create mode 100644 src/include/rados_grace.h
 create mode 100644 src/support/rados_grace.c
 create mode 100644 src/tools/rados_grace_tool.c

-- 
2.14.3

