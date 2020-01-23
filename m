From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 5.5-rc8
Date: Thu, 23 Jan 2020 18:36:29 +0100
Message-ID: <20200123173629.18402-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.5-rc8

for you to fetch changes up to 9c1c2b35f1d94de8325344c2777d7ee67492db3b:

  ceph: hold extra reference to r_parent over life of request (2020-01-21 19:02:37 +0100)

----------------------------------------------------------------
A fix for a potential use-after-free from Jeff, marked for stable.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: hold extra reference to r_parent over life of request

 fs/ceph/mds_client.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
