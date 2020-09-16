Return-Path: <SRS0=hc/W=CZ=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A402C2BB84
	for <ceph-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A7821974
	for <ceph-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxLfZNeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgIPUjC (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgIPRHz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2020 13:07:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B6C061352
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2020 09:33:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j7so3475800plk.11
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2020 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=FxLfZNeDAWagUFX3HUll33QviaGvB/ysUpT05z3MWWzJIRb9s26f/XuIeG1UyaaaB9
         NsE58WbO2Rn602dNpDr5bgQ8Etq+Xuk7ns0FSk9RaZpujHzKIQac5pg/WxJpWcDSCa0S
         Lo74DRfCI5PREcKWzCCxj40hojEDF8/k9S5QjygAaL1HZtNCaOm4Rdl60J4LM9wqocMm
         Ndcaa9OuY0dr4QoUMwuGUEzZbm6KuyxbCsjOcCTPrBHqCnWfmG227M8lyYhm+Ar+Byb1
         jFosf3+Qpvg1FtgaxwGm86ORyUILpbCu0aCbskVzIel2MoS5fxbMBK5CIvndLlNnHAKp
         8HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=T3erwdDARkHZjFOJfrzX8vZ40GfjmX26UKFHqec9QPZGdzYGbQ5S9qm9ZEWq8TMDyI
         ETvLbj8o+fEGrl4KD+cpF/e9M9+Dlv+jHp5HBR5oBpUNyntD86j+7AUeUgt3e3cxBJwu
         /tu/0qWNSYE4hcTjQufqM0bSo3/vGFjVIpZCuB3JaxEQS81E4PVK5oCs043D3Ypmsa48
         hjM1ScJ6OlhYBa2/cTGbuzdWvbIovpt87Icpj1E+jB+NZp1B03EQ7V2pAF/nLEm2+54T
         OwMGeaxmd46kSxwnYXVSFmbiWcwrqZK7snjiRQH+YVEQXqEhdLemks1RCFedbLmrl7hO
         vFcA==
X-Gm-Message-State: AOAM530nFoklm9WxOf9r2NN0VhvjePdX0ryEkT9kzrJ3hX++RfG5NNPY
        MrgpnMiqUzQ37yyJzjvvb26bS6OteCDm4A==
X-Google-Smtp-Source: ABdhPJyVWK39t/+oh4Q/vF44F0OWfn3IllTtrcelhgo7JMFtHNycQT0afMfWYVWGI4IZbe7Vh3li6g==
X-Received: by 2002:a17:902:a712:b029:d1:cbf4:c583 with SMTP id w18-20020a170902a712b02900d1cbf4c583mr13713831plq.16.1600274017950;
        Wed, 16 Sep 2020 09:33:37 -0700 (PDT)
Received: from ?IPv6:2605:e000:1600:d493:74ea:1ed5:f18a:eecb? ([2605:e000:1600:d493:74ea:1ed5:f18a:eecb])
        by smtp.gmail.com with ESMTPSA id 64sm17315886pfg.98.2020.09.16.09.33.36
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:33:37 -0700 (PDT)
From:   Dan Jakubiec <dan.jakubiec@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: help
Message-Id: <2DCDE001-8496-48BE-A2C1-A56117C7D815@gmail.com>
Date:   Wed, 16 Sep 2020 09:33:35 -0700
To:     ceph-devel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

