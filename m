From: Sage Weil <sage@newdream.net>
Subject: [PATCH 0/2] Reenable ceph dcache usage
Date: Wed, 11 Jan 2012 10:46:40 -0800
Message-ID: <1326307602-16284-1-git-send-email-sage@newdream.net>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: viro@ZenIV.linux.org.uk, hch@infradead.org
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

Hi Al, Christoph,

These two patches export d_find_any_alias() and reenable the Ceph use of 
the dcache for negative lookups and readdir without hitting the server.  
The behavior is controllable via a mount option (and now documented).

Unless there are any objections to the export, I plan to send this to 
Linus shortly.

Thanks!
sage


Sage Weil (2):
  vfs: export symbol d_find_any_alias()
  ceph: enable/disable dentry complete flags via mount option

 Documentation/filesystems/ceph.txt |   16 +++++++++++-----
 fs/ceph/dir.c                      |   25 ++++++++++++++++++++++---
 fs/ceph/super.c                    |   14 ++++++++++++++
 fs/ceph/super.h                    |    1 +
 fs/dcache.c                        |    4 ++--
 include/linux/dcache.h             |    1 +
 6 files changed, 51 insertions(+), 10 deletions(-)

