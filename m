Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55720C4338F
	for <ceph-devel@archiver.kernel.org>; Fri, 23 Jul 2021 19:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392F260F22
	for <ceph-devel@archiver.kernel.org>; Fri, 23 Jul 2021 19:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhGWSaG (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhGWSaE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:30:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C3E7860F21;
        Fri, 23 Jul 2021 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627067437;
        bh=OeeQjJ9vfrB0DfdGJyJy4kZAmknJ8pVTaYu9u8YeRcY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aXAhxnu0s6dsfbvHF6SyY6A9xwb8vT1cIpy/FHTxvgxcbeHrKo29pZXQI1IYqrJct
         d0EMxiG/bA56glL9X3dw+aqhBuaB90zPSTmXWqD58k6xUmBU2G7LsQlE0ZAt4BC4OE
         jI1vRu6I1rKmx0v1O490MMAaYRDxv7a/AbmFLOXTFoFxI5qamZXmgBjE1rYofAdjdw
         aEuW74K6DsUec5k/FU9FmtiPXhTu0NNseMzpeCrGue9TuBCq7pGXZ/50+SD8Q9Fumx
         puml9GwnOU2LeiT41FKh3Lv5UPjRaDZoqMijkBHx5wJgM2/2eUmgnLzejIxglpTkmM
         Ryv6TACtQtnGA==
Subject: Re: [GIT PULL] Ceph fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210723163211.8436-1-idryomov@gmail.com>
References: <20210723163211.8436-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210723163211.8436-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.14-rc3
X-PR-Tracked-Commit-Id: 0077a50082729c3f9ea2836f59e35d9b7dacfb12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 704f4cba43d4ed31ef4beb422313f1263d87bc55
Message-Id: <162706743777.23984.652162798367127498.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 19:10:37 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 18:32:11 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/704f4cba43d4ed31ef4beb422313f1263d87bc55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
