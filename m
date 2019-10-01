From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 13/71] ceph: fetch cap_gen under spinlock in ceph_add_cap
Date: Tue,  1 Oct 2019 12:38:23 -0400
Message-ID: <20191001163922.14735-13-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 606d102327a45a49d293557527802ee7fbfd7af1 ]

It's protected by the s_gen_ttl_lock, so we should fetch under it
and ensure that we're using the same generation in both places.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ce0f5658720ab..8fd5301128106 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -645,6 +645,7 @@ void ceph_add_cap(struct inode *inode,
 	struct ceph_cap *cap;
 	int mds = session->s_mds;
 	int actual_wanted;
+	u32 gen;
 
 	dout("add_cap %p mds%d cap %llx %s seq %d\n", inode,
 	     session->s_mds, cap_id, ceph_cap_string(issued), seq);
@@ -656,6 +657,10 @@ void ceph_add_cap(struct inode *inode,
 	if (fmode >= 0)
 		wanted |= ceph_caps_for_mode(fmode);
 
+	spin_lock(&session->s_gen_ttl_lock);
+	gen = session->s_cap_gen;
+	spin_unlock(&session->s_gen_ttl_lock);
+
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
 		cap = *new_cap;
@@ -681,7 +686,7 @@ void ceph_add_cap(struct inode *inode,
 		list_move_tail(&cap->session_caps, &session->s_caps);
 		spin_unlock(&session->s_cap_lock);
 
-		if (cap->cap_gen < session->s_cap_gen)
+		if (cap->cap_gen < gen)
 			cap->issued = cap->implemented = CEPH_CAP_PIN;
 
 		/*
@@ -775,7 +780,7 @@ void ceph_add_cap(struct inode *inode,
 	cap->seq = seq;
 	cap->issue_seq = seq;
 	cap->mseq = mseq;
-	cap->cap_gen = session->s_cap_gen;
+	cap->cap_gen = gen;
 
 	if (fmode >= 0)
 		__ceph_get_fmode(ci, fmode);
-- 
2.20.1
