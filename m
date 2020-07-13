From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/13] fscache: Rewrite 3: Make AFS use it
Date: Mon, 13 Jul 2020 17:36:56 +0100
Message-ID: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


Here's a set of patches that makes AFS use the fscache rewrite.

These patches can be found as part of the branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

David
---
David Howells (1):
      afs: Add O_DIRECT read support


 fs/9p/Kconfig                          |    2 +-
 fs/Makefile                            |    2 +-
 fs/afs/Kconfig                         |    1 +
 fs/afs/cache.c                         |   54 --
 fs/afs/cell.c                          |    9 +-
 fs/afs/dir.c                           |  242 +++++--
 fs/afs/file.c                          |  575 +++++++--------
 fs/afs/fs_operation.c                  |    4 +-
 fs/afs/fsclient.c                      |  154 ++--
 fs/afs/inode.c                         |   57 +-
 fs/afs/internal.h                      |   58 +-
 fs/afs/rxrpc.c                         |  150 ++--
 fs/afs/volume.c                        |    9 +-
 fs/afs/write.c                         |  413 +++++++----
 fs/afs/yfsclient.c                     |  113 ++-
 fs/cachefiles/Makefile                 |    3 +-
 fs/cachefiles/bind.c                   |   11 +-
 fs/cachefiles/content-map.c            |  476 ++++++++++++
 fs/cachefiles/daemon.c                 |   10 +-
 fs/cachefiles/interface.c              |  564 ++++++++-------
 fs/cachefiles/internal.h               |  139 ++--
 fs/cachefiles/io.c                     |  279 +++++++
 fs/cachefiles/main.c                   |   12 +-
 fs/cachefiles/namei.c                  |  508 +++++--------
 fs/cachefiles/rdwr.c                   |  974 -------------------------
 fs/cachefiles/xattr.c                  |  263 +++----
 fs/ceph/Kconfig                        |    2 +-
 fs/cifs/Kconfig                        |    2 +-
 fs/fscache/Kconfig                     |    8 +
 fs/fscache/Makefile                    |   10 +-
 fs/fscache/cache.c                     |  136 ++--
 fs/fscache/cookie.c                    |  769 ++++++++------------
 fs/fscache/dispatcher.c                |  150 ++++
 fs/fscache/fsdef.c                     |   56 +-
 fs/fscache/histogram.c                 |    2 +-
 fs/fscache/internal.h                  |  260 +++----
 fs/fscache/io.c                        |  201 +++++
 fs/fscache/main.c                      |   35 +-
 fs/fscache/netfs.c                     |   10 +-
 fs/fscache/obj.c                       |  345 +++++++++
 fs/fscache/object-list.c               |  129 +---
 fs/fscache/object.c                    | 1133 -----------------------------
 fs/fscache/object_bits.c               |  120 +++
 fs/fscache/operation.c                 |  633 ----------------
 fs/fscache/page.c                      | 1248 --------------------------------
 fs/fscache/proc.c                      |   13 +-
 fs/fscache/read_helper.c               |  688 ++++++++++++++++++
 fs/fscache/stats.c                     |  265 +++----
 fs/internal.h                          |    5 -
 fs/nfs/Kconfig                         |    2 +-
 fs/nfs/fscache-index.c                 |    4 +-
 fs/read_write.c                        |    1 +
 include/linux/fs.h                     |    2 +
 include/linux/fscache-cache.h          |  508 +++----------
 include/linux/fscache-obsolete.h       |   13 +
 include/linux/fscache.h                |  814 ++++++++-------------
 include/linux/mm.h                     |    1 +
 include/linux/pagemap.h                |   14 +
 include/linux/uio.h                    |   11 +
 include/net/af_rxrpc.h                 |    2 +-
 include/trace/events/afs.h             |   51 +-
 include/trace/events/cachefiles.h      |  285 ++++++--
 include/trace/events/fscache.h         |  421 ++---------
 include/trace/events/fscache_support.h |   91 +++
 lib/iov_iter.c                         |  286 +++++++-
 mm/filemap.c                           |   27 +-
 net/rxrpc/recvmsg.c                    |    9 +-
 67 files changed, 5598 insertions(+), 8246 deletions(-)
 create mode 100644 fs/cachefiles/content-map.c
 create mode 100644 fs/cachefiles/io.c
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 fs/fscache/dispatcher.c
 create mode 100644 fs/fscache/io.c
 create mode 100644 fs/fscache/obj.c
 delete mode 100644 fs/fscache/object.c
 create mode 100644 fs/fscache/object_bits.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 create mode 100644 fs/fscache/read_helper.c
 create mode 100644 include/linux/fscache-obsolete.h
 create mode 100644 include/trace/events/fscache_support.h
