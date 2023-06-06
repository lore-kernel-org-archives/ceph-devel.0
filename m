Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01DC77B73
	for <ceph-devel@archiver.kernel.org>; Tue,  6 Jun 2023 03:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjFFDfb (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 5 Jun 2023 23:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjFFDf3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2023 23:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAAD187
        for <ceph-devel@vger.kernel.org>; Mon,  5 Jun 2023 20:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686022483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ua2aHz/D/D9qShzOVEwgzYidCm75ggC8y8szHVDE5SA=;
        b=AFv/98nOYKg7o3KcblwcY0Z+9TNL5t/rh+kpBcZYcizD61jxZfT9gX3vxqpbNQSVGkm/JO
        hS/jBpME+VCR994rGPG8W7NJNjrK9gsS6idaInBNDqCoppkqLFtrKmm1RgWhaOS9Ris3FE
        tW3KE/dJ7CzmBNR6mKNMyU1Qpx7a6wc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-VHvW3xEeOiuR-iEqx_OOMw-1; Mon, 05 Jun 2023 23:34:39 -0400
X-MC-Unique: VHvW3xEeOiuR-iEqx_OOMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770E11C060CA;
        Tue,  6 Jun 2023 03:34:39 +0000 (UTC)
Received: from li-a71a4dcc-35d1-11b2-a85c-951838863c8d.ibm.com.com (ovpn-12-128.pek2.redhat.com [10.72.12.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 636DF40CFD46;
        Tue,  6 Jun 2023 03:34:28 +0000 (UTC)
From:   xiubli@redhat.com
To:     idryomov@gmail.com, ceph-devel@vger.kernel.org
Cc:     jlayton@kernel.org, vshankar@redhat.com, lhenriques@suse.de,
        mchangir@redhat.com, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 0/2] ceph: fix fscrypt_destroy_keyring use-after-free bug
Date:   Tue,  6 Jun 2023 11:32:10 +0800
Message-Id: <20230606033212.1068823-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

V2:
- Improve the code by switching to wait_for_completion_killable_timeout()
  when umounting, at the same add one umount_timeout option.
- Improve the inc/dec helpers for metadata/IO cases.


Xiubo Li (2):
  ceph: drop the messages from MDS when unmounting
  ceph: just wait the osd requests' callbacks to finish when unmounting

 fs/ceph/addr.c       | 10 +++++
 fs/ceph/caps.c       |  6 ++-
 fs/ceph/mds_client.c | 14 +++++--
 fs/ceph/mds_client.h | 11 ++++-
 fs/ceph/quota.c      | 14 +++----
 fs/ceph/snap.c       | 10 +++--
 fs/ceph/super.c      | 99 +++++++++++++++++++++++++++++++++++++++++++-
 fs/ceph/super.h      |  7 ++++
 8 files changed, 154 insertions(+), 17 deletions(-)

-- 
2.40.1

