From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for -rc4
Date: Mon, 29 Oct 2012 08:43:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210290841250.18873@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are two fixes in the messenger code, one that can trigger a NULL 
dereference, and one that error in refcounting (extra put).  There is also 
a trivial fix that in the fs client code that is triggered by NFS 
reexport.

Thanks!
sage


----------------------------------------------------------------
Alex Elder (1):
      rbd: reset BACKOFF if unable to re-queue

David Zafman (1):
      ceph: fix dentry reference leak in encode_fh()

Sage Weil (1):
      libceph: avoid NULL kref_put when osd reset races with alloc_msg

 fs/ceph/export.c     |    2 ++
 net/ceph/messenger.c |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)
