Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29604C433F5
	for <ceph-devel@archiver.kernel.org>; Thu,  7 Apr 2022 14:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbiDGOnf (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiDGOne (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2022 10:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDB59793AC
        for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2022 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649342494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A4iiCanDP+MxCKoASWlEzMOan0sZGBHQk21INV6ikfY=;
        b=UdwuBYG2jn711ELThbHdsw3nLNf1cQgHG2B3Ejt1DAZVlT0nbrhT/irwsowVc9G7j0NIOa
        HcX9lyVctHM6ou3Tpi+vd8JBs5uu1E4TPJVyQbcTylCX11ccd8dwVaU7xVUzBDFRBr1p5F
        10DgcX3g2SeRbS5thG+CH0LRF6VzlsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-j_10E45VP_GBskx0IbHEEg-1; Thu, 07 Apr 2022 10:41:30 -0400
X-MC-Unique: j_10E45VP_GBskx0IbHEEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42189805F6A;
        Thu,  7 Apr 2022 14:41:30 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CED7540314D;
        Thu,  7 Apr 2022 14:41:27 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, vshankar@redhat.com, lhenriques@suse.de,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 0/2] ceph: misc fix size truncate for fscrypt
Date:   Thu,  7 Apr 2022 22:41:10 +0800
Message-Id: <20220407144112.8455-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Xiubo Li (2):
  ceph: flush small range instead of the whole map for truncate
  ceph: fix coherency issue when truncating file size for fscrypt

 fs/ceph/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.27.0

