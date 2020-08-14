Return-Path: <SRS0=aVND=BY=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC23FC433E1
	for <ceph-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41EC206B2
	for <ceph-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHNJiZ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:38:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgHNJiZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:38:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06482B6B8;
        Fri, 14 Aug 2020 09:38:47 +0000 (UTC)
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id e1a148a2;
        Fri, 14 Aug 2020 09:38:22 +0000 (UTC)
Date:   Fri, 14 Aug 2020 10:38:22 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH] ceph: remove unnecessary return in switch statement
Message-ID: <20200814093822.GA293898@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Since there's a return immediately after the 'break', there's no need for
this extra 'return' in the S_IFDIR case.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/ceph/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d51c3f2fdca0..04ab99c0223a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -256,8 +256,6 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 	case S_IFDIR:
 		ret = ceph_init_file_info(inode, file, fmode,
 						S_ISDIR(inode->i_mode));
-		if (ret)
-			return ret;
 		break;
 
 	case S_IFLNK:

