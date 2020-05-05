From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: demote quotarealm lookup warning to a debug message
Date: Tue, 5 May 2020 13:59:02 +0100
Message-ID: <20200505125902.GA10381@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

A misconfigured cephx can easily result in having the kernel client
flooding the logs with:

  ceph: Can't lookup inode 1 (err: -13)

Change his message to debug level.

Link: https://tracker.ceph.com/issues/44546
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
Hi!

This patch should fix some harmless warnings when using cephx to restrict
users access to certain filesystem paths.  I've added a comment to the
tracker where removing this warning could result (unlikely, IMHO!) in an
admin to miss not-so-harmless bogus configurations.

Cheers,
--
Luís

 fs/ceph/quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index de56dee60540..19507e2fdb57 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -159,8 +159,8 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 	}
 
 	if (IS_ERR(in)) {
-		pr_warn("Can't lookup inode %llx (err: %ld)\n",
-			realm->ino, PTR_ERR(in));
+		dout("Can't lookup inode %llx (err: %ld)\n",
+		     realm->ino, PTR_ERR(in));
 		qri->timeout = jiffies + msecs_to_jiffies(60 * 1000); /* XXX */
 	} else {
 		qri->timeout = 0;
