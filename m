Return-Path: <SRS0=BUMQ=CD=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE5FC433DF
	for <ceph-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8A6208E4
	for <ceph-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBiO9J/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHYAzK (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbgHYAzJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598316908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=6H9e0ogY+DEApiDiNUnG6LtuKbLY0YOfMd/OlRFKMZA=;
        b=RBiO9J/HmTpDv43uoyjqYN0PUxnK+G/d5cjmKzrtwSKI3iey2jCv2zufLjF8GUh0TvFt3r
        kCyWQ793NiIE7uj6nTe0LZEdPuoy12NSEoclD5JROoky8fz4ag+OasSJLzN8DkttfpGPAq
        orKiotU4WKCOEgmf6Yh0kcKvpxLWIuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-XQP9qZlgNp-2O7tVES5uiw-1; Mon, 24 Aug 2020 20:55:06 -0400
X-MC-Unique: XQP9qZlgNp-2O7tVES5uiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E55281F010;
        Tue, 25 Aug 2020 00:55:05 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-202.gsslab.pek2.redhat.com [10.72.37.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84DC919C58;
        Tue, 25 Aug 2020 00:55:03 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 0/2] ceph: metrics for opened files, pinned caps and opened inodes
Date:   Mon, 24 Aug 2020 20:54:52 -0400
Message-Id: <20200825005454.2222920-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V3:
- Resend for V2 just forgot one patch, which is adding some helpers
support to simplify the code.

Changed in V2:
- Add number of inodes that have opened files.
- Remove the dir metrics and fold into files.


Xiubo Li (2):
  ceph: add helpers for parsing inode/ci/sb to mdsc
  ceph: metrics for opened files, pinned caps and opened inodes

 fs/ceph/caps.c    | 30 ++++++++++++++++++++++++++----
 fs/ceph/debugfs.c | 11 +++++++++++
 fs/ceph/dir.c     | 22 ++++++++--------------
 fs/ceph/file.c    | 17 ++++++++---------
 fs/ceph/inode.c   | 17 +++++++++++------
 fs/ceph/ioctl.c   |  6 +++---
 fs/ceph/locks.c   |  2 +-
 fs/ceph/metric.c  | 14 ++++++++++++++
 fs/ceph/metric.h  |  7 +++++++
 fs/ceph/quota.c   |  8 ++++----
 fs/ceph/snap.c    |  2 +-
 fs/ceph/super.h   | 25 +++++++++++++++++++++++++
 fs/ceph/xattr.c   |  2 +-
 13 files changed, 120 insertions(+), 43 deletions(-)

-- 
2.18.4

