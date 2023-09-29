Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC38FE7734C
	for <ceph-devel@archiver.kernel.org>; Fri, 29 Sep 2023 23:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjI2X7P (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjI2X7O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2023 19:59:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0DF1A8;
        Fri, 29 Sep 2023 16:59:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76A6EC433C8;
        Fri, 29 Sep 2023 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696031952;
        bh=aageGv5P9ePUrrV0F6dmrIAi02CC7s3JdvPi3tSvjbY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hrqkmu/4zhOl0V4XW4B6m7gt4zZpxHRJCKHfyUCCXk6BkofeorMXXsNiEBaG+7I3x
         ZpcC4LjdTZSGRu3LXE2EM/3/yTCinuTjHsPdJFcCqrqUIsSuM9BojDnQG6Pvj+dFqc
         KIbWgcVad2hkI+NjiEeVPmaA7wjpRgOQwNlAb8+hsm6obF5/rAe/4A1+fHEetGRD9X
         qWiFQs0j/2qYOGwOCrAxKnQxqLVLA6IWvIKcdfBt2FvTg7vhfkPwfLjZqjiV7DYH56
         7M3I8GTiG8zb5cbt3c002JtC7vrdfYNhg9sSVdvfFF67TsHsvl5WtoxnIqLcD58CAQ
         mKFRVaJ4PO7/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61CB3C395C8;
        Fri, 29 Sep 2023 23:59:12 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230929150002.264424-1-idryomov@gmail.com>
References: <20230929150002.264424-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230929150002.264424-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc4
X-PR-Tracked-Commit-Id: 0b207d02bd9ab8dcc31b262ca9f60dbc1822500d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14c06b913d4a11b50351ef5bcb3f112247f647f3
Message-Id: <169603195239.31385.5839391457594737397.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 23:59:12 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 16:59:36 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14c06b913d4a11b50351ef5bcb3f112247f647f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
