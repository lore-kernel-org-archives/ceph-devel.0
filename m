From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.9-rc9
Date: Fri,  9 Dec 2016 12:18:16 +0100
Message-ID: <1481282296-31456-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 3e5de27e940d00d8d504dfb96625fb654f641509:

  Linux 4.9-rc8 (2016-12-04 12:50:51 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.9-rc9

for you to fetch changes up to c3f4688a08fd86f1bf8e055724c84b7a40a09733:

  ceph: don't set req->r_locked_dir in ceph_d_revalidate (2016-12-08 14:32:16 +0100)

----------------------------------------------------------------
A fix for an issue with ->d_revalidate() in ceph, causing frequent
kernel crashes.  Marked for stable - it goes back to 4.6, but started
popping up only in 4.8.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: don't set req->r_locked_dir in ceph_d_revalidate

 fs/ceph/dir.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)
