Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382CC433F5
	for <ceph-devel@archiver.kernel.org>; Fri, 20 May 2022 18:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiETSga (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 20 May 2022 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347361AbiETSg2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2022 14:36:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D54D9EC;
        Fri, 20 May 2022 11:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2174FB80DDE;
        Fri, 20 May 2022 18:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEC68C385A9;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071782;
        bh=DXVqJd3SRjpi6b2quKUyVAoo9yDXVPV8JWxe0CSJUJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GeZCKxrbjqylsu5rmPP0qZbv9/nbAU00GYd124zXAqMjPb3hS8vms4XyEOIUekHJZ
         tkMnArvhyhdKR7YYIhTPi3oE4nZff9rs2yTJ6P3ZBWEv75E27ZbrckcCL8om0qMedt
         vD7prlJkyagTclOWcXMz7mSSGkLqgmH7Chk25kt+54TT7+RUbuLsJrMqm6jSr9aLn9
         H4riyLYSEtE8fbK884uszfryDm2Nm2hBn/1q3whfX3ai0wPv2D21wDXP85I34JzIY8
         NFUVFSk68ZCvJ48s7r7KtesJTgeekhkUIkbk2ufirDWZpolcoIvOUTYw66e0QEB3Hw
         fEdcioRz7B3pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C686FF0383D;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 5.18-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520152306.10106-1-idryomov@gmail.com>
References: <20220520152306.10106-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520152306.10106-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc8
X-PR-Tracked-Commit-Id: d0bb883c6355bcb2cc149fb4d5c3b28ccd327a5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b851c1f8e02a16e86ad8f2c18aa50fd017a8ad3b
Message-Id: <165307178280.15282.5533681081228162312.pr-tracker-bot@kernel.org>
Date:   Fri, 20 May 2022 18:36:22 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 17:23:06 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b851c1f8e02a16e86ad8f2c18aa50fd017a8ad3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
