Return-Path: <SRS0=txDZ=DC=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9447C4363D
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D9521D91
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601042937;
	bh=QwuRINCGtX1bXvsKTty6G1UeJJCNBikXox0OBaxpkUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hCJvVSyMlBM1v3AbQ9usFhzbMGX/aETH12of2N6JtLsf//qELftJKOOLy16dmdotC
	 4x5doPvOXSUnW5Uc/S+tiMSsS6FX9ArQF9A/Go05TKXG090bwDQ1EII6U4IjJ4zLUj
	 0emDmhWj1ULDa8KnMmn2hzvkUnJ2ESPAd0RO/wPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgIYOI4 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYOIz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:08:55 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD4D21D7A;
        Fri, 25 Sep 2020 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601042935;
        bh=QwuRINCGtX1bXvsKTty6G1UeJJCNBikXox0OBaxpkUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXE4kpsE+ZE0QBIePd5hvnJaYjSVEdmMiIomG7KUAEjHAVGiEG7yd4Y/RGLAfL3jJ
         OtOfJIw+9GbiBeyhXcCQUQBniy0RyPxf+AiRv+wMR9iYk2xhvptolR/AS7h4J43MSG
         RZGVW1UOW97DHYtDwwbffc10Q9DQXu97rPW8nnKk=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, ukernel@gmail.com, pdonnell@redhat.com
Subject: [RFC PATCH 2/4] ceph: don't mark mount as SHUTDOWN when recovering session
Date:   Fri, 25 Sep 2020 10:08:49 -0400
Message-Id: <20200925140851.320673-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925140851.320673-1-jlayton@kernel.org>
References: <20200925140851.320673-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

When recovering a session (a'la recover_session=clean), we want to do
all of the operations that we do on a forced umount, but changing the
mount state to SHUTDOWN is wrong and can cause queued MDS requests to
fail when the session comes back.

Only mark it as SHUTDOWN when umount_begin is called.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2516304379d3..46a0e4e1b177 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -832,6 +832,13 @@ static void destroy_caches(void)
 	ceph_fscache_unregister();
 }
 
+static void __ceph_umount_begin(struct ceph_fs_client *fsc)
+{
+	ceph_osdc_abort_requests(&fsc->client->osdc, -EIO);
+	ceph_mdsc_force_umount(fsc->mdsc);
+	fsc->filp_gen++; // invalidate open files
+}
+
 /*
  * ceph_umount_begin - initiate forced umount.  Tear down the
  * mount, skipping steps that may hang while waiting for server(s).
@@ -844,9 +851,7 @@ static void ceph_umount_begin(struct super_block *sb)
 	if (!fsc)
 		return;
 	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
-	ceph_osdc_abort_requests(&fsc->client->osdc, -EIO);
-	ceph_mdsc_force_umount(fsc->mdsc);
-	fsc->filp_gen++; // invalidate open files
+	__ceph_umount_begin(fsc);
 }
 
 static const struct super_operations ceph_super_ops = {
@@ -1235,7 +1240,7 @@ int ceph_force_reconnect(struct super_block *sb)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 	int err = 0;
 
-	ceph_umount_begin(sb);
+	__ceph_umount_begin(fsc);
 
 	/* Make sure all page caches get invalidated.
 	 * see remove_session_caps_cb() */
-- 
2.26.2

