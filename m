Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95155C433F5
	for <ceph-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010B61166
	for <ceph-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhIUNJ2 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232344AbhIUNJ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632229678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p7KrSjRZ5jlkbSYeeKoptT6y+0YS3k5niGA9k1lTCic=;
        b=GDoTqetTXV57YRXXXswTQBJnt3OKVowz6NloqOTAfiEI7uk9INfl50efJ0gMw0w7bVTZMf
        IqWAS8dCsx4DC9OERtm3JKDtY4sNFcagj40M8ApsPT89CZlHH6SxglHULdM8lwD1lx0wzS
        HpnPr/cTH8zuK45pV9x2paolBEg5b2k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-CnzjsLmAPLuOWevMPSDLoQ-1; Tue, 21 Sep 2021 09:07:57 -0400
X-MC-Unique: CnzjsLmAPLuOWevMPSDLoQ-1
Received: by mail-pf1-f199.google.com with SMTP id g2-20020a62f9420000b029035df5443c2eso15964505pfm.14
        for <ceph-devel@vger.kernel.org>; Tue, 21 Sep 2021 06:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7KrSjRZ5jlkbSYeeKoptT6y+0YS3k5niGA9k1lTCic=;
        b=JRixu1HeA7rizO+furp67MT50gFFtz0FigVqKZXEWU/34muXGswyk2VcbrY7BC/baX
         fehz10E/2c6+Wo7Mh/uvauxkWNEdHLj4SAvWh29yhbStDOm4mLKfHWP8s8eB0Zc3yEEq
         lPDkYmt9Szo3xWJ9JVpR2G+jjuRkYiiXp+SkmvvlugrdMpdnBHsBeZpIMeZVDh0Vu+k0
         WgGuvhP5ZC2NlxEzzX6M9ilWKLBQ91/+Yxb8NqzWUr73HnGaE+ZuldVW0q6pTRXXsMRe
         qwb9Jo8/iVqbPIU/qW4Ll4+yKZ0N4c6UwdBwQecJXMgnCVXVYsuVmxkMjAGP8VAdHvz7
         +0ww==
X-Gm-Message-State: AOAM532NsjeDhVQXFkFHUecP2dChj2p1IZVlqLVihD5vgZrOpnyl+I/b
        JiO3PRefBsepPVXwjsidoaYrmMUliKpmofo9mF3eo4jSaiXQxRHETd8lzDDaT+Uw9XqP0JembYr
        IgY7FPyeryMWZlSA65z3EUA==
X-Received: by 2002:a17:90b:1b0f:: with SMTP id nu15mr5208763pjb.181.1632229676277;
        Tue, 21 Sep 2021 06:07:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4HuxqdvVky5Zbqp08JBMbTRQ5HbqtsebCH/QQLc3NlNE4XsPwZVhZi1oLZqujU9r5VudqHg==
X-Received: by 2002:a17:90b:1b0f:: with SMTP id nu15mr5208739pjb.181.1632229676040;
        Tue, 21 Sep 2021 06:07:56 -0700 (PDT)
Received: from h3ckers-pride.redhat.com ([49.207.212.118])
        by smtp.gmail.com with ESMTPSA id w5sm18473890pgp.79.2021.09.21.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:07:55 -0700 (PDT)
From:   Venky Shankar <vshankar@redhat.com>
To:     jlayton@redhat.com, pdonnell@redhat.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, Venky Shankar <vshankar@redhat.com>
Subject: [PATCH v3 0/4] ceph: forward average read/write/metadata latency
Date:   Tue, 21 Sep 2021 18:37:46 +0530
Message-Id: <20210921130750.31820-1-vshankar@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

v3:
  - rework average/stdev handling by maintaining sum of squares
    and calculating standard deviation when sending metrics

Right now, cumulative read/write/metadata latencies are tracked
and are periodically forwarded to the MDS. These meterics are not
particularly useful. A much more useful metric is the average latency
and standard deviation (stdev) which is what this series of patches
aims to do.

The userspace (libcephfs+tool) changes are here::

          https://github.com/ceph/ceph/pull/41397

The math involved in keeping track of the average latency and stdev
are adjusted to closely mimic how its done in user space ceph (with
some restrictions obviously) as per::

          NEW_AVG = OLD_AVG + ((latency - OLD_AVG) / total_ops)
          NEW_STDEV = SQRT(SQ_SUM / (total_ops - 1))

Note that the cumulative latencies are still forwarded to the MDS but
the tool (cephfs-top) ignores it altogether.

Venky Shankar (4):
  ceph: use "struct ceph_timespec" for r/w/m latencies
  ceph: track average/stdev r/w/m latency
  ceph: include average/stddev r/w/m latency in mds metrics
  ceph: use tracked average r/w/m latencies to display metrics in
    debugfs

 fs/ceph/debugfs.c |   6 +--
 fs/ceph/metric.c  | 109 ++++++++++++++++++++++++----------------------
 fs/ceph/metric.h  |  62 ++++++++++++++++----------
 3 files changed, 101 insertions(+), 76 deletions(-)

-- 
2.31.1

