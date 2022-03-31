Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C5C433F5
	for <ceph-devel@archiver.kernel.org>; Thu, 31 Mar 2022 15:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiCaPhB (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiCaPgH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2022 11:36:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69235228D36;
        Thu, 31 Mar 2022 08:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEF7FB82186;
        Thu, 31 Mar 2022 15:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0616DC34110;
        Thu, 31 Mar 2022 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740739;
        bh=HEcfOKrJPseki2h9qqHkIcp3hAz/G2Urvc/AkVOZHtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhInMCqT4MTECEqpIn4LaHc908NicroMfLHFhouQA5AQRnnO9wmQ99dGoYqv3eJBE
         hXoF/aguZowoTQMjCFnz+IinYgVZblHyxrSz/ADLUS/C0FCAQIKNv6ISIZL6SKFVqx
         JHuNhMlzMYEfeZMPqbtrd2gCH2xwJzZ/9t5RVcj+Uk28pqyvxgQ7oOWUBDZlH1Bvf6
         hpR9GoltPgRAFDrboQhwr7DJSFQRq227QdLYiAb++BBJi/NOH/B3WKJJKCF8goxIue
         w5DC+ii40b1y3zJetRTfkJD3SBzgal5PIz4NnHAUeW/Ci4RApolYg1L4wPvuY03mEs
         g+3d5mt/CH6EA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 52/54] ceph: set i_blkbits to crypto block size for encrypted inodes
Date:   Thu, 31 Mar 2022 11:31:28 -0400
Message-Id: <20220331153130.41287-53-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Some of the underlying infrastructure for fscrypt relies on i_blkbits
being aligned to the crypto blocksize.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f59a09757c4b..adefdcdef3bc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -975,13 +975,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	issued |= __ceph_caps_dirty(ci);
 	new_issued = ~issued & info_caps;
 
-	/* directories have fl_stripe_unit set to zero */
-	if (le32_to_cpu(info->layout.fl_stripe_unit))
-		inode->i_blkbits =
-			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
-	else
-		inode->i_blkbits = CEPH_BLOCK_SHIFT;
-
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -1007,6 +1000,15 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		ceph_decode_timespec64(&ci->i_snap_btime, &iinfo->snap_btime);
 	}
 
+	/* directories have fl_stripe_unit set to zero */
+	if (IS_ENCRYPTED(inode))
+		inode->i_blkbits = CEPH_FSCRYPT_BLOCK_SHIFT;
+	else if (le32_to_cpu(info->layout.fl_stripe_unit))
+		inode->i_blkbits =
+			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+	else
+		inode->i_blkbits = CEPH_BLOCK_SHIFT;
+
 	if ((new_version || (new_issued & CEPH_CAP_LINK_SHARED)) &&
 	    (issued & CEPH_CAP_LINK_EXCL) == 0)
 		set_nlink(inode, le32_to_cpu(info->nlink));
-- 
2.35.1

