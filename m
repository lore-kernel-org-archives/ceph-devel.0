From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 13/63] ceph: reconnect connection if session hang in opening state
Date: Tue,  1 Oct 2019 12:40:35 -0400
Message-ID: <20191001164125.15398-13-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Erqi Chen <chenerqi@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Erqi Chen <chenerqi@gmail.com>

[ Upstream commit 71a228bc8d65900179e37ac309e678f8c523f133 ]

If client mds session is evicted in CEPH_MDS_SESSION_OPENING state,
mds won't send session msg to client, and delayed_work skip
CEPH_MDS_SESSION_OPENING state session, the session hang forever.

Allow ceph_con_keepalive to reconnect a session in OPENING to avoid
session hang. Also, ensure that we skip sessions in RESTARTING and
REJECTED states since those states can't be resurrected by issuing
a keepalive.

Link: https://tracker.ceph.com/issues/41551
Signed-off-by: Erqi Chen chenerqi@gmail.com
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c8a9b89b922d7..b8e268e6add27 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4033,7 +4033,9 @@ static void delayed_work(struct work_struct *work)
 				pr_info("mds%d hung\n", s->s_mds);
 			}
 		}
-		if (s->s_state < CEPH_MDS_SESSION_OPEN) {
+		if (s->s_state == CEPH_MDS_SESSION_NEW ||
+		    s->s_state == CEPH_MDS_SESSION_RESTARTING ||
+		    s->s_state == CEPH_MDS_SESSION_REJECTED) {
 			/* this mds is failed or recovering, just wait */
 			ceph_put_mds_session(s);
 			continue;
-- 
2.20.1
