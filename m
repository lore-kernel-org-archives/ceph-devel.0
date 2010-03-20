From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: handle kmalloc() failure
Date: Sat, 20 Mar 2010 15:30:16 +0300
Message-ID: <20100320123015.GA29929@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Return ERR_PTR(-ENOMEM) if kmalloc() fails.  We handle allocation 
failures the same way later in the function.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a260010..655b005 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -328,6 +328,8 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	struct ceph_mds_session *s;
 
 	s = kzalloc(sizeof(*s), GFP_NOFS);
+	if (!s)
+		return ERR_PTR(-ENOMEM);
 	s->s_mdsc = mdsc;
 	s->s_mds = mds;
 	s->s_state = CEPH_MDS_SESSION_NEW;
