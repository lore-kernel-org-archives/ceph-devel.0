Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB1CC433EF
	for <ceph-devel@archiver.kernel.org>; Tue, 22 Mar 2022 03:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiCVDQq (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 21 Mar 2022 23:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCVDQo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2022 23:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C89812C646
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2022 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647918916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zsDFlqVO+PHYLK3vR2TDpwvAx3XCvL7jtkmZYVsOVUE=;
        b=G9aGMwIRBHn3p/smJ4p0l4A4tCsBK2EzM7zb+OPd5ZRVOMZKNqooYRhWVQA4WCmSEszgpG
        RQlwtaBftwIuv7DIcVxukvSrAuY+Y5seZm5wxuQLRBjaI9ACVyyNkeoVVfGrO+IKAv9GXh
        97Eh5ic6u/0rOCd6wIT8WfFfW/yXhA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-55oCUfNTMzmrv21ZFH-h3A-1; Mon, 21 Mar 2022 23:15:13 -0400
X-MC-Unique: 55oCUfNTMzmrv21ZFH-h3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D0F9101AA42;
        Tue, 22 Mar 2022 03:15:13 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1097F464B41;
        Tue, 22 Mar 2022 03:15:10 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] ceph: remove incorrect session state check
Date:   Tue, 22 Mar 2022 11:15:02 +0800
Message-Id: <20220322031502.496857-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Once the session is opened the s->s_ttl will be set, and when receiving
a new mdsmap and the MDS map is changed, it will be possibly will close
some sessions and open new ones. And then some sessions will be in
CLOSING state evening without unmounting.

URL: https://tracker.ceph.com/issues/54979
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index cd0c780a6f84..4657412bfa53 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4779,8 +4779,6 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 
 bool check_session_state(struct ceph_mds_session *s)
 {
-	struct ceph_fs_client *fsc = s->s_mdsc->fsc;
-
 	switch (s->s_state) {
 	case CEPH_MDS_SESSION_OPEN:
 		if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
@@ -4789,10 +4787,6 @@ bool check_session_state(struct ceph_mds_session *s)
 		}
 		break;
 	case CEPH_MDS_SESSION_CLOSING:
-		/* Should never reach this when not force unmounting */
-		WARN_ON_ONCE(s->s_ttl &&
-			     READ_ONCE(fsc->mount_state) != CEPH_MOUNT_SHUTDOWN);
-		fallthrough;
 	case CEPH_MDS_SESSION_NEW:
 	case CEPH_MDS_SESSION_RESTARTING:
 	case CEPH_MDS_SESSION_CLOSED:
-- 
2.27.0

