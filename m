Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F46C83F18
	for <ceph-devel@archiver.kernel.org>; Mon, 28 Aug 2023 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjH1JVL (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 28 Aug 2023 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjH1JUf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Aug 2023 05:20:35 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB77132
        for <ceph-devel@vger.kernel.org>; Mon, 28 Aug 2023 02:20:26 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b88decb2a9so43651405ad.0
        for <ceph-devel@vger.kernel.org>; Mon, 28 Aug 2023 02:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214426; x=1693819226;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NjVq1Z/oMa2sXmtYIkTscVFUho6LoOShE43iizaRVs=;
        b=kraLKQ+ZydbqsPjGe1kzc68NNswJ/OWCwPeDeSSqtFZjWdcO/j5JYNY2epmV9yHqHc
         ylAtZI/sT0bRzcC3GluQ3CkEGh31x9XOv09DqsxbDuyg9odPmZC99OH9kwNsMbR7P7Sm
         wIolrRy04NNonnCRCfCgh/uTzT0KLQDoJTaZw6H3uGqul+jnHwyFJFn84CK6vVNbKJ1/
         9Yjv/TfujReA4k3uGqsELBEJTBvZPPEex6kVfq10/HHyKkv6jH8AVCdhGiRK/FlwQBQk
         aPMfL4eSMpd5NGgZRnQPEY6IvIAkkjcuxSejG6YfMnDVEmakB58iyeCyIcFpb5GAsFiA
         nC0g==
X-Gm-Message-State: AOJu0Yz8OWmXsGQtPMAhS+sNL3vOW3aoFNDcECw2MFkM6vmytikKHtQH
        TwbxtbNUb4R262Nqwjl91Wl8RsBJl2i+gNODOkce1J83JWmJ
X-Google-Smtp-Source: AGHT+IFwKeCBWgC1DX1LPBdk1QA9ny0nkU+5FxOLBCGi9TyKmLytzDKG906xwutAxEps8RwhnOht6aretJL+sMA6FaE8OnNW97B9
MIME-Version: 1.0
X-Received: by 2002:a17:902:cec4:b0:1bb:ad19:6b77 with SMTP id
 d4-20020a170902cec400b001bbad196b77mr9087222plg.2.1693214426325; Mon, 28 Aug
 2023 02:20:26 -0700 (PDT)
Date:   Mon, 28 Aug 2023 02:20:26 -0700
In-Reply-To: <20230828-storch-einbehalten-96130664f1f1@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068eb580603f834d3@google.com>
Subject: Re: [syzbot] [ceph?] [fs?] KASAN: slab-use-after-free Read in ceph_compare_super
From:   syzbot <syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com>
To:     brauner@kernel.org
Cc:     brauner@kernel.org, ceph-devel@vger.kernel.org, idryomov@gmail.com,
        jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

> #syz dup: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super

can't find the dup bug

