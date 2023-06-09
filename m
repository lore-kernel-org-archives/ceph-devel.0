Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C7C7EE29
	for <ceph-devel@archiver.kernel.org>; Fri,  9 Jun 2023 18:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFISTK (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 9 Jun 2023 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjFISTE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2023 14:19:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795453A85;
        Fri,  9 Jun 2023 11:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 051AC65382;
        Fri,  9 Jun 2023 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66D3AC433D2;
        Fri,  9 Jun 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686334740;
        bh=jKjAR9GEHvxGG6NfUSOcNajJvnahJZUoRzOMQocjlJc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W7EXqlYxi3dURunNdTJtDz5gDHhZVZZO5eoR4zyOPIdV4HGDYrsf3VQXTqJuYcfmK
         QNkdWNLFF/Dv7WRuqcMPVfjWj/131LzzlnWX3FjvucFnXI8dx2vUhORW0SSLQcQY8/
         SxuUNPPcn4AWLkKX77zkDNalV+nf8YqnH7WeWr8SFPimDt+i3VobEUox6garqgxSAk
         bdAVAHeXyD+6CjhYKm+36oDujKjAVP1LwI9DskjCnoFMfEmIIStesa8T1XfRc7JR19
         AV5hmyAQYO2Ft3aBSh/4BN6rCou4IQty6CKK8T7H+bQ80Ulu426YfZAbcDZJLrSKr6
         mFlAM2oh467TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 505FDC395F8;
        Fri,  9 Jun 2023 18:19:00 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230609163142.16428-1-idryomov@gmail.com>
References: <20230609163142.16428-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230609163142.16428-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc6
X-PR-Tracked-Commit-Id: 409e873ea3c1fd3079909718bbeb06ac1ec7f38b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e8c948b3f09b19e3883517e10a3d5ffa9899f84
Message-Id: <168633474032.10395.70125928056931807.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 18:19:00 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Fri,  9 Jun 2023 18:31:42 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e8c948b3f09b19e3883517e10a3d5ffa9899f84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
