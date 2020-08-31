Return-Path: <SRS0=LBqa=CJ=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68345C433E2
	for <ceph-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D321556
	for <ceph-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598887932;
	bh=wo/9jfUs/QsfWHN0aWZWBzIi8v87Qpm/6HXW9VcwsdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxF7w/kSnR6dJk0Yt+I7a4vu8oeXA3NbUNSF+1OhQ7C4TfcnX3ljhMb1Xgdd7uqjq
	 lH5IBIWjTa8hHtoFLb3PPz8MI2tU4PGCYeuAoDiaFpKV8nnbry5n5c7VBe0IBuZY2d
	 8CUQhQfyir/Tj90+i61fY1/GdsuLytGUpNlJG1xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgHaPcJ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgHaPcG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:32:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ACE021556;
        Mon, 31 Aug 2020 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887926;
        bh=wo/9jfUs/QsfWHN0aWZWBzIi8v87Qpm/6HXW9VcwsdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hA4taY6a67kpk6fQLPB1yClij//6KeJc8GadaWORNCEKrhzAICLKadWTCqFfw1Qvf
         yEAJPREXuug+T1hKFRcegKMbnN20ECHCIjBNHhBv9dqEHIwoABvNyRsc5f+OGivPZ1
         5TUmWo/T4Ir98O0l2bhwGS2mUt6v0lk3zWW36OKw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 3/5] ceph: don't allow setlease on cephfs
Date:   Mon, 31 Aug 2020 11:31:58 -0400
Message-Id: <20200831153200.1024898-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153200.1024898-1-sashal@kernel.org>
References: <20200831153200.1024898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 496ceaf12432b3d136dcdec48424312e71359ea7 ]

Leases don't currently work correctly on kcephfs, as they are not broken
when caps are revoked. They could eventually be implemented similarly to
how we did them in libcephfs, but for now don't allow them.

[ idryomov: no need for simple_nosetlease() in ceph_dir_fops and
  ceph_snapdir_fops ]

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c8222bfe1e566..3e6ebe40f06fb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1433,6 +1433,7 @@ const struct file_operations ceph_file_fops = {
 	.mmap = ceph_mmap,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
+	.setlease = simple_nosetlease,
 	.flock = ceph_flock,
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
-- 
2.25.1

