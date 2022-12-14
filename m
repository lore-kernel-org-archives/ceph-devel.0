Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ECCC4332F
	for <ceph-devel@archiver.kernel.org>; Wed, 14 Dec 2022 19:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiLNTRQ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiLNTRO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2022 14:17:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C38A60EA;
        Wed, 14 Dec 2022 11:17:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B2DFB81A1A;
        Wed, 14 Dec 2022 19:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F0CFC433D2;
        Wed, 14 Dec 2022 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671045431;
        bh=9w80oYjsRMME74N4ny7N+bWEuuu+B0oe33arQTcc2u4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b0up37T8mH0etkv1LHVB0zRZL5CiJ+zm2L+wdgDJXnCMhvNiPiwBm+h+a/N5yC6WD
         RcfJ9OWtyGuT0ZJONH3A8Y5KDD7XSfJFxIyVT/A/qgHjg2j0+NJArk+waERLlfNCK1
         +FBGd8eMV1s+Ywo+zAv2W8DRwlGefcNdzzLirwxAUKwJHAP0IBQOnydiTrCXpuwUUA
         +27PxxqZ5Khg84sATQ9CvNx+nACkOCOtX0c1XXMj8E3PxPuOWrdv60kYlv3CHmdW14
         S9QAdZ7Yi1zPncmtQtKE0viHkKVfyh/o71pUE2vbn5fG9QO9wkQXZ/mhM/LRhSwV4P
         IVQEJi/0geSeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E373E29F4D;
        Wed, 14 Dec 2022 19:17:11 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221214172820.96191-1-idryomov@gmail.com>
References: <20221214172820.96191-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221214172820.96191-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc1
X-PR-Tracked-Commit-Id: 68c62bee9d081cf815310b3a96e38d94fc16007d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfb3162495fe5b8702cf3854995508ef78a3f962
Message-Id: <167104543105.22233.2658050184840301392.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 19:17:11 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Wed, 14 Dec 2022 18:28:20 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfb3162495fe5b8702cf3854995508ef78a3f962

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
