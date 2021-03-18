Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8181EC433E0
	for <ceph-devel@archiver.kernel.org>; Thu, 18 Mar 2021 11:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B2464EE2
	for <ceph-devel@archiver.kernel.org>; Thu, 18 Mar 2021 11:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCRLgq (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhCRLgN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Mar 2021 07:36:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DBC06174A
        for <ceph-devel@vger.kernel.org>; Thu, 18 Mar 2021 04:36:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v8so1157609plz.10
        for <ceph-devel@vger.kernel.org>; Thu, 18 Mar 2021 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=F5Z9zBRMx980jBgiJGpRVZsHtw8JYg4GvqcEgNGVTEE=;
        b=rcC4nzKrgQGGH/PzdbE98j5hOh5165w4fEYS6WFTJCLQ6CcerIkg2wB80GUP1jALKR
         6Zj6kd4M2liQJHiZ7AlJtWNKx6TKDCinmdAuM2rWvN59TSv0IqQJlQVmtCPy7fvBqRn8
         krozEJ1LrWb+Bt2fKyLjvscKUeQGzgG8FM043YM2pp/13vlkGcngT04N7vjzADEzRlib
         DREsUY4y3xwzjj7ADLN/ute3VrRPE9QHTVCpAfNNST/9XYTrTzYpTqlkyWwV4ieJ7pVE
         94HyLCHpln0X+m/5NEX3wGVGl3dNTDtnJ1t+ryHivW6FLR8RZ4Ei3v9VkHmQJREACd8J
         u2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F5Z9zBRMx980jBgiJGpRVZsHtw8JYg4GvqcEgNGVTEE=;
        b=XQT2A846IMeJU+fIN8rpLhOpVJ+iiO3sfS4VbeRWvMQzX2BRzyHXfJO4oUs/d1338v
         knfTbuISwPp4IFKVtHNZbizJnkHOD8p0nXPZ1NA8dc6u23Ln95vwufyxk5QdMio5Rq/s
         Pka4xCOKGIi+SdUw9Yb2qiIsRoA2mmTDAkLTpzKsBaBluEMuXh4bsWcTFowtrCHQT+DQ
         /y9hIJ9NfV7iRdHiTL5cLJWodLg8ADK/J8c2fMRfWIlmVpHgDoz5xXweFrZRfbI2bvPM
         1XtDN5ikGtDOeIsh0z6r664gi+BemrwFgfhD6Tm/m2/xVfks9/bCwL5fV2ZWmVq9vJi7
         0g9A==
X-Gm-Message-State: AOAM531EzXYw0DwWCSB/onV+TCQ7hp2GuQr4Z9tQuMCFWR24jGzUneDg
        DJIPW3x4Bh5Cmy5TpTtYKUwFqVbiFeszldhwlBW1P3BPITNjYg==
X-Google-Smtp-Source: ABdhPJx5Zky3kiDiXd7Ij4E4SlSAXOk2o6N7lXjaPPhqM9GSJmHw/3VhFwDaWG5SL6GYVJEW7RMPSPW+DKUmhtKY3Zw=
X-Received: by 2002:a17:90b:fd2:: with SMTP id gd18mr3948699pjb.115.1616067372178;
 Thu, 18 Mar 2021 04:36:12 -0700 (PDT)
MIME-Version: 1.0
From:   WeiGuo Ren <rwg1335252904@gmail.com>
Date:   Thu, 18 Mar 2021 19:35:59 +0800
Message-ID: <CAPy+zYWQbVojqLPdcM=Q7kEPx=ju6_efTd0-DSoryVSbiyhJLg@mail.gmail.com>
Subject: rgw: Is rgw_sync_lease_period=120s set small?
To:     Ceph Development <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

In an rgw multi-site production environment, how many rgw instances
will be started in a single zone? According to my test, multiple rgw
instances will compete for the datalog leaselock, and it is very
likely that the leaselock will not be renewed. Is the default
rgw_sync_lease_period=120s a bit small?
