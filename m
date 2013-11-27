From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 0/2] ceph: Add clean up if invalid osd reply received
Date: Wed, 27 Nov 2013 22:28:12 +0800
Message-ID: <cover.1385561919.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Li Wang (2):
  ceph: Clean up if error occurred in finish_read()
  ceph: Add necessary clean up if invalid reply received in
    handle_reply()

 fs/ceph/addr.c        |    3 +++
 net/ceph/osd_client.c |    7 +++++++
 2 files changed, 10 insertions(+)

-- 
1.7.9.5
