Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3630C433E0
	for <ceph-devel@archiver.kernel.org>; Wed, 30 Dec 2020 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E6120723
	for <ceph-devel@archiver.kernel.org>; Wed, 30 Dec 2020 20:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgL3UPq (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgL3UPq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Dec 2020 15:15:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2A81020723;
        Wed, 30 Dec 2020 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609359306;
        bh=eKuKZ9iLga19uUDQcBOKH4XteoaMMyt4YTsAeLDBGAM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QjVoUWpxffQJVX5NlmS3IA95QsjgbHH81XYcpnrnVRYbvHzuGfDNSKWN6183enr34
         CPFJqwXVRBTpIKvsmlT0Xrj2r84Qwe41CiZSaAuCLD/an53g702CiOslEiZMO6WhX6
         yOVGYp6frFW+hAJ/+QSZXa9ONaXNKv2RXkqSZ0noZL+RPyiEVEx1PpHukKUqRsyav2
         1QnOxsHfP3PBCKUh98G7eFegmKguRqI9N+FEqtGYyG7hrt0JI0U/lOiWywa3RPvoA9
         wckplqKBA2L3aQ597CWlVvuZVzVxvFO5/WikRI4fUHfl8KHPWg8Ycm1Z5xKPAQZ5Pb
         g4tnnEYAwCVFg==
Subject: Re: [GIT PULL] Ceph fixes for 5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201230173846.7369-1-idryomov@gmail.com>
References: <20201230173846.7369-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201230173846.7369-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.11-rc2
X-PR-Tracked-Commit-Id: 664f1e259a982bf213f0cd8eea7616c89546585c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6e1ea19649216156576aeafa784e3b4cee45549
Message-Id: <160935930602.16095.8166230564179307859.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Dec 2020 20:15:06 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Wed, 30 Dec 2020 18:38:46 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6e1ea19649216156576aeafa784e3b4cee45549

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
