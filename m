Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8F8C433EF
	for <ceph-devel@archiver.kernel.org>; Thu, 31 Mar 2022 15:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiCaPkz (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiCaPh3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2022 11:37:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EAD22B6E8;
        Thu, 31 Mar 2022 08:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FBE7B82011;
        Thu, 31 Mar 2022 15:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2CC340F3;
        Thu, 31 Mar 2022 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740735;
        bh=AkP+bIfW6LS3O30Z6o2FhsncxpRo4Ds5/Ha2Xgwf6TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8NT6Fag5Lrfncz+wxG0OJWQ7iH25lV76UZhs8Nxviv6pQffq/nVUPL+C7aUAEHcd
         Q4yzyHpxCLcTTSwPR8VTPvUYHXHUwLvSRldXJp6jmXKFDph1G9GS9U9mziy6xveGte
         k+O4Ys79494JlIrrqtlHIIQFRih4uhb3/+GXsHl/qOuDOSNBCpEw0Zq7hfkhFnC0d4
         orqbDKyWRAmfFy8HC0hRXKyh2TN1E98R+IgTlmQ/lPR+8Ni0lz3aCg+lxm9MKweLAq
         FAxWRNbobhyMP+mA8nrGNS8pxogV00ZUiaY47lHYbiWQJ9HEiEbybWBdZITRR++gug
         aZJYrPjUIiImg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 47/54] ceph: don't use special DIO path for encrypted inodes
Date:   Thu, 31 Mar 2022 11:31:23 -0400
Message-Id: <20220331153130.41287-48-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Eventually I want to merge the synchronous and direct read codepaths,
possibly via new netfs infrastructure. For now, the direct path is not
crypto-enabled, so use the sync read/write paths instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 29cc65222ddd..fdd59477af5b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1711,7 +1711,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     ceph_cap_string(got));
 
 		if (ci->i_inline_version == CEPH_INLINE_NONE) {
-			if (!retry_op && (iocb->ki_flags & IOCB_DIRECT)) {
+			if (!retry_op &&
+			    (iocb->ki_flags & IOCB_DIRECT) &&
+			    !IS_ENCRYPTED(inode)) {
 				ret = ceph_direct_read_write(iocb, to,
 							     NULL, NULL);
 				if (ret >= 0 && ret < len)
@@ -1937,7 +1939,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		/* we might need to revert back to that point */
 		data = *from;
-		if (iocb->ki_flags & IOCB_DIRECT)
+		if ((iocb->ki_flags & IOCB_DIRECT) && !IS_ENCRYPTED(inode))
 			written = ceph_direct_read_write(iocb, &data, snapc,
 							 &prealloc_cf);
 		else
-- 
2.35.1

