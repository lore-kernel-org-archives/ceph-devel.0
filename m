From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 5.2-rc7
Date: Fri, 28 Jun 2019 17:17:24 +0200
Message-ID: <20190628151724.5642-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.2-rc7

for you to fetch changes up to d6b8bd679c9c8856fa04b80490765c43a4cb613b:

  ceph: fix ceph_mdsc_build_path to not stop on first component (2019-06-27 18:27:36 +0200)

----------------------------------------------------------------
A small fix for a potential -rc1 regression from Jeff.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: fix ceph_mdsc_build_path to not stop on first component

 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
