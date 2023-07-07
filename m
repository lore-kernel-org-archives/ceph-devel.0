Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B02EB64DA
	for <ceph-devel@archiver.kernel.org>; Fri,  7 Jul 2023 22:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGGW1A (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGGW06 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jul 2023 18:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40BE213D;
        Fri,  7 Jul 2023 15:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3614061A17;
        Fri,  7 Jul 2023 22:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98C79C433C8;
        Fri,  7 Jul 2023 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688768815;
        bh=XNuU257g7/eY+3nrxY6lelx95ViXarOL3czOsm6+DMA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QmxmCihZDu6lfLMA0avTtk2GVxxhGXfcKKjXS1i7FxG/UgQdnq+XiKgohlHSzthV6
         b4Cfz0iA8jY5lTgJdReX4Q9EACnXISS/2/LXM/3VcMEAZk6kecnGCTaJDwlcmwMMYX
         2osMKWhxiVXkz/JVLBSYI0qycQHcNN6Zg5+nZz7MNVn726G0oRyegaCjeCKApxWjmh
         o/sTOiV4izJCmME/605uzdCIYqloNrJFIBZx9rIqzmfWn9QYsHf0U3L3gR6R2nmLre
         KJirvCXqLZeZSxjzYqMW2ay9tnyf/90eANrs7kHkJdUDm4LQ+KNmm9LRiUzZbeRMI9
         UtqZ8JhWasBSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 847A6C4167B;
        Fri,  7 Jul 2023 22:26:55 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230707161658.372600-1-idryomov@gmail.com>
References: <20230707161658.372600-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230707161658.372600-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc1
X-PR-Tracked-Commit-Id: 257e6172ab36ebbe295a6c9ee9a9dd0fe54c1dc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3290badd1bb8c9ea91db5c0b2e1a635178119856
Message-Id: <168876881552.27307.16810972206187815653.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 22:26:55 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Fri,  7 Jul 2023 18:16:58 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3290badd1bb8c9ea91db5c0b2e1a635178119856

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
