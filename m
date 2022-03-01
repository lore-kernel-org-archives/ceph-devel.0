Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B50C433F5
	for <ceph-devel@archiver.kernel.org>; Tue,  1 Mar 2022 11:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiCALba (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 1 Mar 2022 06:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiCALb3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Mar 2022 06:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12ADB4617C
        for <ceph-devel@vger.kernel.org>; Tue,  1 Mar 2022 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646134247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QgRI7iQj2c8gj1Zvr8WR9Mg0rgVlugfoHbzZhwVyAWk=;
        b=cNPOBNb0dHST0CI1hwZ0FTziKgQx/cFEivtk3+qDeAZMIa17CCX2lisqP+KKG3r66Zhj+R
        GbTnhKO/hvS2xd4q2fOZV+eUzGXwphg+xYZ+6XBjNk8c4fv/JIJmeUz8cF5ZMwdkeu6jb0
        cWra48baKyeBwzv5f2t0MhSfqzZaSIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-iE1UYS48ORuBdLqu8cBdpw-1; Tue, 01 Mar 2022 06:30:44 -0500
X-MC-Unique: iE1UYS48ORuBdLqu8cBdpw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0EA1091DA1;
        Tue,  1 Mar 2022 11:30:43 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC80D842CB;
        Tue,  1 Mar 2022 11:30:21 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, vshankar@redhat.com, lhenriques@suse.de,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 0/7] ceph: encrypt the snapshot directories
Date:   Tue,  1 Mar 2022 19:30:08 +0800
Message-Id: <20220301113015.498041-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

This patch series is base the 'wip-fscrypt' branch in ceph-client.

V2:
- Fix several bugs, such as for the long snap name encrypt/dencrypt
- Skip double dencypting dentry names for readdir

======

NOTE: This patch series won't fix the long snap shot issue as Luis
is working on that.


Xiubo Li (7):
  ceph: fail the request when failing to decode dentry names
  ceph: skip the memories when received a higher version of message
  ceph: do not dencrypt the dentry name twice for readdir
  ceph: add ceph_get_snap_parent_inode() support
  ceph: use the parent inode of '.snap' to dencrypt the names for
    readdir
  ceph: use the parent inode of '.snap' to encrypt name to build path
  ceph: try to encrypt/decrypt long snap name

 fs/ceph/crypto.c     |  75 ++++++++++++++++++++++++++---
 fs/ceph/crypto.h     |   2 +-
 fs/ceph/dir.c        |  87 +++++++++++++++++++---------------
 fs/ceph/inode.c      | 110 ++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.c |  59 ++++++++++++++---------
 fs/ceph/mds_client.h |   3 ++
 fs/ceph/snap.c       |  24 ++++++++++
 fs/ceph/super.h      |   2 +
 8 files changed, 286 insertions(+), 76 deletions(-)

-- 
2.27.0

