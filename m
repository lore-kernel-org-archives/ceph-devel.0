Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C072C433EF
	for <ceph-devel@archiver.kernel.org>; Wed,  8 Sep 2021 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5461176
	for <ceph-devel@archiver.kernel.org>; Wed,  8 Sep 2021 23:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbhIHXc6 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 8 Sep 2021 19:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237396AbhIHXc5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:32:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6F1FC60F01;
        Wed,  8 Sep 2021 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631143909;
        bh=8YNsHB9ie6cIlG6DY5fN4BF38MXC0q4FMufCr94DyEs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SWmkda13r7sy9oeigOEGUl2gbZS124DZG5b30GShLyS7BsIQbjf1XSBVVy7n9yjma
         KRxiOt2eLmjPeaSMdWY7rrqZ5/OYg+y24bZ3Ofb20rESLrKTV3Phc0lWVU2OuqjwNx
         7qTgRz4SgMndc+StktIsBZmFvFG13z2L63yXfTj+XDyftuYZXIs6zVXFThKmsoZenv
         DfWcC+PxDlNShD2KztKtzP/qElDtbBvK+3gWd8jGoiEqyI3hb/QVbVelMt6nkaCJQk
         l1ozERMNk79F6LOFD4z0sbo/1m+xNQlTC2UTEVZJ7JbRhJWEZyhyULjaaz+GjplMqr
         RNAobtRLiJINg==
Subject: Re: [GIT PULL] Ceph updates for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210908170257.18646-1-idryomov@gmail.com>
References: <20210908170257.18646-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210908170257.18646-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.15-rc1
X-PR-Tracked-Commit-Id: 05a444d3f90a3c3e6362e88a1bf13e1a60f8cace
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a05abd0c93841a7bbcf777ec1677a1ad9155793
Message-Id: <163114390942.13056.7790327852328463038.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:31:49 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Wed,  8 Sep 2021 19:02:57 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a05abd0c93841a7bbcf777ec1677a1ad9155793

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
