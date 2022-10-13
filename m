Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFEFC4332F
	for <ceph-devel@archiver.kernel.org>; Thu, 13 Oct 2022 18:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiJMS1v (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 13 Oct 2022 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJMS11 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2022 14:27:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B318813A;
        Thu, 13 Oct 2022 11:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DA16B82069;
        Thu, 13 Oct 2022 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42DD8C43140;
        Thu, 13 Oct 2022 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665684022;
        bh=QxYmwd2P4zpfKKPr5fRbWFo8aNAsnCmNXBqv1y81pSw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HUa97AWBEpVNYg94S6zh5Sejxl6a+znT6gwuR6L9JJJLem99Je1l/WqlP5K3YfWrE
         KSd3YhgpTEQ0hZAQsapEhxrp6vF7zjKGpVn5Vm6Pqw9UD/14I1q9aWBzIVoA04j90M
         NqLK2LrLVBUWyTNENOHHFzkEZ93wKObH584Epv/WP3aJrhynIfXUFHIm5t7ExfJn5A
         xMALFm3jxefonFFmhJ2uU+xC3CER4VXYewRVgp5FOTz+5DC9cTyu1kcNnWDBoGXzqx
         sQfdeo+R0KtfL9miVnZeGxxLDoYpPRMVhN4EON7Y8iGu1KV9ylKhIePZm23fybVBbb
         /AsAg1Ze5sMWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EB83E29F30;
        Thu, 13 Oct 2022 18:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221013160153.100941-1-idryomov@gmail.com>
References: <20221013160153.100941-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221013160153.100941-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.1-rc1
X-PR-Tracked-Commit-Id: 71cf0c1c4f9f8e42c84ca53a5ca7091e4eea7f6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 524d0c68826bc1adf9d1946e540eb4f7b16699a7
Message-Id: <166568402218.7515.16505627457789583242.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 18:00:22 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Thu, 13 Oct 2022 18:01:53 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/524d0c68826bc1adf9d1946e540eb4f7b16699a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
