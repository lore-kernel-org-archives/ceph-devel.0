Return-Path: <SRS0=UwT+=CG=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FBEC433E6
	for <ceph-devel@archiver.kernel.org>; Fri, 28 Aug 2020 02:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB01C207DF
	for <ceph-devel@archiver.kernel.org>; Fri, 28 Aug 2020 02:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBBnZucR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgH1CNt (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:13:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgH1CNt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598580828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=wKW8YMN+NMNCaNMRQZTzY1rxMFixHHULnRwPUZA6xH8=;
        b=jBBnZucRNR8ayMdBIN2S6hoe+hFgGcKe21p3OdFJgR7zYYr7LJ/X6PPsdqfy0+zm7y22pe
        qZe3/UChghEYctzDJrWcbl9K7enYcwTG6ivhO7tBBfTQrKKNMBsgO/DRerUYexQIbxRiYl
        P+xepkz9SrBpS4mFp1jtcHc3j03uUQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-q-OjiqkSOpyStHU5juqDFw-1; Thu, 27 Aug 2020 22:13:44 -0400
X-MC-Unique: q-OjiqkSOpyStHU5juqDFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D30F018B9F42;
        Fri, 28 Aug 2020 02:13:43 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-202.gsslab.pek2.redhat.com [10.72.37.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6A536198B;
        Fri, 28 Aug 2020 02:13:41 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v4 0/2] ceph: metrics for opened files, pinned caps and opened inodes
Date:   Thu, 27 Aug 2020 22:13:34 -0400
Message-Id: <20200828021336.99898-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V4:
- A small fix about the total_inodes.

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

