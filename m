From: Myungho Jung <mhjungk@gmail.com>
Subject: [PATCH] libceph: protect pending flags in ceph_con_keepalive()
Date: Thu, 27 Dec 2018 11:08:45 -0800
Message-ID: <20181227190842.GA19565@myunghoj-Precision-5530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

con_flag_test_and_set() sets CON_FLAG_KEEPALIVE_PENDING and
CON_FLAG_WRITE_PENDING flags without protection in ceph_con_keepalive().
It triggers WARN_ON() in clear_standby() if the flags are set after
con_fault() changes connection state to CON_STATE_STANDBY. Move
con_flag_test_and_set() to be called before releasing the lock and store
the condition to check after the critical section.

Reported-by: syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 net/ceph/messenger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2f126eff275d..e15da22d4f37 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3216,12 +3216,16 @@ void ceph_msg_revoke_incoming(struct ceph_msg *msg)
  */
 void ceph_con_keepalive(struct ceph_connection *con)
 {
+	bool pending;
+
 	dout("con_keepalive %p\n", con);
 	mutex_lock(&con->mutex);
 	clear_standby(con);
+	pending = (con_flag_test_and_set(con,
+					 CON_FLAG_KEEPALIVE_PENDING) == 0 &&
+		   con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0);
 	mutex_unlock(&con->mutex);
-	if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
-	    con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
+	if (pending)
 		queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_keepalive);
-- 
2.17.1
