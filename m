From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] ceph/mds_client.c: quiet sparse noise
Date: Fri, 23 Sep 2011 13:22:11 -0700
Message-ID: <201109231322.12090.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:47942 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1IWUWc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 16:22:32 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ceph-devel@vger.kernel.org, sage@newdream.net

Quiet the following sparse noise:

warning: symbol 'get_nonsnap_parent' was not declared. Should it be static?
warning: symbol 'done_closing_sessions' was not declared. Should it be static?

Local functions don't need external visability. Make them static.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Sage Weil <sage@newdream.net>

---

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2712e8f..9ec5d1e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -619,7 +619,7 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
  *
  * Called under mdsc->mutex.
  */
-struct dentry *get_nonsnap_parent(struct dentry *dentry)
+static struct dentry *get_nonsnap_parent(struct dentry *dentry)
 {
 	/*
 	 * we don't need to worry about protecting the d_parent access
@@ -3154,7 +3154,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 /*
  * true if all sessions are closed, or we force unmount
  */
-bool done_closing_sessions(struct ceph_mds_client *mdsc)
+static bool done_closing_sessions(struct ceph_mds_client *mdsc)
 {
 	int i, n = 0;
 
