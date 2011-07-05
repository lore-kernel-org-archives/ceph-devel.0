From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 3.0
Date: Tue, 5 Jul 2011 12:54:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107051250370.5147@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

These are all related to issues with O_DIRECT when the pointer and IO 
alignments do not match, and/or when there are holes in the file.

Thanks!
sage


Sage Weil (3):
      ceph: fix page alignment corrections
      libceph: fix page calculation for non-page-aligned io
      ceph: fix sync and dio writes across stripe boundaries

 fs/ceph/file.c        |   14 ++++++--------
 net/ceph/osd_client.c |   10 ++++++----
 2 files changed, 12 insertions(+), 12 deletions(-)
