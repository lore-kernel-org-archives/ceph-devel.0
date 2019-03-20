From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH] ceph: Convert to fs_context
Date: Wed, 20 Mar 2019 14:49:56 +0000
Message-ID: <155309339693.2324.9941108136967815885.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com
List-Id: ceph-devel.vger.kernel.org


Here's a patch that converts ceph to use the new fs_context struct.  There
may be prerequisite commits in the branch detailed below.

The patch extends use of the parser infrastructure into libceph and rdb as
there's a shared parser.

This can be found in the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (1):
      ceph: Convert to fs_context


 drivers/block/rbd.c             |  362 +++++++++++---------
 fs/ceph/cache.c                 |    9 -
 fs/ceph/cache.h                 |    2 
 fs/ceph/super.c                 |  697 +++++++++++++++++++--------------------
 fs/ceph/super.h                 |    1 
 fs/fs_context.c                 |    2 
 fs/fs_parser.c                  |    2 
 include/linux/ceph/ceph_debug.h |    1 
 include/linux/ceph/libceph.h    |   17 +
 net/ceph/ceph_common.c          |  410 ++++++++++-------------
 10 files changed, 726 insertions(+), 777 deletions(-)
