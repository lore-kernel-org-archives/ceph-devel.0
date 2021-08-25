Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0026DC4338F
	for <ceph-devel@archiver.kernel.org>; Wed, 25 Aug 2021 13:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46E76103E
	for <ceph-devel@archiver.kernel.org>; Wed, 25 Aug 2021 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhHYNq6 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 25 Aug 2021 09:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240148AbhHYNq5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629899171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QGoKJ5H3P2AeyskCHgFoUq2V4wPon+jgVV2naQWm9UU=;
        b=B/vE2soIllyPiS0LcIvNDhhRcl6HMh6qL9HdzWKhVeaI2ZiJTuAm8OuWNLgw7sXU9T96ec
        l+yfXmQ32Fjj1XdnmEqxoY4w9QbHV/W6gJYldeyl91lfnxWH0hJeaSHFadVMJYI8qEe5tG
        3SzadhNY1RdSqtI7cY0KJP752L58HKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Ns333P-QNVOUJdNeNKxl8w-1; Wed, 25 Aug 2021 09:46:08 -0400
X-MC-Unique: Ns333P-QNVOUJdNeNKxl8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61CEC802C92;
        Wed, 25 Aug 2021 13:46:06 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84B4D2854F;
        Wed, 25 Aug 2021 13:46:03 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, ukernel@gmail.com, pdonnell@redhat.com,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 0/3] ceph: remove the capsnaps when removing the caps
Date:   Wed, 25 Aug 2021 21:45:42 +0800
Message-Id: <20210825134545.117521-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

V3:
- fix one crash bug in the first patch.

V2:
- minor fixes to clean up the code from Jeff's comments, thanks
- swith to use lockdep_assert_held().



Test this for around 5 hours and this patch series worked well for me, my test script is:

$ while [ 1 ]; do date; for d in A B C; do (for i in {1..3}; do ./bin/mount.ceph :/ /mnt/kcephfs.$d -o noshare; rm -rf /mnt/kcephfs.$d/file$i.txt; rmdir /mnt/kcephfs.$d/.snap/snap$i; dd if=/dev/zero of=/mnt/kcephfs.$d/file$i.txt bs=1M count=8; mkdir -p /mnt/kcephfs.$d/.snap/snap$i; umount -fl /mnt/kcephfs.$d; done ) & done; wait; date; done



Xiubo Li (3):
  ceph: remove the capsnaps when removing the caps
  ceph: don't WARN if we're force umounting
  ceph: don't WARN if we're iterate removing the session caps

 fs/ceph/caps.c       | 106 ++++++++++++++++++++++++++++++++-----------
 fs/ceph/mds_client.c |  40 ++++++++++++++--
 fs/ceph/super.h      |   7 +++
 3 files changed, 123 insertions(+), 30 deletions(-)

-- 
2.27.0

