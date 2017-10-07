From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ceph: Fix bool initialization/comparison
Date: Sat, 07 Oct 2017 16:02:21 +0200
Message-ID: <1507383097083-770412664-4-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/fs/ceph/caps.c b/fs/ceph/caps.c
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1711,7 +1711,7 @@ void ceph_check_caps(struct ceph_inode_i
 
 	/* if we are unmounting, flush any unused caps immediately. */
 	if (mdsc->stopping)
-		is_delayed = 1;
+		is_delayed = true;
 
 	spin_lock(&ci->i_ceph_lock);
 
@@ -3185,8 +3185,8 @@ static void handle_cap_flush_ack(struct
 	int dirty = le32_to_cpu(m->dirty);
 	int cleaned = 0;
 	bool drop = false;
-	bool wake_ci = 0;
-	bool wake_mdsc = 0;
+	bool wake_ci = false;
+	bool wake_mdsc = false;
 
 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
 		if (cf->tid == flush_tid)
