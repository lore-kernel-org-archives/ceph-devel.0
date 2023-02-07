Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF8C05027
	for <ceph-devel@archiver.kernel.org>; Tue,  7 Feb 2023 03:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBGDOB (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 6 Feb 2023 22:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGDOA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2023 22:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007613DFA
        for <ceph-devel@vger.kernel.org>; Mon,  6 Feb 2023 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675739592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B6pj+4ZCXaaSWbxY8tFM3I/o5LSv+Q7oCuTOd7Wv2dk=;
        b=AlQBzZb1RJg/NkVZcbondaVnULQF5ffKR5PAhIl+j+b2hSCxY2q8ifWvdc75xIzmotIYlH
        bsjN+iefjxX6eSeds0iL4fmniGBPlTEOAnl33yMMfCDkxA2Du4cMbOooYx2A6aHIGd71ct
        vvetXgB9AxEXqLkLJVS5MLxCpixvdEU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-A5LT40kJMCWsinrSUwBCDw-1; Mon, 06 Feb 2023 22:13:08 -0500
X-MC-Unique: A5LT40kJMCWsinrSUwBCDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E7C83C02525;
        Tue,  7 Feb 2023 03:13:08 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C0B02166B29;
        Tue,  7 Feb 2023 03:13:04 +0000 (UTC)
From:   xiubli@redhat.com
To:     idryomov@gmail.com, ceph-devel@vger.kernel.org
Cc:     jlayton@kernel.org, mchangir@redhat.com, vshankar@redhat.com,
        lhenriques@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] ceph: fail the requests directly if inode is shutdown for fscrypt
Date:   Tue,  7 Feb 2023 11:13:01 +0800
Message-Id: <20230207031301.363786-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

This should be folded into the previous commit(2f00ba2d4f33 ceph:
add __ceph_sync_read helper support) based on the 'testing' branch.

The __ceph_sync_read() will be called by setattr by fscrypt relevant
code.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6cde84c9000f..903de296f0d3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -976,6 +976,9 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 
 	dout("sync_read on inode %p %llx~%llx\n", inode, *ki_pos, len);
 
+	if (ceph_inode_is_shutdown(inode))
+		return -EIO;
+
 	if (!len)
 		return 0;
 	/*
-- 
2.31.1

